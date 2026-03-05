<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Мои показатели" selectedPage="1">
    <div class="container mx-auto px-4 pt-8 pb-16">
        <div class="px-4 sm:px-6 pb-4 border-b border-gray-200">
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800">
                Мои показатели
            </h1>
        </div>

        <!-- Кнопки управления (иконки) и добавления -->
        <div class="flex justify-between items-start sm:items-center gap-4 w-full py-6">
            <a href="/measurements/new"
               class="w-full sm:w-auto px-4 py-2 bg-emerald-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors text-center">
                Добавить показатель
            </a>
            <div class="flex gap-2">
                <button id="expandAll"
                        class="p-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700 transition-colors cursor-pointer"
                        title="Развернуть все">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7-7 7 7M5 14l7 7 7-7" />
                    </svg>
                </button>
                <button id="collapseAll"
                        class="p-2 bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700 transition-colors cursor-pointer"
                        title="Свернуть все">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 21l7-7 7 7M5 3l7 7 7-7" />
                    </svg>
                </button>
            </div>
        </div>

        <#if measurementGroups?size == 0>
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
            <div class="space-y-3" id="measurementGroups">
                <#list measurementGroups as group>
                    <details class="measurement-group bg-white rounded-lg border border-gray-200 overflow-hidden" <#if group?is_first>open</#if>>
                        <summary class="bg-gray-50 px-4 py-3 border-b border-gray-200 flex justify-between items-center cursor-pointer hover:bg-gray-300 transition-colors list-none [&::-webkit-details-marker]:hidden">
                            <h2 class="font-medium text-gray-700">${group.date()} <span class="text-xs text-gray-500">(${group.dayOfWeek()})</span></h2>
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
                                                  onsubmit="return confirm('Вы уверены, что хотите удалить этот показатель?');">
                                                <#if _csrf??>
                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                           value="${_csrf.token}"/>
                                                </#if>
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
            </div>
        </#if>
    </div>

    <style>
        /* Поворот иконки при открытом details */
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
        });
    </script>
</@layoutMacros.layout>