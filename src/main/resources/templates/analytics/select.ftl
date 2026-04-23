<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="Выбор показателя для аналитики" selectedPage="3">
    <div class="container max-w-2xl mx-auto px-4 pb-18">

        <div class="sticky top-0 z-10 bg-white pt-8 pb-6 border-b border-slate-200">
            <@messageMacros.message />
            <@pageHeaderMacros.pageHeader title="Выбор показателя для аналитики"/>

            <#if indicators?has_content>
                <div class="relative sm:px-4 mt-6">
                    <svg class="absolute left-3 sm:left-7 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400 pointer-events-none"
                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z"/>
                    </svg>
                    <label>
                        <input type="search" id="searchInput" placeholder="Поиск по названию..."
                               class="w-full pl-9 pr-4 py-2 text-sm border border-slate-200 rounded-md
                                  focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                    </label>
                </div>
            </#if>
        </div>

        <div class="space-y-3 mt-6 sm:px-4" id="indicatorGrid">
            <#list indicators as indicator>
                <a href="/analytics/${indicator.id}"
                   data-name="${indicator.name?lower_case?js_string}"
                   class="indicator-item flex items-center justify-between p-4 bg-white border border-slate-200 rounded-lg hover:border-emerald-300 hover:bg-emerald-50/30 transition-all group">
                    <span class="font-medium text-gray-700 group-hover:text-gray-900 text-sm">${indicator.name}</span>
                    <svg class="w-5 h-5 text-slate-300 group-hover:text-emerald-400 transform group-hover:translate-x-1 transition-all shrink-0"
                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                </a>
            <#else>
                <div class="col-span-full bg-white rounded-lg border border-slate-200 p-8 text-center">
                    <div class="flex flex-col items-center gap-3">
                        <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                        <span class="text-lg text-gray-600">Нет доступных показателей</span>
                        <a href="/measurements/add" class="text-emerald-600 hover:text-emerald-800 font-medium">
                            Добавить первый показатель →
                        </a>
                    </div>
                </div>
            </#list>
        </div>

        <div id="emptySearch" class="hidden mt-4 mx-4 bg-white rounded-lg border border-slate-200 p-8 text-center">
            <svg class="w-12 h-12 text-gray-300 mx-auto mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                      d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z"/>
            </svg>
            <p class="text-gray-500 text-sm">Ничего не найдено</p>
        </div>
    </div>

    <script>
        (function () {
            const searchInput = document.getElementById('searchInput');
            if (!searchInput) return;

            const items = document.querySelectorAll('.indicator-item');
            const emptySearch = document.getElementById('emptySearch');

            searchInput.addEventListener('input', function () {
                const query = this.value.trim().toLowerCase();
                let visibleCount = 0;

                items.forEach(function (item) {
                    const name = item.dataset.name || '';
                    const match = name.includes(query);
                    item.classList.toggle('hidden', !match);
                    if (match) visibleCount++;
                });

                emptySearch.classList.toggle('hidden', visibleCount > 0);
            });
        })();
    </script>
</@layoutMacros.layout>