<#macro navbar selectedPage="-1">
    <nav class="fixed flex justify-center bottom-0 left-0 w-full h-fit z-10 md:hidden p-4">
        <div class="flex justify-around items-center gap-3 w-fit h-fit backdrop-blur-sm bg-white/40 shadow rounded-full py-2 px-4">
            <a href="/"
               class="flex flex-col items-center hover:text-emerald-600 transition-colors <#if selectedPage="0">text-emerald-600<#else>text-gray-700</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                </svg>
                <span class="text-xs">Главная</span>
            </a>
            <a href="/measurements"
               class="flex flex-col items-center  hover:text-emerald-600 transition-colors <#if selectedPage="1">text-emerald-600<#else>text-gray-700</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                </svg>
                <span class="text-xs">Показатели</span>
            </a>
            <a href="/measurements/new"
               class="flex flex-col items-center hover:text-emerald-600 transition-colors <#if selectedPage="2">text-emerald-600<#else>text-gray-700</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M12 4v16m8-8H4"></path>
                </svg>
                <span class="text-xs">Добавить</span>
            </a>
            <a href="/analytics"
               class="flex flex-col items-center hover:text-emerald-600 transition-colors <#if selectedPage="3">text-emerald-600<#else>text-gray-700</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                </svg>
                <span class="text-xs">Аналитика</span>
            </a>
            <a href="/profile"
               class="flex flex-col items-center hover:text-emerald-600 transition-colors <#if selectedPage="4">text-emerald-600<#else>text-gray-700</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
                <span class="text-xs">Профиль</span>
            </a>
        </div>
    </nav>

    <nav class="hidden md:block fixed top-0 left-0 w-full bg-white/80 backdrop-blur-md border-b border-slate-200 z-10">
        <div class="container max-w-6xl mx-auto px-4">
            <div class="flex items-center justify-between h-16">
                <a href="/" class="group flex items-center gap-3 transition-transform hover:scale-[1.01] duration-200">
                    <div class="flex items-center justify-center w-9 h-9 bg-white border-2 border-slate-100 rounded-xl group-hover:border-emerald-500 transition-colors duration-300">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 12H7L9 5L12 19L15 12H20"
                                  stroke="#059669"
                                  stroke-width="2.5"
                                  stroke-linecap="round"
                                  stroke-linejoin="round"/>
                        </svg>
                    </div>

                    <div class="flex items-center tracking-tight gap-1">
                        <span class="text-lg font-light text-slate-400">Био</span>
                        <span class="text-lg font-black text-slate-800 -ml-0.5 relative">
                            метрик
                            <span class="absolute -right-1 bottom-1 w-0.5 h-0.5 bg-emerald-500 rounded-full"></span>
                        </span>
                    </div>
                </a>

                <div class="flex items-center gap-1">
                    <a href="/"
                       class="px-4 py-2 rounded-lg hover:bg-emerald-50 transition-colors text-sm <#if selectedPage="0">text-emerald-600 font-medium bg-emerald-50<#else>text-gray-700</#if>">
                        Главная
                    </a>
                    <a href="/measurements"
                       class="px-4 py-2 rounded-lg hover:bg-emerald-50 transition-colors text-sm <#if selectedPage="1">text-emerald-600 font-medium bg-emerald-50<#else>text-gray-700</#if>">
                        Показатели
                    </a>
                    <a href="/measurements/new"
                       class="px-4 py-2 rounded-lg hover:bg-emerald-50 transition-colors text-sm <#if selectedPage="2">text-emerald-600 font-medium bg-emerald-50<#else>text-gray-700</#if>">
                        Добавить
                    </a>
                    <a href="/analytics"
                       class="px-4 py-2 rounded-lg hover:bg-emerald-50 transition-colors text-sm <#if selectedPage="3">text-emerald-600 font-medium bg-emerald-50<#else>text-gray-700</#if>">
                        Аналитика
                    </a>
                    <a href="/profile"
                       class="px-4 py-2 rounded-lg hover:bg-emerald-50 transition-colors text-sm <#if selectedPage="4">text-emerald-600 font-medium bg-emerald-50<#else>text-gray-700</#if>">
                        Профиль
                    </a>
                </div>

                <form action="/logout" method="post" class="ml-4" onsubmit="return confirm('Вы уверены, что хотите выйти из аккаунта?');">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit"
                            class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors cursor-pointer">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                        <span>Выйти</span>
                    </button>
                </form>
            </div>
        </div>
    </nav>
</#macro>