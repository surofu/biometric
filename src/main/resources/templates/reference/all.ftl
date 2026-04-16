<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Справочник — Биометрик" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
            <@messageMacros.message />

            <div class="text-center pt-4 pb-6">
                <div class="flex justify-center mb-4">
                    <div class="flex items-center justify-center w-14 h-14 bg-emerald-50 rounded-2xl">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 6.042C10.3516 4.56336 8.0704 3.75 5.5 3.75C4.08079 3.75 2.75018 4.05217 1.5 4.56177V19.5C2.75018 18.9904 4.08079 18.6882 5.5 18.6882C8.0704 18.6882 10.3516 19.5016 12 20.9802M12 6.042C13.6484 4.56336 15.9296 3.75 18.5 3.75C19.9192 3.75 21.2498 4.05217 22.5 4.56177V19.5C21.2498 18.9904 19.9192 18.6882 18.5 18.6882C15.9296 18.6882 13.6484 19.5016 12 20.9802M12 6.042V20.9802"
                                  stroke="#059669" stroke-width="2" stroke-linecap="round"/>
                            <path d="M12 10.5V12M12 15H12.01" stroke="#059669" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                    </div>
                </div>
                <h1 class="text-3xl font-bold text-slate-900 tracking-tight">
                    Справочник
                </h1>
                <p class="text-slate-500 leading-relaxed max-w-md mx-auto text-sm pt-3">
                    Нормативные значения медицинских показателей, информация о врачах и профессиональных осмотрах
                </p>
            </div>

            <!-- Основные разделы -->
            <div class="space-y-4 mt-6">
                <!-- Медицинские показатели -->
                <a href="/reference/indicators"
                   class="block group p-5 border border-slate-100 rounded-2xl bg-white hover:bg-slate-50/50 transition-all duration-200 hover:border-emerald-200 hover:shadow-sm">
                    <div class="flex items-start gap-4">
                        <div class="shrink-0 w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors">
                            <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h2 class="font-bold text-slate-800 text-lg">Медицинские показатели</h2>
                                <svg class="w-5 h-5 text-slate-300 group-hover:text-emerald-500 transition-colors"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                            <p class="text-slate-500 text-sm mt-1">Нормы и референсные значения анализов крови, мочи и
                                других исследований</p>
                        </div>
                    </div>
                </a>

                <!-- Категории показателей -->
                <a href="/reference/indicator-categories"
                   class="block group p-5 border border-slate-100 rounded-2xl bg-white hover:bg-slate-50/50 transition-all duration-200 hover:border-emerald-200 hover:shadow-sm">
                    <div class="flex items-start gap-4">
                        <div class="shrink-0 w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors">
                            <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"/>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h2 class="font-bold text-slate-800 text-lg">Категории показателей</h2>
                                <svg class="w-5 h-5 text-slate-300 group-hover:text-emerald-500 transition-colors"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                            <p class="text-slate-500 text-sm mt-1">Группы анализов: биохимия, клинический анализ крови,
                                гормоны и другие</p>
                        </div>
                    </div>
                </a>

                <!-- Врачи -->
                <a href="/reference/doctors"
                   class="block group p-5 border border-slate-100 rounded-2xl bg-white hover:bg-slate-50/50 transition-all duration-200 hover:border-emerald-200 hover:shadow-sm">
                    <div class="flex items-start gap-4">
                        <div class="shrink-0 w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors">
                            <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h2 class="font-bold text-slate-800 text-lg">Врачи и специализации</h2>
                                <svg class="w-5 h-5 text-slate-300 group-hover:text-emerald-500 transition-colors"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                            <p class="text-slate-500 text-sm mt-1">Описание специальностей, к кому обращаться и с какими
                                симптомами</p>
                        </div>
                    </div>
                </a>

                <!-- Профессии -->
                <a href="/reference/professions"
                   class="block group p-5 border border-slate-100 rounded-2xl bg-white hover:bg-slate-50/50 transition-all duration-200 hover:border-emerald-200 hover:shadow-sm">
                    <div class="flex items-start gap-4">
                        <div class="shrink-0 w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center group-hover:bg-emerald-100 transition-colors">
                            <svg class="w-5 h-5 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <div class="flex items-center justify-between">
                                <h2 class="font-bold text-slate-800 text-lg">Профессии и медосмотры</h2>
                                <svg class="w-5 h-5 text-slate-300 group-hover:text-emerald-500 transition-colors"
                                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                            <p class="text-slate-500 text-sm mt-1">Периодичность обязательных медосмотров по профессиям
                                и вредным факторам</p>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Блок с дополнительной информацией -->
            <div class="mt-10 p-5 bg-emerald-50/40 rounded-2xl border border-emerald-100">
                <div class="flex gap-3">
                    <svg class="w-5 h-5 text-emerald-600 shrink-0 mt-0.5" fill="none" stroke="currentColor"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <div>
                        <h3 class="font-semibold text-slate-800 text-sm">Информация носит справочный характер</h3>
                        <p class="text-xs text-slate-500 mt-1 leading-relaxed">
                            Все нормативные значения являются ориентировочными. Для постановки диагноза и назначения
                            лечения
                            обратитесь к врачу. Разные лаборатории могут использовать различные референсные интервалы.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>