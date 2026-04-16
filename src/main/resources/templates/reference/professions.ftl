<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Профессии и медосмотры — Биометрик" selectedPage="5">
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
                    <h1 class="text-xl font-bold text-slate-900 leading-none">Профессии и медосмотры</h1>
                </div>
            </div>

            <#if professions?? && professions?has_content>

                <!-- Info -->
                <div class="mb-5 p-4 bg-emerald-50/40 rounded-2xl border border-emerald-100">
                    <div class="flex gap-3">
                        <svg class="w-4 h-4 text-emerald-600 shrink-0 mt-0.5" fill="none" stroke="currentColor"
                             viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-xs text-slate-500 leading-relaxed">
                            Периодичность медосмотров установлена приказом Минздрава. Фактическое расписание уточняйте у
                            работодателя или в медицинском учреждении.
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
                               id="profession-search"
                               placeholder="Поиск по названию..."
                               oninput="searchProfessions(this.value)"
                               class="w-full pl-9 pr-4 py-2.5 text-sm border border-slate-200 rounded-xl bg-white text-slate-800 placeholder-slate-400 focus:outline-none focus:border-emerald-400 transition-colors">
                    </label>
                </div>

                <!-- Count -->
                <div class="mb-4">
                    <span class="px-2.5 py-1 bg-slate-100 rounded-lg text-xs font-semibold text-slate-500"
                          id="professions-count">${professions?size} профессий</span>
                </div>

                <!-- List -->
                <div class="space-y-2" id="professions-list">
                    <#list professions as prof>
                        <a href="/reference/professions/${prof.id}"
                           class="profession-item group flex items-center gap-4 p-4 border border-slate-100 rounded-xl bg-white hover:border-emerald-200 hover:bg-slate-50/30 transition-all duration-150"
                           data-name="${prof.name?lower_case}">
                            <div class="shrink-0 w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors">
                                <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor"
                                     viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                </svg>
                            </div>
                            <h3 class="flex-1 font-semibold text-slate-800 text-sm group-hover:text-emerald-700 transition-colors">${prof.name}</h3>
                            <svg class="w-4 h-4 text-slate-300 group-hover:text-emerald-500 transition-colors shrink-0"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
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
                                  d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                        </svg>
                    </div>
                    <p class="text-slate-400 text-sm">Профессии не найдены</p>
                </div>
            </#if>
        </div>
    </div>

    <script>
        function searchProfessions(query) {
            const items = document.querySelectorAll('.profession-item');
            const noResults = document.getElementById('no-results');
            const countEl = document.getElementById('professions-count');
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

            if (countEl) countEl.textContent = visible + ' профессий';
            if (noResults) noResults.classList.toggle('hidden', visible > 0);
        }
    </script>
</@layoutMacros.layout>
