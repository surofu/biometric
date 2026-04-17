<#import "./shared/layout.ftl" as layoutMacros>
<#import "./shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Биометрик — мониторинг здоровья" selectedPage="0">
    <div class="min-h-screen bg-white">
    <div class="container max-w-2xl mx-auto px-4 pt-16 pb-20">
        <@messageMacros.message />

        <div class="flex justify-center">
            <a href="/"
               class="group flex items-center gap-3.5 transition-transform hover:scale-[1.02] duration-200">
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

        <div class="text-center pt-10">
            <h1 class="text-3xl font-bold text-slate-900 tracking-tight">
                <#if authenticated>
                    С возвращением
                <#else>
                    Мониторинг здоровья
                </#if>
            </h1>
            <p class="text-slate-500 leading-relaxed max-w-md mx-auto text-sm pt-5">
                Биометрик - это простой и эффективный ассистент для хранения медицинских показателей и отслеживания
                их динамики.
            </p>

            <#if !authenticated>
                <div class="flex flex-col sm:flex-row gap-3 justify-center items-center mt-10">
                    <a href="/register"
                       class="w-full sm:w-auto px-8 py-3 bg-emerald-600 text-white font-semibold rounded-lg hover:bg-emerald-700 transition-colors text-center text-sm">
                        Создать аккаунт
                    </a>
                    <a href="/login"
                       class="w-full sm:w-auto px-8 py-3 bg-white text-slate-600 font-semibold rounded-lg border border-slate-200 hover:bg-slate-50 transition-colors text-center text-sm">
                        Войти
                    </a>
                </div>
            </#if>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mt-10">
            <div class="p-6 border border-slate-100 rounded-2xl bg-slate-50/30">
                <div class="text-emerald-600 mb-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 13h6m-3-3v6m-9 1V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v8a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                    </svg>
                </div>
                <h3 class="font-bold text-slate-800 text-sm mb-1">Хранение показателей</h3>
                <p class="text-xs text-slate-500 leading-normal">Добавляйте результаты анализов и измерений за несколько
                    секунд.</p>
            </div>

            <div class="p-6 border border-slate-100 rounded-2xl bg-slate-50/30">
                <div class="text-emerald-600 mb-3">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                </div>
                <h3 class="font-bold text-slate-800 text-sm mb-1">Анализ данных</h3>
                <p class="text-xs text-slate-500 leading-normal">Визуальное представление изменений ваших результатов
                    анализов на графиках.</p>
            </div>

<#--            <div class="p-6 border border-slate-100 rounded-2xl bg-slate-50/30 sm:col-span-2">-->
<#--                <div class="text-emerald-600 mb-3">-->
<#--                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"-->
<#--                              d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>-->
<#--                    </svg>-->
<#--                </div>-->
<#--                <h3 class="font-bold text-slate-800 text-sm mb-1">Проф. напоминания</h3>-->
<#--                <p class="text-xs text-slate-500 leading-normal">Персональный график медосмотров в зависимости от вашей-->
<#--                    профессии и специфических условий труда.</p>-->
<#--            </div>-->
        </div>
    </div>
</@layoutMacros.layout>