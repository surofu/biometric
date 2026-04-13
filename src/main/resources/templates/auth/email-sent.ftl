<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Подтвердите почту" showNavbar=false>
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
        <div class="relative bg-white md:rounded-xl w-full max-w-md p-4 md:p-8 md:border border-slate-200">

            <!-- Иконка письма -->
            <div class="flex justify-center mb-6">
                <div class="w-16 h-16 bg-emerald-50 rounded-full flex items-center justify-center">
                    <svg class="w-8 h-8 text-emerald-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M21.75 6.75v10.5a2.25 2.25 0 0 1-2.25 2.25h-15a2.25 2.25 0 0 1-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0 0 19.5 4.5h-15a2.25 2.25 0 0 0-2.25 2.25m19.5 0v.243a2.25 2.25 0 0 1-1.07 1.916l-7.5 4.615a2.25 2.25 0 0 1-2.36 0L3.32 8.91a2.25 2.25 0 0 1-1.07-1.916V6.75"/>
                    </svg>
                </div>
            </div>

            <h1 class="text-2xl font-bold text-center mb-2">Проверьте почту</h1>
            <p class="text-gray-600 text-center mb-2">
                Мы отправили письмо со ссылкой для подтверждения на
            </p>
            <p class="text-emerald-600 font-medium text-center mb-6 break-all">${email}</p>

            <div class="bg-slate-50 border border-slate-200 rounded-lg px-4 py-3 mb-6">
                <p class="text-sm text-gray-500 text-center">
                    Не получили письмо? Проверьте папку&nbsp;<span class="font-medium text-gray-700">«Спам»</span>
                </p>
            </div>

            <@messageMacros.message />

            <a href="/login"
               class="block w-full text-center bg-linear-to-r from-emerald-400 to-emerald-500 text-white font-medium px-5 py-3 md:py-2 rounded-lg hover:from-emerald-500 hover:to-emerald-600 transition-all">
                Перейти ко входу
            </a>

            <div class="mt-6 text-center text-sm">
                <span class="text-gray-600">Не тот аккаунт?</span>
                <a href="/register" class="text-emerald-600 hover:text-emerald-800 font-medium ml-1">Зарегистрироваться</a>
            </div>
        </div>
    </div>
</@layoutMacros.layout>