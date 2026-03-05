<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Индикаторы">
    <div class="container mx-auto px-4 pt-8 pb-16">
        <!-- Заголовок и кнопка добавления -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
            <h1 class="text-xl sm:text-2xl font-semibold text-gray-800">Медицинские показатели</h1>
        </div>

        <!-- Карточки для мобильных устройств и таблица для десктопа -->
        <div class="bg-white rounded-lg border border-gray-200 overflow-hidden">
            <!-- Мобильная версия (карточки) -->
            <div class="block sm:hidden divide-y divide-gray-200">
                <#list indicators as indicator>
                    <div class="p-4 hover:bg-gray-50 transition-colors">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-medium text-gray-900 mb-2">${indicator.name()}</h3>
                            <span class="text-xs px-2 py-1 bg-blue-50 text-blue-700 rounded-full">${indicator.unit()}</span>
                        </div>
                        <div class="flex justify-between items-center text-sm">
                            <span class="text-gray-600">Мин: <span class="font-medium text-gray-900">${indicator.referenceMin()}</span></span>
                            <span class="text-gray-400">|</span>
                            <span class="text-gray-600">Макс: <span class="font-medium text-gray-900">${indicator.referenceMax()}</span></span>
                        </div>
                    </div>
                <#else>
                    <div class="p-8 text-center text-gray-500">
                        <svg class="w-12 h-12 mx-auto text-gray-400 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                        <p>Нет доступных показателей</p>
                    </div>
                </#list>
            </div>

            <!-- Десктопная версия (таблица) - скрыта на мобильных -->
            <table class="hidden sm:table min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Название</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ед. изм.</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Мин</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Макс</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <#list indicators as indicator>
                    <tr class="hover:bg-gray-50 transition-colors">
                        <td class="px-6 py-4 text-sm font-medium text-gray-900">${indicator.name()}</td>
                        <td class="px-6 py-4 text-sm text-gray-500">${indicator.unit()}</td>
                        <td class="px-6 py-4 text-sm text-gray-900">${indicator.referenceMin()}</td>
                        <td class="px-6 py-4 text-sm text-gray-900">${indicator.referenceMax()}</td>
                    </tr>
                <#else>
                    <tr>
                        <td colspan="5" class="px-6 py-8 text-center text-gray-500">
                            Нет доступных показателей
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </div>
</@layoutMacros.layout>