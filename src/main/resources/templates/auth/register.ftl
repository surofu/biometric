<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Регистрация" showNavbar=false>
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
    <div class="grid grid-rows-[1fr_auto] min-h-dvh bg-white md:bg-slate-50">
        <div class="h-full flex flex-col items-center justify-center px-4 pt-8 overflow-hidden">
            <div class="relative bg-white md:rounded-xl w-full max-w-md p-4 md:p-8 md:border border-slate-200">
                <h1 class="text-2xl font-bold text-center mb-2">Регистрация</h1>
                <p class="text-gray-500 text-center mb-6 text-sm">Создайте новый аккаунт</p>

                <form action="/register" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="mb-3">
                        <label class="block">
                            <span class="hidden md:block text-sm text-gray-700 mb-1">Email</span>
                            <input type="email" name="email" value="${request.email!}" required
                                   placeholder="Электронный адрес"
                                   class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                        </label>
                    </div>

                    <div class="mb-3">
                        <label class="block">
                            <span class="hidden md:block text-sm text-gray-700 mb-1">Пароль</span>
                            <input type="password" name="password" required
                                   placeholder="Пароль"
                                   class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                        </label>
                    </div>

                    <div class="mb-4">
                        <label class="block">
                            <span class="hidden md:block text-sm text-gray-700 mb-1">Подтверждение пароля</span>
                            <input type="password" name="confirmPassword" required
                                   placeholder="Подтвердите пароль"
                                   class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                        </label>
                    </div>

                    <@messageMacros.message />

                    <div class="mb-4">
                        <label class="flex items-start gap-3 cursor-pointer group">
                        <span class="relative flex items-center shrink-0 mt-0.5">
                            <input type="checkbox" name="agreement" required
                                   class="peer appearance-none w-5 h-5 border border-slate-300 rounded bg-white
                          checked:bg-emerald-600 checked:border-emerald-600
                          focus:ring-2 focus:ring-emerald-500 focus:ring-offset-1
                          transition-all duration-200 cursor-pointer">
                            <svg class="absolute w-3 h-3 text-white transition-opacity opacity-0 peer-checked:opacity-100 pointer-events-none left-1"
                                 fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3.5">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                            </svg>
                        </span>
                            <span class="text-xs text-gray-500 leading-tight select-none">
                            Я согласен с
                            <a href="/terms-of-service" class="text-emerald-600 hover:underline font-medium">Условиями использования</a>
                            и даю согласие на обработку моих данных согласно
                            <a href="/privacy-policy"
                               class="text-emerald-600 hover:underline font-medium">Политике конфиденциальности</a>.
                        </span>
                        </label>
                    </div>

                    <button type="submit"
                            class="w-full bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium px-5 py-3 md:py-2 rounded-lg mt-4 transition-colors">
                        Зарегистрироваться
                    </button>
                </form>

                <div class="mt-6 text-center text-sm border-t border-slate-200 pt-6">
                    <span class="text-gray-500">Уже есть аккаунт?</span>
                    <a href="/login" class="text-emerald-600 hover:text-emerald-700 font-medium ml-1">Войти</a>
                </div>
            </div>
        </div>

        <footer class="mt-auto w-full py-4 px-4 border-t border-slate-100 bg-white/50 backdrop-blur-sm">
            <div class="max-w-md mx-auto">
                <div class="flex flex-col items-center gap-4">
                    <div class="flex items-center gap-6">
                        <a href="/privacy-policy"
                           class="text-xs text-gray-400 hover:text-emerald-600 transition-colors">Конфиденциальность</a>
                        <a href="/terms-of-service"
                           class="text-xs text-gray-400 hover:text-emerald-600 transition-colors">Условия</a>
                        <a href="mailto:support@biometric.by"
                           class="text-xs text-gray-400 hover:text-emerald-600 transition-colors">Поддержка</a>
                    </div>

                    <div class="text-[11px] text-slate-400 font-medium tracking-wide">
                        &copy; ${.now?string('yyyy')} Биометрик. Все права защищены.
                    </div>
                </div>
            </div>
        </footer>
    </div>
</@layoutMacros.layout>