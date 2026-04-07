<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Редактирование категории - Биометрик" selectedPage="admin">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="bg-linear-to-r from-emerald-400 to-emerald-500 p-6 text-white">
                <h1 class="text-xl font-semibold">
                    <#if request.id()??>Редактирование категории<#else>Добавление категории</#if>
                </h1>
            </div>

            <div class="p-6">
                <@messageMacros.message />

                <form method="post" action="/admin/indicator-categories/save">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <#if request.id()??>
                        <input type="hidden" name="id" value="${request.id()}"/>
                    </#if>

                    <div class="mb-4">
                        <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Название *</label>
                        <input type="text"
                               id="name"
                               name="name"
                               value="${request.name()!''}"
                               required
                               maxlength="50"
                               class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow"
                               placeholder="Например: Половые гормоны">
                    </div>

                    <div class="mb-6">
                        <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Описание *</label>
                        <textarea id="description"
                                  name="description"
                                  required
                                  rows="4"
                                  class="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none transition-shadow"
                                  placeholder="Краткое описание категории">${request.description()!''}</textarea>
                    </div>

                    <div class="flex justify-end gap-3">
                        <a href="/admin/indicator-categories"
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