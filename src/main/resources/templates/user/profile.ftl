<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Мой профиль - Биометрик" selectedPage="4">
    <div class="container mx-auto px-4 pt-8 pb-16">
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="bg-linear-to-r from-emerald-400 to-emerald-500 p-6 text-white">
                <div class="flex items-center gap-4">
                    <div class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center backdrop-blur-sm shrink-0">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <div class="min-w-0 flex-1">
                        <h1 class="text-xl font-semibold truncate">${email}</h1>
                        <p class="text-emerald-100 text-sm mt-0.5">Ваш личный кабинет</p>
                    </div>
                </div>
            </div>

            <div class="p-6">
                <div class="mb-6">
                    <h2 class="text-lg font-medium text-gray-800 mb-4">Информация о профиле</h2>
                    <div class="bg-slate-50 rounded-lg p-4 border border-slate-100">
                        <div class="flex items-center gap-3">
                            <span class="text-sm text-gray-500 shrink-0">Email:</span>
                            <span class="font-medium text-gray-800 truncate min-w-0">${email}</span>
                        </div>
                    </div>
                </div>

                <div class="border-t border-slate-200 pt-6">
                    <form action="/logout" method="post" onsubmit="return confirm('Вы уверены, что хотите выйти из аккаунта?');">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit"
                                class="w-full sm:w-auto px-6 py-3 bg-red-500 hover:bg-red-600 text-white font-medium rounded-lg transition-colors flex items-center justify-center gap-2 cursor-pointer">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                            </svg>
                            <span>Выйти из аккаунта</span>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>