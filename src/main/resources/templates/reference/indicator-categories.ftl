<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Категории показателей — Биометрик" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
            <@messageMacros.message />

            <!-- Header -->
            <div class="flex items-center gap-3 mb-6">
                <a href="/reference"
                   class="flex items-center justify-center w-8 h-8 rounded-lg border border-slate-200 hover:bg-slate-50 transition-colors">
                    <svg class="w-4 h-4 text-slate-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                    </svg>
                </a>
                <div>
                    <p class="text-xs text-slate-400 leading-none mb-1">Справочник</p>
                    <h1 class="text-xl font-bold text-slate-900 leading-none">Категории показателей</h1>
                </div>
            </div>

            <#if categories?? && categories?has_content>

                <!-- Info -->
                <div class="mb-5 p-4 bg-emerald-50/40 rounded-2xl border border-emerald-100">
                    <div class="flex gap-3">
                        <svg class="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-xs text-slate-500 leading-relaxed">
                            Выберите категорию, чтобы просмотреть входящие в неё показатели с референсными значениями.
                        </p>
                    </div>
                </div>

                <!-- Search -->
                <div class="relative mb-4">
                    <svg class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none"
                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    <label>
                        <input type="text"
                               id="category-search"
                               placeholder="Поиск по названию..."
                               oninput="searchCategories(this.value)"
                               class="w-full pl-9 pr-4 py-2.5 text-sm border border-slate-200 rounded-xl bg-white text-slate-800 placeholder-slate-400 focus:outline-none focus:border-emerald-400 transition-colors">
                    </label>
                </div>

                <!-- Count -->
                <div class="mb-4">
                    <span class="px-2.5 py-1 bg-slate-100 rounded-lg text-xs font-semibold text-slate-500"
                          id="categories-count">${categories?size} категорий</span>
                </div>

                <!-- List -->
                <div class="space-y-2" id="categories-list">
                    <#list categories as cat>
                        <a href="/reference/indicator-categories/${cat.id}"
                           class="category-item group flex items-start gap-4 p-5 border border-slate-100 rounded-xl bg-white hover:border-emerald-200 hover:bg-slate-50/30 transition-all duration-150"
                           data-name="${cat.name?lower_case}">
                            <div class="shrink-0 w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors">
                                <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor"
                                     viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>
                                </svg>
                            </div>
                            <div class="flex-1 min-w-0">
                                <div class="flex items-center justify-between gap-2">
                                    <h2 class="font-bold text-slate-800 text-sm group-hover:text-emerald-700 transition-colors">${cat.name}</h2>
                                    <svg class="w-4 h-4 text-slate-300 group-hover:text-emerald-500 transition-colors shrink-0"
                                         fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M9 5l7 7-7 7"/>
                                    </svg>
                                </div>
                                <#if cat.description?? && cat.description?has_content>
                                    <p class="text-xs text-slate-500 mt-1 leading-relaxed">${cat.description}</p>
                                </#if>
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
                                  d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>
                        </svg>
                    </div>
                    <p class="text-slate-400 text-sm">Категории не найдены</p>
                </div>
            </#if>
        </div>
    </div>

    <script>
        function searchCategories(query) {
            const items = document.querySelectorAll('.category-item');
            const noResults = document.getElementById('no-results');
            const countEl = document.getElementById('categories-count');
            const q = query.toLowerCase().trim();
            let visible = 0;

            items.forEach(item => {
                if (!q || item.dataset.name.includes(q)) {
                    item.style.display = '';
                    visible++;
                } else {
                    item.style.display = 'none';
                }
            });

            if (countEl) countEl.textContent = visible + ' категорий';
            if (noResults) noResults.classList.toggle('hidden', visible > 0);
        }
    </script>
</@layoutMacros.layout>
