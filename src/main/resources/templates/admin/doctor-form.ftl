<#import "layout.ftl" as adminLayoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@adminLayoutMacros.adminLayout title="${(request.id??)?then('Редактирование', 'Добавление')} врача" selectedPage="doctors">
    <div class="container max-w-2xl mx-auto sm:px-4 sm:pt-8 pb-20">
        <div class="bg-white rounded-xl sm:border border-slate-200 overflow-hidden">
            <div class="mx-2 sm:px-6 py-5 border-b border-slate-100">
                <h1 class="text-lg font-bold text-slate-800">
                    <#if request.id??>Редактирование врача<#else>Новый врач</#if>
                </h1>
                <p class="text-slate-400 text-xs mt-1">Укажите название специалиста для справочника</p>
            </div>

            <@messageMacros.message />

            <form method="post" action="/admin/doctors/save" class="p-2 pt-6 sm:p-6 space-y-6">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <#if request.id??>
                    <input type="hidden" name="id" value="${request.id?c}"/>
                </#if>

                <div class="space-y-5">
                    <div>
                        <label for="name" class="block text-xs text-slate-400 mb-2">Название специалиста *</label>
                        <input type="text"
                               id="name"
                               name="name"
                               value="${request.name!''}"
                               required
                               maxlength="255"
                               class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm"
                               placeholder="Например: Терапевт">
                    </div>

                    <div>
                        <label for="description" class="block text-xs text-slate-400 mb-2">Описание</label>
                        <textarea id="description"
                                  name="description"
                                  rows="4"
                                  oninput="this.style.height = ''; this.style.height = Math.min(this.scrollHeight, 300) + 'px'"
                                  class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm resize-y"
                                  placeholder="Краткое описание специалиста">${request.description!''}</textarea>
                    </div>
                </div>

                <div class="flex sm:justify-end items-center gap-3 border-t border-slate-100 mt-6 pt-6">
                    <a href="/admin/doctors"
                       class="not-sm:w-full px-8 py-2.5 text-center border border-slate-200 rounded-lg text-slate-600 hover:bg-slate-50 transition-colors text-sm">Отмена</a>
                    <button type="submit"
                            class="not-sm:w-full px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-sm font-semibold">
                        Сохранить
                    </button>
                </div>
            </form>

            <#if request.id??>
                <form id="delete-form" action="/admin/doctors/${request.id}" method="post" class="hidden">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="_method" value="delete">
                </form>
            </#if>
        </div>
    </div>
</@adminLayoutMacros.adminLayout>