<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as headerMacros>

<@layoutMacros.layout title="Мои индикаторы" showNavbar=true>
    <div class="container max-w-2xl mx-auto p-4 pb-18">

        <@headerMacros.pageHeader
        backUrl="/profile"
        title="Мои индикаторы"
        subtitle="Персональные показатели, которые вы создали"
        forceShowSubtitle=true
        />

        <@messageMacros.message />

        <a href="/user-indicators/add"
           class="mt-4 flex items-center justify-center gap-2 w-full px-5 py-2.5 bg-emerald-600 text-white text-sm font-semibold rounded-md hover:bg-emerald-700 transition-colors">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
            </svg>
            Добавить
        </a>

        <#if indicators?has_content>
            <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-4">
                <#list indicators as indicator>
                    <div class="flex items-center gap-3 pl-8 p-4 <#if indicator?has_next>border-b border-slate-100</#if>">
                        <div class="min-w-0 flex-1">
                            <p class="text-sm font-medium text-gray-800 truncate">${indicator.name}</p>
                            <p class="text-xs text-gray-400 mt-0.5">
                                Норма: ${indicator.referenceMin?c} – ${indicator.referenceMax?c}
                                <span class="text-gray-300">·</span>
                                ${indicator.unit}
                            </p>
                        </div>
                        <div class="flex items-center gap-1 shrink-0">
                            <a href="/user-indicators/${indicator.id}/edit"
                               class="p-2 text-gray-400 hover:text-emerald-600 hover:bg-emerald-50 rounded-md transition-colors">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                </svg>
                            </a>
                            <form action="/user-indicators/${indicator.id}" method="post" class="inline">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="_method" value="DELETE"/>
                                <button type="submit"
                                        onclick="return confirm('Удалить индикатор «${indicator.name?js_string}»?')"
                                        class="p-2 text-gray-400 hover:text-red-500 hover:bg-red-50 rounded-md transition-colors">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                    </svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </#list>
            </div>
        <#else>
            <div class="bg-white rounded-xl border border-slate-200 p-12 pt-9 text-center mt-4">
                <div class="flex flex-col items-center">
                    <div class="w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center mb-4">
                        <svg class="w-8 h-8 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                    </div>
                    <h3 class="text-slate-800 font-semibold">Нет индикаторов</h3>
                    <p class="text-slate-500 text-sm mt-1">Создайте первый персональный показатель</p>
                </div>
            </div>
        </#if>

    </div>
</@layoutMacros.layout>