<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Смена пароля" showNavbar=false>
    <div class="absolute top-0 w-full flex justify-center px-4 py-10">
        <a href="/" class="group flex items-center gap-3.5 transition-transform hover:scale-[1.02] duration-200">
            <div class="flex items-center justify-center w-10 h-10 bg-white border-2 border-slate-100 rounded-xl group-hover:border-emerald-500 transition-colors duration-300">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M4 12H7L9 5L12 19L15 12H20"
                          stroke="#059669"
                          stroke-width="2.5"
                          stroke-linecap="round"
                          stroke-linejoin="round"/>
                </svg>
            </div>

            <div class="flex items-center tracking-tight gap-1">
                <span class="text-2xl font-light text-slate-400">Био</span>
                <span class="text-2xl font-black text-slate-800 -ml-0.5 relative">
                метрик
                <span class="absolute -right-1.5 bottom-1.5 w-1 h-1 bg-emerald-500 rounded-full"></span>
            </span>
            </div>
        </a>
    </div>

    <div class="min-h-screen flex flex-col items-center justify-center bg-white md:bg-slate-50 px-4 py-8 overflow-hidden">
        <div class="relative bg-white md:rounded-xl md:shadow-sm w-full max-w-md p-4 md:p-8 md:border border-slate-200">
            <h1 class="text-2xl font-bold text-center mb-2 text-gray-800">Смена пароля</h1>
            <p class="text-gray-500 text-center mb-6 text-sm">Введите старый и новый пароль для защиты аккаунта</p>

            <form action="/change-password" method="post" class="space-y-4">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div>
                    <label class="block">
                        <span class="hidden md:block text-sm font-medium text-gray-700 mb-1">Старый пароль</span>
                        <input
                                type="password"
                                name="oldPassword"
                                required
                                placeholder="Старый пароль"
                                class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <div>
                    <label class="block">
                        <span class="hidden md:block text-sm font-medium text-gray-700 mb-1">Новый пароль</span>
                        <input
                                type="password"
                                name="newPassword"
                                required
                                minlength="6"
                                placeholder="Новый пароль"
                                class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <div>
                    <label class="block">
                        <span class="hidden md:block text-sm font-medium text-gray-700 mb-1">Повторите новый пароль</span>
                        <input
                                type="password"
                                name="confirmNewPassword"
                                required
                                minlength="6"
                                placeholder="Повторите новый пароль"
                                class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <div class="pt-2">
                    <@messageMacros.message />
                </div>

                <div class="flex flex-col gap-3 pt-2">
                    <button
                            type="submit"
                            class="w-full bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium px-5 py-3 md:py-2 rounded-lg transition-colors shadow-sm"
                    >
                        Сменить пароль
                    </button>
                    <a
                            href="/profile"
                            class="block w-full text-center text-sm text-gray-500 hover:text-gray-700 font-medium py-2 transition-colors"
                    >
                        Отмена
                    </a>
                </div>
            </form>
        </div>
    </div>
</@layoutMacros.layout>