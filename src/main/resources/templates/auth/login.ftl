<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

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

            <a href="/oauth2/authorization/google"
               class="flex items-center justify-center gap-3 w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 text-gray-700 font-medium hover:bg-slate-50 transition-all">
                <svg width="18" height="18" viewBox="0 0 48 48">
                    <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                    <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                    <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
                    <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.31-8.16 2.31-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                    <path fill="none" d="M0 0h48v48H0z"/>
                </svg>
                Войти через Google
            </a>

            <div class="relative my-6">
                <div class="absolute inset-0 flex items-center">
                    <div class="w-full border-t border-slate-200"></div>
                </div>
                <div class="relative flex justify-center text-sm">
                    <span class="bg-white px-3 text-gray-500">или</span>
                </div>
            </div>

            <form action="/login" method="post">
                <#if _csrf??>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </#if>
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

                <@messageMacros.message />

                <button
                        type="submit"
                        class="w-full bg-linear-to-r from-emerald-400 to-emerald-500 text-white font-medium px-5 py-3 md:py-2 rounded-lg keysetCursor-pointer mt-5 opacity-100 hover:from-emerald-500 hover:to-emerald-600 transition-all"
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