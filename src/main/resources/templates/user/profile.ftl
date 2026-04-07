<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Мой профиль - Биометрик" selectedPage="4">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-16">
        <@messageMacros.message />

        <!-- Аккаунт -->
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

        <!-- Настройки -->
        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-6 py-4 border-b border-slate-100">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Настройки</p>
            </div>
            <ul class="divide-y divide-slate-100">
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
<#--                <li>-->
<#--                    <a href="#notifications"-->
<#--                       class="flex items-center justify-between px-6 py-4 hover:bg-gray-50 transition-colors">-->
<#--                        <div class="flex items-center gap-3">-->
<#--                            <svg class="w-5 h-5 text-gray-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"-->
<#--                                      d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6 6 0 10-12 0v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>-->
<#--                            </svg>-->
<#--                            <span class="text-sm text-gray-700">Уведомления</span>-->
<#--                        </div>-->
<#--                        <svg class="w-4 h-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>-->
<#--                        </svg>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="#units"-->
<#--                       class="flex items-center justify-between px-6 py-4 hover:bg-gray-50 transition-colors">-->
<#--                        <div class="flex items-center gap-3">-->
<#--                            <svg class="w-5 h-5 text-gray-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"-->
<#--                                      d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 006.001 0M6 7l3 9M6 7l6-2m6 2l3-1m-3 1l-3 9a5.002 5.002 0 006.001 0M18 7l3 9m-3-9l-6-2m0-2v2m0 16V5m0 16H9m3 0h3"/>-->
<#--                            </svg>-->
<#--                            <span class="text-sm text-gray-700">Единицы измерения</span>-->
<#--                        </div>-->
<#--                        <svg class="w-4 h-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>-->
<#--                        </svg>-->
<#--                    </a>-->
<#--                </li>-->
<#--                <li>-->
<#--                    <a href="#export"-->
<#--                       class="flex items-center justify-between px-6 py-4 hover:bg-gray-50 transition-colors">-->
<#--                        <div class="flex items-center gap-3">-->
<#--                            <svg class="w-5 h-5 text-gray-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"-->
<#--                                      d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>-->
<#--                            </svg>-->
<#--                            <span class="text-sm text-gray-700">Экспорт данных</span>-->
<#--                        </div>-->
<#--                        <svg class="w-4 h-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>-->
<#--                        </svg>-->
<#--                    </a>-->
<#--                </li>-->
            </ul>
        </div>

        <!-- Прочее -->
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
                            <div class="flex items-center gap-3">
                                <svg class="w-5 h-5 text-red-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                                </svg>
                                <span class="text-sm text-red-500 font-medium">Выйти из аккаунта</span>
                            </div>
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