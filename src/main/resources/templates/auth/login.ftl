<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Вход" showNavbar=false>
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
        <div class="relative bg-white md:rounded-xl w-full max-w-md p-4 md:p-8 md:border border-slate-200">
            <h1 class="text-2xl font-bold text-center mb-2">Вход</h1>
            <p class="text-gray-500 text-center mb-6 text-sm">Войдите в свой аккаунт</p>

            <a href="/oauth2/authorization/google"
               class="flex items-center justify-center gap-3 w-full border border-slate-300 rounded-lg px-5 py-3 md:py-2 text-sm text-gray-700 font-medium hover:bg-slate-50 transition-colors">
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
                    <span class="bg-white px-3 text-gray-400">или</span>
                </div>
            </div>

            <form action="/login" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="rememberMe" value="true">
                <label>
                    <input type="checkbox" name="rememberMe" id="rememberMe" checked class="hidden">
                </label>

                <div class="mb-3">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Email</span>
                        <input type="email" name="email" value="${email!}" required
                               placeholder="Электронный адрес"
                               class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                    </label>
                </div>

                <div class="mb-4">
                    <label class="block">
                        <span class="hidden md:block text-sm text-gray-700 mb-1">Пароль</span>
                        <input type="password" name="password" required
                               placeholder="Пароль"
                               class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                    </label>
                </div>

                <@messageMacros.message />

                <button type="submit"
                        class="w-full bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium px-5 py-3 md:py-2 rounded-lg mt-4 transition-colors">
                    Войти
                </button>
            </form>

            <div class="mt-6 text-center text-sm">
                <span class="text-gray-500">Нет аккаунта?</span>
                <a href="/register" class="text-emerald-600 hover:text-emerald-700 font-medium ml-1">Создать</a>
            </div>
        </div>
    </div>
</@layoutMacros.layout>