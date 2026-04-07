<#list page.content() as group>
    <details class="measurement-group bg-white rounded-lg border border-gray-200 overflow-hidden"
             <#if (isFirstPage && group?is_first)>open</#if>>
        <summary
                class="bg-gray-50 px-4 py-3 border-b border-gray-200 flex justify-between items-center keysetCursor-pointer hover:bg-gray-300 transition-colors list-none [&::-webkit-details-marker]:hidden">
            <h2 class="font-medium text-gray-700">${dateFormatter.format(group.date())} <span
                        class="text-xs text-gray-500">(${dateFormatter.dayOfWeek(group.date())})</span></h2>
            <svg class="w-5 h-5 text-gray-500 transform transition-transform duration-200 chevron-icon"
                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M19 9l-7 7-7-7"></path>
            </svg>
        </summary>
        <div class="divide-y divide-gray-200">
            <#list group.items() as item>
                <div class="p-4 hover:bg-gray-50 transition-colors">
                    <div class="flex flex-col sm:flex-row sm:items-start gap-3">
                        <div class="flex-1 min-w-0">
                            <div class="flex items-start justify-between gap-2">
                                <div>
                                    <h3 class="font-medium text-gray-900">${item.indicatorName()}</h3>
                                    <p class="text-sm text-gray-500">${item.indicatorUnit()}</p>
                                </div>
                                <div class="text-right shrink-0">
                                    <span class="font-mono font-medium text-lg">${item.value()}</span>
                                    <span class="text-sm text-gray-500 ml-1">${item.indicatorUnit()}</span>
                                </div>
                            </div>
                            <div class="mt-2 flex flex-wrap items-center gap-2">
                                <#if item.indicatorReferenceMin()?? && item.indicatorReferenceMax()??>
                                    <span class="text-xs text-gray-600">
                                        Норма: ${item.indicatorReferenceMin()} – ${item.indicatorReferenceMax()} ${item.indicatorUnit()}
                                    </span>
                                    <span class="text-xs">
                                        <#if item.value() gte item.indicatorReferenceMin() && item.value() lte item.indicatorReferenceMax()>
                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full bg-green-100 text-green-800">В норме</span>
                                        <#elseif item.value() lt item.indicatorReferenceMin()>
                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full bg-yellow-100 text-yellow-800">Ниже нормы</span>
                                        <#else>
                                            <span class="inline-flex items-center px-2 py-0.5 rounded-full bg-red-100 text-red-800">Выше нормы</span>
                                        </#if>
                                    </span>
                                <#else>
                                    <span class="inline-flex items-center px-2 py-0.5 rounded-full bg-gray-100 text-gray-600 text-xs">Норма не указана</span>
                                </#if>
                            </div>
                        </div>
                        <div class="flex items-center justify-end gap-2 text-sm mt-2 sm:mt-0 sm:pl-4 sm:border-l border-gray-200">
                            <a href="/measurements/${item.id()}/edit"
                               class="p-2 text-blue-600 hover:text-blue-900 hover:bg-blue-50 rounded-full transition-colors"
                               title="Редактировать">
                                Редактировать
                            </a>
                            <form action="/measurements/${item.id()}/delete"
                                  method="post"
                                  onsubmit="return confirm('Вы уверены, что хотите удалить этот показатель?');"
                            >
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit"
                                        class="p-2 text-red-600 hover:text-red-900 hover:bg-red-50 rounded-full transition-colors"
                                        title="Удалить">
                                    Удалить
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </details>
</#list>