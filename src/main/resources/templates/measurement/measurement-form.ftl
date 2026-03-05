<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Добавление показателя" selectedPage="2">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-16">

        <div class="px-4 sm:px-6 pb-4 border-b border-gray-200">
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800">
                <#if measurement.id()??>
                    Редактирование показателя
                <#else>
                    Добавление нового показателя
                </#if>
            </h1>
        </div>

        <form action="/measurements" method="post" class="p-4 sm:p-6 space-y-4 sm:space-y-6">
            <#if _csrf??>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </#if>

            <#if measurement.id()??>
                <input type="hidden" name="id" value="${measurement.id()}">
            </#if>

            <#-- Поле для даты -->
            <div>
                <label for="date" class="block text-sm font-medium text-gray-700 mb-1 sm:mb-2">
                    Дата <span class="text-red-500">*</span>
                </label>
                <input type="date"
                       name="date"
                       id="date"
                       value="${measurement.formattedDate()}"
                       required
                       class="w-full px-3 py-2 text-base sm:text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                <p class="mt-1 text-xs text-gray-500">Введите дату измерения</p>
                <#if validationErrors?? && validationErrors.hasFieldErrors('date')>
                    <#list validationErrors.getFieldErrors('date') as error>
                        <p class="mt-1 text-sm text-red-600">${error.defaultMessage}</p>
                    </#list>
                </#if>
            </div>

            <#-- Поле для индикатора -->
            <div>
                <label for="indicatorId" class="block text-sm font-medium text-gray-700 mb-1 sm:mb-2">
                    Показатель <span class="text-red-500">*</span>
                </label>
                <select name="indicatorId"
                        id="indicatorId"
                        required
                        class="w-full px-3 py-2 text-base sm:text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                    <option value="">Выберите показатель</option>
                    <#list indicators as indicator>
                        <option value="${indicator.id()}"
                                <#if measurement.indicatorId()?? && measurement.indicatorId() == indicator.id()>selected</#if>>
                            ${indicator.name()}
                        </option>
                    </#list>
                </select>
                <#if validationErrors?? && validationErrors.hasFieldErrors('indicatorId')>
                    <#list validationErrors.getFieldErrors('indicatorId') as error>
                        <p class="mt-1 text-sm text-red-600">${error.defaultMessage}</p>
                    </#list>
                </#if>
            </div>

            <#-- Информация о выбранном показателе (динамически) -->
            <div id="indicatorInfo" class="hidden bg-blue-50 border border-blue-200 rounded-md p-3 sm:p-4">
                <div class="flex items-center gap-2">
                    <svg class="w-5 h-5 text-blue-600 mt-0.5 shrink-0" fill="none" stroke="currentColor"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <h4 class="text-sm text-blue-700" id="referenceRange"></h4>
                </div>
            </div>

            <#-- Поле для значения -->
            <div>
                <label for="value" class="block text-sm font-medium text-gray-700 mb-1 sm:mb-2">
                    Значение <span class="text-red-500">*</span>
                </label>
                <input type="number"
                       name="value"
                       id="value"
                       value="${(measurement.value()?c)!}"
                       step="0.01"
                       required
                       placeholder="Введите значение"
                       class="w-full px-3 py-2 text-base sm:text-sm border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                <#if validationErrors?? && validationErrors.hasFieldErrors('value')>
                    <#list validationErrors.getFieldErrors('value') as error>
                        <p class="mt-1 text-sm text-red-600">${error.defaultMessage}</p>
                    </#list>
                </#if>
            </div>

            <#if successMessage??>
                <p class="bg-emerald-50 border border-emerald-200 rounded-md text-emerald-600 text-sm px-4 py-2">${successMessage}</p>
            </#if>

            <#if errorMessage??>
                <p class="bg-pink-50 border border-pink-200 rounded-md text-pink-600 text-sm px-4 py-2">${errorMessage}</p>
            </#if>

            <#-- Кнопки -->
            <div class="pt-4 border-t border-gray-200">
                <button type="submit"
                        class="w-full sm:w-auto px-4 py-2 bg-emerald-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors">
                    <#if measurement.id()??>
                        Сохранить изменения
                    <#else>
                        Добавить показатель
                    </#if>
                </button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const indicatorSelect = document.getElementById('indicatorId');
            const indicatorInfo = document.getElementById('indicatorInfo');
            const referenceRange = document.getElementById('referenceRange');

            const indicators = [
                <#list indicators as indicator>
                {
                    id: ${indicator.id()?c},
                    name: '${indicator.name()}',
                    unit: '${indicator.unit()}',
                    referenceMin: <#if indicator.referenceMin()??>${indicator.referenceMin()?c}<#else>null</#if>,
                    referenceMax: <#if indicator.referenceMax()??>${indicator.referenceMax()?c}<#else>null</#if>
                }<#sep>, </#sep>
                </#list>
            ];

            function updateIndicatorInfo() {
                const selectedId = parseInt(indicatorSelect.value);
                const indicator = indicators.find(i => i.id === selectedId);

                console.log("selectedId: " + selectedId);
                console.log(indicator);

                if (indicator) {
                    // Проверяем, что оба референсных значения заданы (не null)
                    if (indicator.referenceMin != null && indicator.referenceMax != null) {
                        referenceRange.textContent = 'Норма: ' + indicator.referenceMin + ' – ' + indicator.referenceMax + ' ' + indicator.unit;
                    } else {
                        referenceRange.textContent = 'Референсные значения не указаны';
                    }
                    indicatorInfo.classList.remove('hidden');
                } else {
                    indicatorInfo.classList.add('hidden');
                }
            }

            indicatorSelect.addEventListener('change', updateIndicatorInfo);

            // Если при загрузке уже выбран показатель (например, при редактировании)
            if (indicatorSelect.value) {
                updateIndicatorInfo();
            }
        });
    </script>
</@layoutMacros.layout>