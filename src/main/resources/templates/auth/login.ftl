<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Вход" showNavbar=false>
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
            <h1 class="text-2xl font-bold text-center mb-2">Вход</h1>
            <p class="text-gray-600 text-center mb-6">Войдите в свой аккаунт</p>

            <form action="/login" method="post" class="group">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="rememberMe" value="true">
                <input type="checkbox" name="rememberMe" id="rememberMe" checked class="hidden">

                <div class="mb-4">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Email</span>
                        <input
                                type="email"
                                name="email"
                                value="${email!}"
                                required
                                placeholder="Электронный адрес"
                                class="w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <div class="mb-4">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Пароль</span>
                        <input
                                type="password"
                                name="password"
                                required
                                placeholder="Пароль"
                                class="w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-shadow"
                        >
                    </label>
                </div>

                <#if errorMessage??>
                    <p class="bg-pink-50 border border-pink-200 rounded-md text-pink-600 text-sm px-4 py-3 mb-4">${errorMessage}</p>
                </#if>

                <#if infoMessage??>
                    <p class="bg-blue-50 border border-blue-200 rounded-md text-blue-600 text-sm px-4 py-3 mb-4">${infoMessage}</p>
                </#if>

                <button
                        type="submit"
                        class="w-full bg-linear-to-r from-emerald-400 to-emerald-500 text-white font-medium px-5 py-3 md:py-2 rounded-lg keysetCursor-pointer mt-5 opacity-100 group-invalid:opacity-40 group-invalid:pointer-events-none hover:from-emerald-500 hover:to-emerald-600 transition-all"
                >
                    Войти
                </button>
            </form>

            <div class="mt-6 text-center text-sm">
                <span class="text-gray-600">Нет аккаунта?</span>
                <a href="/register" class="text-emerald-600 hover:text-emerald-800 font-medium ml-1">Создать</a>
            </div>
        </div>
    </div>
</@layoutMacros.layout>