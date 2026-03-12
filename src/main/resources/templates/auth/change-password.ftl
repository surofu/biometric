<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Восстановление пароля" showNavbar=false>
    <!-- Логотип -->
    <div class="absolute top-0 w-full flex justify-center px-4 py-8">
        <a href="/" class="flex items-center gap-2">
            <svg width="30" height="30">
                <use href="/favicon.svg#content" width="30" height="30"></use>
            </svg>
            <span class="text-xl font-bold bg-linear-to-r from-emerald-600 to-emerald-400 bg-clip-text text-transparent">Биометрик</span>
        </a>
    </div>

    <div class="min-h-screen flex flex-col items-center justify-center bg-white md:bg-slate-50 px-4 py-8 overflow-hidden">
        <div class="relative bg-white md:rounded-xl md:shadow-md w-full max-w-md p-4 md:p-8 md:border border-slate-200">
            <h1 class="text-2xl font-bold text-center mb-2">Смена пароля</h1>
            <p class="text-gray-600 text-center mb-6">Введите старый и новый пароль</p>

            <form action="/change-password" method="post">
                <#if _csrf??>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </#if>

                <!-- Поле email УДАЛЕНО -->

                <div class="mb-4">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Старый пароль</span>
                        <input
                                type="password"
                                name="oldPassword"
                                required
                                placeholder="Старый пароль"
                                class="w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <div class="mb-4">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Новый пароль</span>
                        <input
                                type="password"
                                name="newPassword"
                                required
                                minlength="6"
                                placeholder="Новый пароль"
                                class="w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <div class="mb-4">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Повторите новый пароль</span>
                        <input
                                type="password"
                                name="confirmNewPassword"
                                required
                                minlength="6"
                                placeholder="Повторите новый пароль"
                                class="w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <@messageMacros.message />

                <button
                        type="submit"
                        class="w-full bg-linear-to-r from-emerald-400 to-emerald-500 text-white font-medium px-5 py-3 md:py-2 rounded-lg keysetCursor-pointer mt-5 opacity-100 hover:from-emerald-500 hover:to-emerald-600 transition-all"
                >
                    Сменить пароль
                </button>
            </form>

            <div class="mt-6 text-center text-sm">
                <span class="text-gray-600">Вспомнили пароль?</span>
                <a href="/login" class="text-emerald-600 hover:text-emerald-800 font-medium ml-1">Войти</a>
            </div>
        </div>
    </div>
</@layoutMacros.layout>