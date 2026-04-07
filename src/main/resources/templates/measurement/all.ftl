<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Мои показатели" selectedPage="1">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-16">
        <div class="px-4 sm:px-6 pb-4 border-b border-gray-200">
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800">
                Мои показатели
            </h1>
        </div>

        <div class="flex justify-between items-start sm:items-center gap-4 w-full py-6">
            <a href="/measurements/new"
               class="w-full sm:w-auto px-4 py-2 bg-emerald-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-emerald-700 focus:outline-none transition-colors text-center">
                Добавить показатель
            </a>
            <div class="flex gap-2">
                <button id="expandAll"
                        class="p-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700 transition-colors keysetCursor-pointer"
                        title="Развернуть все">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path fill="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 2 L18 10 L6 10 Z"/>
                        <path fill="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 22 L18 14 L6 14 Z"/>
                    </svg>
                </button>
                <button id="collapseAll"
                        class="p-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700 transition-colors keysetCursor-pointer"
                        title="Свернуть все">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path fill="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 10 L18 2 L6 2 Z"/>
                        <path fill="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 14 L18 22 L6 22 Z"/>
                    </svg>
                </button>
            </div>
        </div>

        <#if page.content()?size == 0>
            <div class="bg-white rounded-lg border border-gray-200 p-8 text-center">
            <div class="bg-white rounded-lg border border-gray-200 p-8 text-center">
                <div class="flex flex-col items-center space-y-3">
                    <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                              d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                    </svg>
                    <span class="text-lg text-gray-600">Нет добавленных показателей</span>
                    <a href="/measurements/new" class="text-blue-600 hover:text-blue-800 font-medium">
                        Добавить первый показатель →
                    </a>
                </div>
            </div>
        <#else>
            <div id="measurementGroups" class="space-y-3">
                <#include "groups.ftl">
                <div id="scroll-trigger" style="height: 10px; background: transparent;"></div>
            </div>
        </#if>
    </div>

    <div id="pagination-data"
         data-next-cursor="${page.nextCursor()!''}"
         data-has-next="${page.hasNext()?c}"
         data-page-size="${pageSize}">
    </div>

    <style>
        details[open] .chevron-icon {
            transform: rotate(180deg);
        }
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