<#import "./shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="О проекте — Биометрик" selectedPage="-1" showNavbar=true>
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-6 pt-16 pb-24">

            <div class="flex flex-col items-center mb-12">
                <div class="flex items-center gap-3 mb-4">
                    <div class="flex items-center justify-center w-10 h-10 bg-white border-2 border-slate-100 rounded-xl">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 12H7L9 5L12 19L15 12H20" stroke="#059669" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="flex items-center tracking-tight gap-1">
                        <span class="text-2xl font-light text-slate-400">Био</span>
                        <span class="text-2xl font-black text-slate-800 -ml-0.5 relative">
                            метрик
                            <span class="absolute -right-1.5 bottom-1.5 w-1 h-1 bg-emerald-500 rounded-full"></span>
                        </span>
                    </div>
                </div>
                <h1 class="text-2xl md:text-3xl font-bold text-slate-900 tracking-tight text-center leading-tight">
                    Простой контроль <br class="md:hidden"> показателей здоровья
                </h1>
            </div>

            <div class="space-y-10">
                <section>
                    <h2 class="text-[10px] font-bold uppercase tracking-[0.2em] text-emerald-600 mb-3">О приложении</h2>
                    <p class="text-slate-600 leading-relaxed text-sm md:text-base">
                        Биометрик — это персональный журнал медицинских данных. Мы убрали всё лишнее, чтобы вы могли сфокусироваться на главном: отслеживании динамики анализов и поддержании своего здоровья в норме.
                    </p>
                </section>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div class="p-6 border border-slate-100 rounded-2xl bg-slate-50/30">
                        <div class="text-emerald-600 mb-3">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 13h6m-3-3v6m-9 1V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v8a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <h3 class="font-bold text-slate-800 text-sm mb-1">Хранение показателей</h3>
                        <p class="text-xs text-slate-500 leading-normal">Добавляйте результаты анализов и измерений за несколько секунд.</p>
                    </div>

                    <div class="p-6 border border-slate-100 rounded-2xl bg-slate-50/30">
                        <div class="text-emerald-600 mb-3">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                            </svg>
                        </div>
                        <h3 class="font-bold text-slate-800 text-sm mb-1">Анализ данных</h3>
                        <p class="text-xs text-slate-500 leading-normal">Визуальное представление изменений ваших результатов анализов на графиках.</p>
                    </div>

<#--                    <div class="p-6 border border-slate-100 rounded-2xl bg-slate-50/30 sm:col-span-2">-->
<#--                        <div class="text-emerald-600 mb-3">-->
<#--                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">-->
<#--                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>-->
<#--                            </svg>-->
<#--                        </div>-->
<#--                        <h3 class="font-bold text-slate-800 text-sm mb-1">Проф. напоминания</h3>-->
<#--                        <p class="text-xs text-slate-500 leading-normal">Персональный график медосмотров в зависимости от вашей профессии и специфических условий труда.</p>-->
<#--                    </div>-->
                </div>

                <section class="pt-8 flex flex-col sm:flex-row items-center justify-between gap-4 border-t border-slate-100">
                    <div class="flex items-center gap-2 text-xs text-slate-400 font-medium">
                        <span>Создано</span>
                        <a href="https://github.com/surofu" target="_blank" class="text-emerald-600 hover:text-emerald-700 transition-colors underline underline-offset-4 decoration-emerald-200">@surofu</a>
                    </div>

                    <a href="https://github.com/surofu/biometric" target="_blank" class="flex items-center gap-2 text-xs text-slate-500 hover:text-slate-800 transition-colors group">
                        <svg class="w-4 h-4 opacity-70 group-hover:opacity-100" fill="currentColor" viewBox="0 0 24 24"><path d="M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12"/></svg>
                        <span>GitHub проекта</span>
                    </a>
                </section>
            </div>

            <div class="mt-12 text-center">
                <a href="/" class="inline-flex items-center gap-2 text-xs font-medium text-slate-300 hover:text-slate-500 transition-colors">
                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                    </svg>
                    Вернуться на главную
                </a>
            </div>
        </div>
    </div>
</@layoutMacros.layout>