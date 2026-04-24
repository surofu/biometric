<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="Медицинские показатели" mobileTitle="Справочник" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto p-4 pb-20">
            <@messageMacros.message />
            <@pageHeaderMacros.pageHeader
            title="Медицинские показатели"
            subtitle="Справочник"
            backUrl="/reference"
            />

            <#if indicators?? && indicators?has_content>

                <!-- Disclaimer -->
                <div class="my-4 p-4 bg-emerald-50/40 rounded-2xl border border-emerald-100">
                    <div class="flex gap-3">
                        <svg class="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-xs text-slate-500 leading-relaxed">
                            Референсные значения носят ориентировочный характер. Разные лаборатории могут использовать
                            различные референсные интервалы.
                        </p>
                    </div>
                </div>

                <!-- Category filter -->
                <#if categories?? && categories?has_content>
                    <div class="flex gap-2 flex-wrap mb-4">
                        <button onclick="filterCategory(null)"
                                id="filter-all"
                                class="filter-btn px-3 py-1.5 rounded-lg text-xs font-semibold border border-emerald-500 bg-emerald-500 text-white transition-all">
                            Все
                        </button>
                        <#list categories as cat>
                            <button onclick="filterCategory('${cat.id}')"
                                    id="filter-${cat.id}"
                                    class="filter-btn px-3 py-1.5 rounded-lg text-xs font-semibold border border-slate-200 text-slate-600 hover:border-emerald-300 hover:text-emerald-700 transition-all">
                                ${cat.name}
                            </button>
                        </#list>
                    </div>
                </#if>

                <!-- Search -->
                <div class="relative mb-4">
                    <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none"
                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    <label>
                        <input type="text"
                               id="indicator-search"
                               placeholder="Поиск по названию..."
                               oninput="applyFilters()"
                               class="w-full pl-9 pr-4 py-2.5 text-sm border border-slate-200 rounded-xl bg-white text-slate-800 placeholder-slate-400 focus:outline-none focus:border-emerald-400 transition-colors">
                    </label>
                </div>

                <!-- Count -->
                <div class="mb-4">
                    <span class="px-2.5 py-1 bg-slate-100 rounded-lg text-xs font-semibold text-slate-500"
                          id="indicators-count">${indicators?size} показателей</span>
                </div>

                <!-- List -->
                <div class="space-y-2" id="indicators-list">
                    <#list indicators as ind>
                        <a href="/reference/indicators/${ind.id}"
                           class="indicator-row group flex items-start justify-between gap-3 p-4 border border-slate-100 rounded-xl bg-white hover:border-emerald-200 hover:bg-slate-50/30 transition-all duration-150"
                           data-category="${ind.categoryId}"
                           data-name="${ind.name?lower_case}">
                            <div class="flex-1 min-w-0">
                                <div class="flex items-center gap-2 flex-wrap">
                                    <h3 class="font-semibold text-slate-800 text-sm group-hover:text-emerald-700 transition-colors">${ind.name}</h3>
                                    <#if ind.unit?? && ind.unit?has_content>
                                        <span class="text-xs text-slate-400 font-mono">${ind.unit}</span>
                                    </#if>
                                </div>
                                <#if ind.categoryName?? && ind.categoryName?has_content>
                                    <p class="text-xs text-slate-400 mt-0.5">${ind.categoryName}</p>
                                </#if>
                            </div>
                            <div class="flex items-center gap-3 shrink-0">
                                <div class="text-right">
                                    <#if ind.referenceMin?? && ind.referenceMax??>
                                        <span class="inline-flex items-center px-2.5 py-1 bg-emerald-50 rounded-lg text-xs font-semibold text-emerald-700">
                                            ${ind.referenceMin?string["0.##"]} – ${ind.referenceMax?string["0.##"]}
                                        </span>
                                        <p class="text-xs text-slate-400 mt-1">референс</p>
                                    <#elseif ind.referenceMin??>
                                        <span class="inline-flex items-center px-2.5 py-1 bg-emerald-50 rounded-lg text-xs font-semibold text-emerald-700">
                                            ≥ ${ind.referenceMin?string["0.##"]}
                                        </span>
                                        <p class="text-xs text-slate-400 mt-1">референс</p>
                                    <#elseif ind.referenceMax??>
                                        <span class="inline-flex items-center px-2.5 py-1 bg-emerald-50 rounded-lg text-xs font-semibold text-emerald-700">
                                            ≤ ${ind.referenceMax?string["0.##"]}
                                        </span>
                                        <p class="text-xs text-slate-400 mt-1">референс</p>
                                    </#if>
                                </div>
                                <svg class="w-4 h-4 text-slate-300 group-hover:text-emerald-500 transition-colors"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                        </a>
                    </#list>
                </div>

                <!-- Empty search state -->
                <div id="no-results" class="hidden text-center py-12">
                    <p class="text-slate-400 text-sm">Ничего не найдено</p>
                </div>

            <#else>
                <div class="text-center py-16">
                    <div class="flex items-center justify-center w-12 h-12 bg-slate-50 rounded-2xl mx-auto mb-4">
                        <svg class="w-6 h-6 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                    </div>
                    <p class="text-slate-400 text-sm">Показатели не найдены</p>
                </div>
            </#if>
        </div>
    </div>

    <script>
        let activeCategory = null;

        // Применить фильтр из URL (?categoryId=...) при загрузке страницы
        (function () {
            const params = new URLSearchParams(window.location.search);
            const catId = params.get('categoryId');
            if (catId) {
                activeCategory = catId;
                document.querySelectorAll('.filter-btn').forEach(b => {
                    b.classList.remove('border-emerald-500', 'bg-emerald-500', 'text-white');
                    b.classList.add('border-slate-200', 'text-slate-600');
                });
                const btn = document.getElementById('filter-' + catId);
                if (btn) {
                    btn.classList.add('border-emerald-500', 'bg-emerald-500', 'text-white');
                    btn.classList.remove('border-slate-200', 'text-slate-600');
                }
                applyFilters();
            }
        })();

        function filterCategory(categoryId) {
            activeCategory = categoryId;
            document.querySelectorAll('.filter-btn').forEach(b => {
                b.classList.remove('border-emerald-500', 'bg-emerald-500', 'text-white');
                b.classList.add('border-slate-200', 'text-slate-600');
            });
            const activeBtn = categoryId === null
                ? document.getElementById('filter-all')
                : document.getElementById('filter-' + categoryId);
            if (activeBtn) {
                activeBtn.classList.add('border-emerald-500', 'bg-emerald-500', 'text-white');
                activeBtn.classList.remove('border-slate-200', 'text-slate-600');
            }
            applyFilters();
        }

        function applyFilters() {
            const query = (document.getElementById('indicator-search').value || '').toLowerCase().trim();
            const rows = document.querySelectorAll('.indicator-row');
            const countEl = document.getElementById('indicators-count');
            const noResults = document.getElementById('no-results');
            let visible = 0;

            rows.forEach(row => {
                const matchCat = activeCategory === null || row.dataset.category === activeCategory;
                const matchSearch = !query || row.dataset.name.includes(query);
                if (matchCat && matchSearch) {
                    row.style.display = '';
                    visible++;
                } else {
                    row.style.display = 'none';
                }
            });

            if (countEl) countEl.textContent = visible + ' показателей';
            if (noResults) noResults.classList.toggle('hidden', visible > 0);
        }
    </script>
</@layoutMacros.layout>
