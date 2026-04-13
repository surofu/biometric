<#macro navbar selectedPage="-1">
<#-- Мобильная навигация (без изменений) -->
    <nav class="fixed bottom-0 left-0 w-full z-50 md:hidden bg-white border-t border-gray-100 pb-safe">
        <div class="flex justify-around items-center h-14">
            <a href="/"
               class="flex flex-col items-center justify-center flex-1 transition-colors <#if selectedPage=="0">text-emerald-600<#else>text-gray-400</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                </svg>
                <span class="text-[10px] mt-1">Главная</span>
            </a>
            <a href="/measurements"
               class="flex flex-col items-center justify-center flex-1 transition-colors <#if selectedPage=="1">text-emerald-600<#else>text-gray-400</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                </svg>
                <span class="text-[10px] mt-1">Показатели</span>
            </a>
            <a href="/measurements/add"
               class="flex flex-col items-center justify-center flex-1 transition-colors <#if selectedPage=="2">text-emerald-600<#else>text-gray-400</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                </svg>
                <span class="text-[10px] mt-1">Добавить</span>
            </a>
            <a href="/analytics"
               class="flex flex-col items-center justify-center flex-1 transition-colors <#if selectedPage=="3">text-emerald-600<#else>text-gray-400</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                </svg>
                <span class="text-[10px] mt-1">Аналитика</span>
            </a>
            <a href="/profile"
               class="flex flex-col items-center justify-center flex-1 transition-colors <#if selectedPage=="4">text-emerald-600<#else>text-gray-400</#if>">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
                <span class="text-[10px] mt-1">Профиль</span>
            </a>
        </div>
    </nav>

<#-- Десктопная навигация -->
    <nav class="hidden md:block fixed top-0 left-0 w-full bg-white border-b border-gray-100 z-50">
        <div class="container max-w-6xl mx-auto px-4">
            <div class="flex items-center justify-between h-14">
                <a href="/" class="flex items-center gap-2.5">
                    <div class="flex items-center justify-center w-8 h-8 bg-white border border-gray-100 rounded-lg">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                            <path d="M4 12H7L9 5L12 19L15 12H20" stroke="#059669" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <div class="flex items-center tracking-tight gap-1">
                        <span class="text-base font-light text-gray-400">Био</span>
                        <span class="text-base font-bold text-gray-800 -ml-0.5 relative">
                            метрик
                            <span class="absolute -right-1 bottom-1 w-0.5 h-0.5 bg-emerald-500 rounded-full"></span>
                        </span>
                    </div>
                </a>

                <div class="flex items-center gap-1">
                    <#list [
                    {"url": "/", "label": "Главная", "id": "0"},
                    {"url": "/measurements", "label": "Показатели", "id": "1"},
                    {"url": "/measurements/add", "label": "Добавить", "id": "2"},
                    {"url": "/analytics", "label": "Аналитика", "id": "3"},
                    {"url": "/profile", "label": "Профиль", "id": "4"}
                    ] as item>
                        <a href="${item.url}"
                           class="px-3 py-1.5 rounded-md transition-colors text-sm <#if selectedPage==item.id>text-emerald-600 font-semibold bg-emerald-50<#else>text-gray-500 hover:text-gray-700 hover:bg-gray-50</#if>">
                            ${item.label}
                        </a>
                    </#list>

                    <#-- Кнопка Админки только для десктопа и персонала -->
                    <#if auth.isModerator(authentication) || auth.isAdmin(authentication)>
                        <a href="/admin"
                           class="ml-2 px-3 py-1.5 rounded-md transition-all text-sm flex items-center gap-2
                           <#if selectedPage=="5">
                               bg-violet-600 text-white font-semibold
                           <#else>
                               text-violet-600 bg-violet-50 hover:bg-violet-100
                           </#if>">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"></path>
                            </svg>
                            Админ-панель
                        </a>
                    </#if>
                </div>
            </div>
        </div>
    </nav>
</#macro>