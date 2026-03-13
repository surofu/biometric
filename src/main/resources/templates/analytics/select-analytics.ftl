<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Выбор показателя для аналитики" selectedPage="3">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-16">
        <!-- Заголовок -->
        <div class="px-4 sm:px-6 pb-4 border-b border-gray-200">
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800">
                Аналитика показателей
            </h1>
            <p class="text-sm text-gray-600 mt-1">Выберите показатель для просмотра детальной статистики</p>
        </div>

        <!-- Сетка с индикаторами -->
        <div class="grid grid-cols-1 gap-4 mt-6">
            <#list indicators as indicator>
                <a href="/analytics/${indicator.id()}"
                   class="bg-white rounded-xl border border-slate-200 p-6 hover:shadow-md transition-all hover:border-emerald-300 hover:bg-emerald-50/30 text-lg font-semibold text-gray-800">
                    ${indicator.name()}
                </a>
            <#else>
                <!-- Пустое состояние -->
                <div class="col-span-full bg-white rounded-lg border border-gray-200 p-8 text-center">
                    <div class="flex flex-col items-center gap-3">
                        <svg class="w-16 h-16 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                        <span class="text-lg text-gray-600">Нет доступных показателей</span>
                        <a href="/measurements/new" class="text-emerald-600 hover:text-emerald-800 font-medium">
                            Добавить первый показатель →
                        </a>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</@layoutMacros.layout>