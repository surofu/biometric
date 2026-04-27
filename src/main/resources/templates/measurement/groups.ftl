<#list page.content() as group>
    <details
            class="measurement-group bg-white border border-slate-200 overflow-hidden <#if (isFirstPage && group?is_first)>rounded-xl<#else>rounded-md</#if>"
            <#if (isFirstPage && group?is_first)>open</#if>>
        <summary
                class="<#if (isFirstPage && group?is_first)>bg-slate-50</#if> px-4 py-3 border-b border-slate-100 flex justify-between items-center cursor-pointer hover:bg-slate-100 transition-colors list-none">
            <h2 class="text-sm font-bold text-slate-700 flex items-center gap-2">
                <span class="text-emerald-600">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path
                                stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/></svg>
                </span>
                ${dateFormatter.format(group.date)}
                <span class="text-[10px] text-slate-400 font-mono uppercase tracking-wider ml-1">${dateFormatter.dayOfWeek(group.date)}</span>
            </h2>
            <svg class="w-4 h-4 text-slate-400 transform transition-transform duration-200 chevron-icon" fill="none"
                 stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
            </svg>
        </summary>

        <div class="divide-y divide-slate-100">
            <#list group.items as item>
                <div class="p-4 hover:bg-slate-50/50 transition-colors">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                        <div class="flex-1 min-w-0">
                            <div class="flex items-center justify-between sm:justify-start sm:gap-6 mb-2">
                                <h3 class="text-sm font-semibold text-slate-800 truncate">${item.indicatorName}</h3>
                                <div class="text-right sm:text-left">
                                    <span class="text-base font-bold text-slate-900 font-mono">${item.value}</span>
                                    <span class="text-xs text-slate-500 font-medium ml-0.5">${item.indicatorUnit}</span>
                                </div>
                            </div>

                            <div class="flex flex-wrap items-center gap-2">
                                <#if item.indicatorReferenceMin?? && item.indicatorReferenceMax??>
                                    <span class="text-[11px] text-slate-500 font-medium">Норма: ${item.indicatorReferenceMin}–${item.indicatorReferenceMax}</span>
                                    <#if item.value gte item.indicatorReferenceMin && item.value lte item.indicatorReferenceMax>
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full bg-green-100 text-green-800 text-[10px] font-bold uppercase tracking-wide">В норме</span>
                                    <#elseif item.value lt item.indicatorReferenceMin>
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full bg-yellow-100 text-yellow-800 text-[10px] font-bold uppercase tracking-wide">Ниже нормы</span>
                                    <#else>
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full bg-red-100 text-red-800 text-[10px] font-bold uppercase tracking-wide">Выше нормы</span>
                                    </#if>
                                <#else>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full bg-slate-100 text-slate-600 text-[10px] font-bold uppercase tracking-wide">Норма не указана</span>
                                </#if>
                            </div>
                        </div>

                        <div class="flex items-center gap-2 sm:gap-1.5 pt-3 sm:pt-0 border-t sm:border-t-0 sm:border-l border-slate-100 sm:pl-4">
                            <a href="/measurements/${item.id}/edit"
                               class="flex-1 sm:flex-none flex items-center justify-center gap-2 sm:gap-0 px-3 py-2.5 sm:p-2 bg-blue-50 sm:bg-transparent text-blue-600 sm:text-slate-500 hover:text-blue-700 sm:hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-all text-xs font-bold sm:font-normal">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"
                                          stroke-width="2.5"/>
                                </svg>
                                <span class="sm:hidden ml-1">Изменить</span>
                            </a>

                            <form action="/measurements/${item.id}" method="post"
                                  onsubmit="return confirm('Удалить запись?');" class="flex-1 sm:flex-none">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="_method" value="delete">
                                <button type="submit"
                                        class="w-full flex items-center justify-center gap-2 sm:gap-0 px-3 py-2.5 sm:p-2 bg-red-50 sm:bg-transparent text-red-600 sm:text-slate-400 hover:text-red-700 sm:hover:text-red-500 hover:bg-red-50 rounded-lg transition-all text-xs font-bold sm:font-normal">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                                              stroke-width="2.5"/>
                                    </svg>
                                    <span class="sm:hidden ml-1">Удалить</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </details>
</#list>

<script>
    document.querySelectorAll('.measurement-group').forEach(details => {
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
</script>