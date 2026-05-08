<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Мои показатели" selectedPage="1">
    <div class="container max-w-6xl mx-auto px-4 pt-6 pb-16">
        <@messageMacros.message />

        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
            <div class="grid grid-cols-[1fr_auto] gap-2 w-full">
                <div class="relative">
                    <input type="text" id="searchInput"
                           placeholder="Поиск по показателю..."
                           value="${search!''}"
                           class="w-full pl-9 pr-4 py-2 bg-white border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 transition-all"/>
                    <svg class="absolute left-3 top-2.5 w-4 h-4 text-slate-400 pointer-events-none" fill="none"
                         stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <div class="flex gap-1">
                    <button id="expandAll"
                            class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg transition-colors"
                            title="Развернуть все">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                    </button>
                    <button id="collapseAll"
                            class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg transition-colors"
                            title="Свернуть все">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <div id="emptyState" class="<#if page.content()?size != 0>hidden</#if>">
            <div class="bg-white rounded-xl border border-slate-200 p-12 text-center max-w-2xl mx-auto">
                <div class="flex flex-col items-center">
                    <div class="w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center mb-4">
                        <svg class="w-8 h-8 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                    </div>
                    <h3 class="text-slate-800 font-semibold">Нет записей</h3>
                    <p id="emptyStateMessage" class="text-slate-500 text-sm mt-1 mb-6">
                        <#if search?has_content>
                            По запросу «${search}» ничего не найдено
                        <#else>
                            Вы еще не добавили ни одного измерения
                        </#if>
                    </p>
                    <#if !search?has_content>
                        <a href="/measurements/add"
                           class="text-emerald-600 hover:text-emerald-700 font-semibold text-sm">
                            Добавить первый показатель →
                        </a>
                    </#if>
                </div>
            </div>
        </div>

        <div id="measurementGroups" class="space-y-2">
            <#if page.content()?size != 0>
                <#include "groups.ftl">
            </#if>
            <div id="scroll-trigger"
                 class="py-4 text-center text-[10px] text-slate-400 font-mono uppercase tracking-widest"
                 style="<#if !page.hasNext()>display:none</#if>">
            </div>
        </div>
    </div>

    <div id="pagination-data"
         data-next-cursor="${page.nextCursor()!''}"
         data-has-next="${page.hasNext()?c}"
         data-page-size="${pageSize}"
         data-search="${search!''}">
    </div>

    <style>
        details[open] .chevron-icon {
            transform: rotate(180deg);
        }

        .measurement-group summary::-webkit-details-marker {
            display: none;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const expandAllBtn = document.getElementById('expandAll');
            const collapseAllBtn = document.getElementById('collapseAll');
            const searchInput = document.getElementById('searchInput');
            const container = document.getElementById('measurementGroups');
            const paginationData = document.getElementById('pagination-data');
            const scrollTrigger = document.getElementById('scroll-trigger');
            const emptyState = document.getElementById('emptyState');
            const emptyStateMessage = document.getElementById('emptyStateMessage');

            if (!container || !paginationData || !scrollTrigger) return;

            let nextCursor = paginationData.dataset.nextCursor || null;
            let hasNext = paginationData.dataset.hasNext === 'true';
            const pageSize = parseInt(paginationData.dataset.pageSize, 10) || 10;
            let currentSearch = paginationData.dataset.search || '';
            let loading = false;
            let debounceTimer = null;

            // --- Expand / Collapse all ---
            expandAllBtn?.addEventListener('click', () => {
                container.querySelectorAll('.measurement-group').forEach(d => d.open = true);
            });
            collapseAllBtn?.addEventListener('click', () => {
                container.querySelectorAll('.measurement-group').forEach(d => d.open = false);
            });

            // --- Поведение групп при toggle ---
            function attachGroupBehaviour(root) {
                root.querySelectorAll('.measurement-group').forEach(details => {
                    // Пропускаем уже инициализированные
                    if (details.dataset.behaviourAttached) return;
                    details.dataset.behaviourAttached = 'true';

                    details.addEventListener('toggle', () => {
                        details.classList.toggle('mb-4', details.open);
                        details.classList.toggle('rounded-md', !details.open);
                        details.classList.toggle('rounded-xl', details.open);
                        details.querySelector('summary').classList.toggle('bg-slate-50', details.open);
                    });
                    if (details.open) {
                        details.classList.add('mb-4', 'rounded-xl');
                        details.classList.remove('rounded-md');
                        details.querySelector('summary').classList.add('bg-slate-50');
                    }
                });
            }

            attachGroupBehaviour(container);

            // --- Empty state ---
            function setEmptyState(isEmpty, search) {
                if (!emptyState) return;
                emptyState.classList.toggle('hidden', !isEmpty);
                if (isEmpty && emptyStateMessage) {
                    emptyStateMessage.textContent = search
                        ? `По запросу «${search}» ничего не найдено`
                        : 'Вы еще не добавили ни одного измерения';
                }
            }

            // --- Загрузка страницы ---
            async function loadPage(cursor, search, replace) {
                if (loading) return;
                loading = true;

                if (replace) {
                    scrollTrigger.style.display = 'none';
                } else {
                    scrollTrigger.innerText = 'Загрузка...';
                    scrollTrigger.style.display = '';
                }

                try {
                    const url = new URL(window.location.origin + '/measurements');
                    url.searchParams.set('pageSize', pageSize);
                    if (cursor) url.searchParams.set('cursor', cursor);
                    if (search) url.searchParams.set('search', search);

                    const response = await fetch(url, {
                        headers: {'X-Requested-With': 'XMLHttpRequest'}
                    });

                    if (!response.ok) throw new Error('Ошибка загрузки');

                    const html = await response.text();

                    if (replace) {
                        container.querySelectorAll('.measurement-group').forEach(el => el.remove());
                    }

                    scrollTrigger.insertAdjacentHTML('beforebegin', html);
                    attachGroupBehaviour(container);

                    nextCursor = response.headers.get('X-Next-Cursor') || null;
                    hasNext = response.headers.get('X-Has-Next') === 'true';

                    const hasGroups = container.querySelectorAll('.measurement-group').length > 0;
                    setEmptyState(!hasGroups, search);

                    if (!hasNext) {
                        scrollTrigger.style.display = 'none';
                    } else {
                        scrollTrigger.innerText = '';
                        scrollTrigger.style.display = '';
                    }
                } catch (error) {
                    console.error('Ошибка загрузки:', error);
                    scrollTrigger.innerText = 'Ошибка загрузки';
                } finally {
                    loading = false;

                    if (hasNext) {
                        const rect = scrollTrigger.getBoundingClientRect();
                        const isVisible = rect.top < window.innerHeight && rect.bottom >= 0;
                        if (isVisible) {
                            loadPage(nextCursor, currentSearch, false);
                        }
                    }
                }
            }

            // --- Поиск с debounce 350ms ---
            searchInput?.addEventListener('input', () => {
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(() => {
                    currentSearch = searchInput.value.trim();
                    nextCursor = null;
                    hasNext = false;
                    loadPage(null, currentSearch, true);
                }, 350);
            });
            // --- Infinite scroll ---
            const observer = new IntersectionObserver((entries) => {
                for (const entry of entries) {
                    if (entry.isIntersecting && hasNext && !loading) {
                        loadPage(nextCursor, currentSearch, false);
                    }
                }
            }, {threshold: 0.1});

            observer.observe(scrollTrigger);

            if (hasNext) {
                const rect = scrollTrigger.getBoundingClientRect();
                const isVisible = rect.top < window.innerHeight && rect.bottom >= 0;
                if (isVisible) {
                    loadPage(nextCursor, currentSearch, false);
                }
            }
        });
    </script>
</@layoutMacros.layout>