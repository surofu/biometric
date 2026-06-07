<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as headerMacros>

<@layoutMacros.layout title=((request.id??)?string("Редактирование индикатора", "Новый индикатор")) selectedPage="2" showNavbar=true>
    <div class="container max-w-2xl mx-auto p-4 pb-18">

        <@headerMacros.pageHeader
            backUrl="/user-indicators"
            title=(request.id??)?string("Редактирование индикатора", "Новый индикатор")
            subtitle="Задайте параметры вашего персонального показателя"
            forceShowSubtitle=true
        />

        <@messageMacros.message />

        <form action="/user-indicators/save" method="post" class="mt-4 space-y-4">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <#if request.id??>
                <input type="hidden" name="id" value="${request.id}">
            </#if>

            <div>
                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">
                    Название <span class="text-red-500">*</span>
                </label>
                <input type="text" id="name" name="name"
                       value="${(request.name)!}"
                       required maxlength="255"
                       placeholder="Например: Уровень витамина D"
                       class="w-full px-3 py-2 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
            </div>

            <div>
                <label for="unit" class="block text-sm font-medium text-gray-700 mb-1">
                    Единица измерения <span class="text-red-500">*</span>
                </label>
                <input type="text" id="unit" name="unit"
                       value="${(request.unit)!}"
                       required maxlength="50"
                       placeholder="Например: нг/мл"
                       class="w-full px-3 py-2 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
            </div>

            <div class="grid grid-cols-2 gap-3">
                <div>
                    <label for="referenceMin" class="block text-sm font-medium text-gray-700 mb-1">
                        Норма от <span class="text-red-500">*</span>
                    </label>
                    <input type="number" id="referenceMin" name="referenceMin"
                           value="${(request.referenceMin?c)!}"
                           required step="0.01"
                           placeholder="0"
                           class="w-full px-3 py-2 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
                </div>
                <div>
                    <label for="referenceMax" class="block text-sm font-medium text-gray-700 mb-1">
                        Норма до <span class="text-red-500">*</span>
                    </label>
                    <input type="number" id="referenceMax" name="referenceMax"
                           value="${(request.referenceMax?c)!}"
                           required step="0.01"
                           placeholder="100"
                           class="w-full px-3 py-2 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
                </div>
            </div>

            <div>
                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">
                    Описание <span class="text-red-500">*</span>
                </label>
                <textarea id="description" name="description"
                          required maxlength="1000" rows="3"
                          placeholder="Краткое описание показателя"
                          class="w-full px-3 py-2 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all resize-none">${(request.description)!}</textarea>
            </div>

            <button type="submit"
                    class="w-full px-5 py-2.5 bg-emerald-600 text-white text-sm font-semibold rounded-md hover:bg-emerald-700 focus:outline-none transition-colors">
                <#if request.id??>Сохранить<#else>Добавить</#if>
            </button>
        </form>
    </div>
</@layoutMacros.layout>
