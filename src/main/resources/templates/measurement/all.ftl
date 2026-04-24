<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Мои показатели" selectedPage="1">
    <div class="container max-w-6xl mx-auto px-4 pt-6 pb-16">
        <@messageMacros.message />

        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
            <div class="flex items-center gap-2 w-full sm:w-auto">
                <a href="/measurements/add"
                   class="flex-1 sm:flex-none bg-emerald-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-emerald-700 transition-colors flex items-center justify-center gap-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>
                    Добавить
                </a>
                <div class="flex gap-1">
                    <button id="expandAll" class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg transition-colors" title="Развернуть все">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
                    </button>
                    <button id="collapseAll" class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg transition-colors" title="Свернуть все">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7" /></svg>
                    </button>
                </div>
            </div>
        </div>

        <#if page.content()?size == 0>
            <div class="bg-white rounded-xl border border-slate-200 p-12 text-center max-w-2xl mx-auto">
                <div class="flex flex-col items-center">
                    <div class="w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center mb-4">
                        <svg class="w-8 h-8 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                    </div>
                    <h3 class="text-slate-800 font-semibold">Нет записей</h3>
                    <p class="text-slate-500 text-sm mt-1 mb-6">Вы еще не добавили ни одного измерения</p>
                    <a href="/measurements/add" class="text-emerald-600 hover:text-emerald-700 font-semibold text-sm">Добавить первый показатель →</a>
                </div>
            </div>
        <#else>
            <div id="measurementGroups" class="space-y-2">
                <#include "groups.ftl">
                <div id="scroll-trigger" class="py-4 text-center text-[10px] text-slate-400 font-mono uppercase tracking-widest"></div>
            </div>
        </#if>
    </div>

    <div id="pagination-data" data-next-cursor="${page.nextCursor()!''}" data-has-next="${page.hasNext()?c}" data-page-size="${pageSize}"></div>

    <style>
        details[open] .chevron-icon { transform: rotate(180deg); }
        .measurement-group summary::-webkit-details-marker { display: none; }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const expandAllBtn = document.getElementById('expandAll');
            const collapseAllBtn = document.getElementById('collapseAll');
            const details = document.querySelectorAll('.measurement-group');

            if (expandAllBtn) {
                expandAllBtn.addEventListener('click', () => {
                    details.forEach(detail => detail.open = true);
                });
            }
            if (collapseAllBtn) {
                collapseAllBtn.addEventListener('click', () => {
                    details.forEach(detail => detail.open = false);
                });
            }

            const container = document.getElementById('measurementGroups');
            const paginationData = document.getElementById('pagination-data');
            const scrollTrigger = document.getElementById('scroll-trigger');

            if (!container || !paginationData || !scrollTrigger) return;

            let nextCursor = paginationData.dataset.nextCursor || null;
            let hasNext = paginationData.dataset.hasNext === 'true';
            const pageSize = parseInt(paginationData.dataset.pageSize, 20) || 20;
            let loading = false;

            if (!hasNext) {
                scrollTrigger.style.display = 'none';
            }

            async function loadNextPage() {
                if (!hasNext || loading || !nextCursor) return;

                loading = true;
                scrollTrigger.innerText = 'Загрузка...';

                try {
                    const url = new URL(window.location.href);
                    url.searchParams.set('cursor', nextCursor);
                    url.searchParams.set('pageSize', pageSize);

                    const response = await fetch(url, {
                        headers: {
                            'X-Requested-With': 'XMLHttpRequest'
                        }
                    });

                    if (!response.ok) {
                        throw new Error('Ошибка загрузки');
                    }

                    const html = await response.text();
                    // Вставляем новые группы перед триггером
                    scrollTrigger.insertAdjacentHTML('beforebegin', html);

                    container.querySelectorAll('.measurement-group').forEach(details => {
                        details.addEventListener('toggle', () => {
                            details.classList.toggle('mb-4', details.open)
                            details.classList.toggle('rounded-md', !details.open)
                            details.classList.toggle('rounded-xl', details.open)
                            details.querySelector("summary").classList.toggle('bg-slate-50', details.open)
                        })

                        if (details.open) {
                            details.classList.add('mb-4');
                            details.classList.remove('rounded-md')
                            details.classList.add('rounded-xl')
                            details.querySelector("summary").classList.add('bg-slate-50')
                        }
                    });

                    // Обновляем курсор и флаг из заголовков ответа
                    nextCursor = response.headers.get('X-Next-Cursor') || null;
                    hasNext = response.headers.get('X-Has-Next') === 'true';

                    if (!hasNext) {
                        scrollTrigger.style.display = 'none';
                    } else {
                        scrollTrigger.innerText = '';
                    }
                } catch (error) {
                    console.error('Ошибка загрузки следующей страницы:', error);
                    scrollTrigger.innerText = 'Ошибка загрузки';
                } finally {
                    loading = false;
                }
            }

            const observer = new IntersectionObserver((entries) => {
                for (let entry of entries) {
                    if (entry.isIntersecting && hasNext && !loading) {
                        loadNextPage();
                    }
                }
            }, {threshold: 0.1});

            observer.observe(scrollTrigger);
        });
    </script>
</@layoutMacros.layout>