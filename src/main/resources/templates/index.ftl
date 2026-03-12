<#import "./shared/layout.ftl" as layoutMacros>
<#import "./shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Биометрик - Персональный мониторинг здоровья" selectedPage="0" showNavbar=authenticated>
    <div class="min-h-screen bg-white">
        <div class="container mx-auto px-4 pt-8 pb-20">
            <@messageMacros.message />

            <!-- Логотип и заголовок -->
            <div class="flex flex-col items-center mb-10">
                <div class="flex items-center gap-3 text-emerald-600">
                    <svg width="48" height="48" class="text-emerald-500">
                        <use href="/favicon.svg#content" width="48" height="48"></use>
                    </svg>
                    <span class="text-3xl font-bold bg-linear-to-r from-emerald-600 to-emerald-400 bg-clip-text text-transparent">Биометрик</span>
                </div>
                <p class="text-gray-500 mt-3 text-center max-w-md">Ваш персональный помощник в отслеживании здоровья</p>
            </div>

            <!-- Приветствие -->
            <div class="text-center mb-12">
                <h1 class="text-2xl font-semibold text-gray-800 mb-2">
                    <#if authenticated>
                        С возвращением!
                    <#else>
                        Добро пожаловать!
                    </#if>
                </h1>
                <p class="text-gray-600 max-w-2xl mx-auto">
                    Платформа для персонального мониторинга показателей здоровья.
                    Записывайте свои измерения, следите за динамикой и оставайтесь здоровыми.
                </p>
                <#if !authenticated>
                    <div class="flex flex-wrap gap-4 justify-center mt-8">
                        <!-- Кнопка входа (контурная) -->
                        <a href="/login"
                           class="inline-flex items-center justify-center w-full max-w-xs px-6 py-3 border border-emerald-600 text-emerald-600 font-medium rounded-lg hover:bg-emerald-50 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M11 16l-4-4m0 0l4-4m-4 4h14m-6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                            </svg>
                            Войти
                        </a>
                        <!-- Кнопка регистрации (градиентная) -->
                        <a href="/register"
                           class="inline-flex items-center justify-center w-full max-w-xs px-6 py-3 bg-linear-to-r from-emerald-400 to-emerald-500 text-white font-medium rounded-lg hover:from-emerald-500 hover:to-emerald-600 transition-colors shadow-sm">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                            Зарегистрироваться
                        </a>
                    </div>
                </#if>
            </div>

            <!-- Карточки с возможностями -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-5xl mx-auto">
                <!-- Карточка 1: Отслеживание -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 hover:shadow-md transition-shadow group">
                    <div class="w-12 h-12 bg-emerald-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-emerald-200 transition-colors">
                        <svg class="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-gray-800 mb-2">Отслеживайте показатели</h3>
                    <p class="text-sm text-gray-600">Фиксируйте важные метрики здоровья</p>
                </div>

                <!-- Карточка 2: Анализ -->
                <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-6 hover:shadow-md transition-shadow group">
                    <div class="w-12 h-12 bg-emerald-100 rounded-lg flex items-center justify-center mb-4 group-hover:bg-emerald-200 transition-colors">
                        <svg class="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                        </svg>
                    </div>
                    <h3 class="font-semibold text-gray-800 mb-2">Анализируйте динамику</h3>
                    <p class="text-sm text-gray-600">Просматривайте историю изменений, сравнивайте с нормами и
                        отслеживайте прогресс.</p>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>