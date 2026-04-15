<#-- Путь: templates/profile.ftl -->
<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Мой профиль" selectedPage="4">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-16">
        <@messageMacros.message />

        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-100">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Аккаунт</p>
            </div>
            <div class="px-6 py-4 flex items-center gap-3">
                <div class="w-10 h-10 bg-emerald-100 rounded-full flex items-center justify-center shrink-0">
                    <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                </div>
                <div class="min-w-0">
                    <p class="text-sm font-medium text-gray-800 truncate">${email}</p>
                    <p class="text-xs text-gray-400">Электронная почта</p>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-6 py-4 border-b border-slate-100">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Настройки</p>
            </div>
            <ul class="divide-y divide-slate-100">
                <#-- Блок админ-панели (виден только персоналу) -->
                <#if auth.isModerator(authentication) || auth.isAdmin(authentication)>
                    <li>
                        <a href="/admin"
                           class="flex items-center justify-between px-6 py-4 hover:bg-violet-50 transition-colors group">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-violet-100 rounded-lg flex items-center justify-center shrink-0 group-hover:bg-violet-200 transition-colors">
                                    <svg class="w-4 h-4 text-violet-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"/>
                                    </svg>
                                </div>
                                <div>
                                    <span class="text-sm text-violet-700 font-semibold">Админ-панель</span>
                                    <p class="text-[10px] text-violet-400 uppercase tracking-tighter">Управление системой</p>
                                </div>
                            </div>
                            <svg class="w-4 h-4 text-violet-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </a>
                    </li>
                </#if>

                <li>
                    <a href="/change-password"
                       class="flex items-center justify-between px-6 py-4 hover:bg-gray-50 transition-colors">
                        <div class="flex items-center gap-3">
                            <svg class="w-5 h-5 text-gray-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z"/>
                            </svg>
                            <span class="text-sm text-gray-700">Изменить пароль</span>
                        </div>
                        <svg class="w-4 h-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </a>
                </li>
            </ul>
        </div>

        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-6 py-4 border-b border-slate-100">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Прочее</p>
            </div>
            <ul class="divide-y divide-slate-100">
                <li>
                    <a href="/about"
                       class="flex items-center justify-between px-6 py-4 hover:bg-gray-50 transition-colors">
                        <div class="flex items-center gap-3">
                            <svg class="w-5 h-5 text-gray-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <span class="text-sm text-gray-700">О приложении</span>
                        </div>
                        <svg class="w-4 h-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </a>
                </li>
                <li>
                    <form action="/logout" method="post"
                          onsubmit="return confirm('Вы уверены, что хотите выйти из аккаунта?');">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit"
                                class="w-full flex items-center justify-between px-6 py-4 hover:bg-red-50 transition-colors text-left">
                            <span class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-red-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                </svg>
                                <span class="text-sm text-red-500 font-medium">Выйти из аккаунта</span>
                            </span>
                            <svg class="w-4 h-4 text-red-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </button>
                    </form>
                </li>
            </ul>
        </div>

    </div>
</@layoutMacros.layout>