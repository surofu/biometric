<#import "../shared/admin-layout.ftl" as adminLayoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@adminLayoutMacros.adminLayout title="${(request.id()??)?then('Редактирование', 'Добавление')} категории" selectedPage="indicator-categories">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden">

            <div class="px-6 py-5 border-b border-slate-100">
                <h1 class="text-lg font-bold text-slate-800">
                    <#if request.id()??>Редактирование категории<#else>Новая категория</#if>
                </h1>
                <p class="text-slate-400 text-xs mt-1">Группировка медицинских показателей</p>
            </div>

            <div class="p-6">
                <@messageMacros.message />

                <form method="post" action="/admin/indicator-categories/save">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <#if request.id()??>
                        <input type="hidden" name="id" value="${request.id()}"/>
                    </#if>

                    <div class="space-y-6">
                        <div>
                            <label for="name" class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Название категории *</label>
                            <input type="text"
                                   id="name"
                                   name="name"
                                   value="${request.name()!''}"
                                   required
                                   maxlength="50"
                                   class="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm"
                                   placeholder="Например: Половые гормоны">
                        </div>

                        <div>
                            <label for="description" class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Описание *</label>
                            <textarea id="description"
                                      name="description"
                                      required
                                      rows="4"
                                      class="w-full px-4 py-2.5 bg-slate-50 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm resize-none"
                                      placeholder="Краткое описание категории">${request.description()!''}</textarea>
                        </div>
                    </div>

                    <div class="flex justify-end gap-3 border-t border-slate-50 mt-8 pt-6">
                        <a href="/admin/indicator-categories"
                           class="px-6 py-2.5 border border-slate-200 rounded-lg text-slate-600 hover:bg-slate-50 transition-colors text-sm font-medium">
                            Отмена
                        </a>
                        <button type="submit"
                                class="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-sm font-semibold">
                            Сохранить
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</@adminLayoutMacros.adminLayout>