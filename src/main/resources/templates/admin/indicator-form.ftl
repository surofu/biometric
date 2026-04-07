<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="${(request.id()??)?then('Редактирование', 'Добавление')} индикатора" selectedPage="admin">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="bg-linear-to-r from-emerald-400 to-emerald-500 p-6 text-white">
                <h1 class="text-xl font-semibold">
                    <#if request.id()??>Редактирование индикатора<#else>Новый индикатор</#if>
                </h1>
                <p class="text-emerald-100 text-sm mt-1">Заполните основные параметры медицинского показателя</p>
            </div>

            <div class="p-6">
                <@messageMacros.message />

                <form method="post" action="/admin/indicators/save">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <#if request.id()??>
                        <input type="hidden" name="id" value="${request.id()}"/>
                    </#if>

                    <!-- Название -->
                    <div class="mb-4">
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Название *</label>
                        <input type="text"
                               id="name"
                               name="name"
                               value="${request.name()!''}"
                               required
                               maxlength="100"
                               class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow"
                               placeholder="Например: Общий тестостерон">
                    </div>

                    <!-- Категория (выпадающий список) -->
                    <div class="mb-4">
                        <label for="categoryId" class="block text-sm font-medium text-gray-700 mb-1">Категория *</label>
                        <select id="categoryId"
                                name="categoryId"
                                required
                                class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow bg-white">
                            <option value="">-- Выберите категорию --</option>
                            <#if categories?has_content>
                                <#list categories as cat>
                                    <option value="${cat.id()}" <#if request.categoryId()?? && request.categoryId() == cat.id()>selected</#if>>
                                        ${cat.name()}
                                    </option>
                                </#list>
                            </#if>
                        </select>
                        <#if !categories?has_content>
                            <p class="mt-1 text-sm text-amber-600">
                                Нет доступных категорий.
                                <a href="/admin/indicator-categories/add" class="text-emerald-600 hover:underline">Создайте категорию</a> сначала.
                            </p>
                        </#if>
                    </div>

                    <!-- Единица измерения -->
                    <div class="mb-4">
                        <label for="unit" class="block text-sm font-medium text-gray-700 mb-1">Единица измерения *</label>
                        <input type="text"
                               id="unit"
                               name="unit"
                               value="${request.unit()!''}"
                               required
                               maxlength="20"
                               class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow"
                               placeholder="Например: нмоль/л, пг/мл">
                    </div>

                    <!-- Референсные значения (мин и макс в одной строке) -->
                    <div class="grid grid-cols-2 gap-4 mb-6">
                        <div>
                            <label for="referenceMin" class="block text-sm font-medium text-gray-700 mb-1">Мин. норма *</label>
                            <input type="number"
                                   id="referenceMin"
                                   name="referenceMin"
                                   value="${request.referenceMin()!''}"
                                   required
                                   step="any"
                                   class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow"
                                   placeholder="0.0">
                        </div>
                        <div>
                            <label for="referenceMax" class="block text-sm font-medium text-gray-700 mb-1">Макс. норма *</label>
                            <input type="number"
                                   id="referenceMax"
                                   name="referenceMax"
                                   value="${request.referenceMax()!''}"
                                   required
                                   step="any"
                                   class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow"
                                   placeholder="0.0">
                        </div>
                    </div>

                    <!-- Кнопки действий -->
                    <div class="flex justify-end gap-3">
                        <a href="/admin/indicators"
                           class="px-5 py-2 border border-slate-300 rounded-lg text-gray-700 hover:bg-slate-50 transition-colors">
                            Отмена
                        </a>
                        <button type="submit"
                                class="px-5 py-2 bg-linear-to-r from-emerald-400 to-emerald-500 text-white rounded-lg hover:from-emerald-500 hover:to-emerald-600 transition-colors">
                            Сохранить
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</@layoutMacros.layout>