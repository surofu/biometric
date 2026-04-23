<#import "layout.ftl" as adminLayoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@adminLayoutMacros.adminLayout title="${(request.id??)?then('Редактирование', 'Добавление')} индикатора" selectedPage="indicators">
    <div class="container max-w-2xl mx-auto sm:px-4 sm:pt-8 pb-20">
        <div class="bg-white rounded-xl sm:border border-slate-200 overflow-hidden">
            <div class="mx-2 sm:px-6 py-5 border-b border-slate-100">
                <h1 class="text-lg font-bold text-slate-800">
                    <#if request.id??>Редактирование индикатора<#else>Новый индикатор</#if>
                </h1>
                <p class="text-slate-400 text-xs mt-1">Параметры медицинского показателя</p>
            </div>

            <@messageMacros.message />

            <form method="post" action="/admin/indicators/save" class="p-2 pt-6 sm:p-6 space-y-6">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <#if request.id??>
                    <input type="hidden" name="id" value="${request.id}"/>
                </#if>

                <div class="space-y-5">
                    <div>
                        <label for="name" class="block text-xs text-slate-400 mb-2">Название *</label>
                        <input type="text" id="name" name="name" value="${request.name!''}" required
                               class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                    </div>

                    <div>
                        <label for="categoryId" class="block text-xs text-slate-400 mb-2">Категория *</label>
                        <select id="categoryId" name="categoryId" required
                                class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                            <option value="">-- Выберите --</option>
                            <#if categories?has_content>
                                <#list categories as cat>
                                    <option value="${cat.id}"
                                            <#if request.categoryId?? && request.categoryId == cat.id>selected</#if>>${cat.name}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>

                    <div>
                        <label for="unit" class="block text-xs text-slate-400 mb-2">Единица измерения *</label>
                        <input type="text" id="unit" name="unit" value="${request.unit!''}" required
                               class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                    </div>

                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label for="referenceMin" class="block text-xs text-slate-400 mb-2">Мин. норма *</label>
                            <input type="number" id="referenceMin" name="referenceMin"
                                   value="${request.referenceMin?c!''}" step="any" required
                                   class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                        </div>
                        <div>
                            <label for="referenceMax" class="block text-xs text-slate-400 mb-2">Макс. норма *</label>
                            <input type="number" id="referenceMax" name="referenceMax"
                                   value="${request.referenceMax?c!''}" step="any" required
                                   class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                        </div>
                    </div>

                    <div>
                        <label for="description" class="block text-xs text-slate-400 mb-2">Описание</label>
                        <textarea id="description"
                                  name="description"
                                  rows="4"
                                  oninput="this.style.height = ''; this.style.height = Math.min(this.scrollHeight, 300) + 'px'"
                                  class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm resize-y"
                                  placeholder="Краткое описание индикатора">${request.description!''}</textarea>
                    </div>
                </div>

                <div class="flex sm:justify-end gap-3 border-t border-slate-100 mt-6 pt-6">
                    <a href="/admin/indicators"
                       class="not-sm:w-full px-8 py-2.5 text-center border border-slate-200 rounded-lg text-slate-600 hover:bg-slate-50 transition-colors text-sm">Отмена</a>
                    <button type="submit"
                            class="not-sm:w-full px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-sm font-semibold">
                        Сохранить
                    </button>
                </div>
            </form>
        </div>
    </div>
</@adminLayoutMacros.adminLayout>