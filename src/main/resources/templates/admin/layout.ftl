<#import "../shared/layout.ftl" as layoutMacros>

<#macro adminLayout title="Админ-панель" selectedPage="">
    <@layoutMacros.layout title=title showNavbar=false bodyClass="bg-white">
        <div class="flex min-h-screen relative">

            <header class="md:hidden fixed top-0 left-0 w-full bg-white border-b border-slate-100 z-50 h-16 flex items-center justify-between px-4">
                <a href="/" class="flex items-center gap-2">
                    <div class="flex items-center justify-center w-8 h-8 bg-white border border-slate-100 rounded-lg">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M4 12H7L9 5L12 19L15 12H20" stroke="#059669" stroke-width="2.5"
                                  stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </div>
                    <span class="text-sm font-black text-slate-800 tracking-tight uppercase">Биометрик</span>
                </a>

                <button id="mobile-menu-open" class="p-2 text-slate-600 hover:bg-slate-50 rounded-lg transition-colors">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M4 6h16M4 12h16m-7 6h7"/>
                    </svg>
                </button>
            </header>

            <div id="sidebar-overlay"
                 class="fixed inset-0 bg-slate-900/50 z-60 hidden md:hidden backdrop-blur-sm transition-opacity"></div>

            <aside id="admin-sidebar"
                   class="fixed inset-y-0 left-0 z-70 w-72 bg-white border-r border-slate-100 flex flex-col transition-transform duration-300 transform -translate-x-full md:translate-x-0 md:w-64">
                <div class="p-8 pb-6 flex items-center justify-between">
                    <a href="/"
                       class="group flex items-center gap-3 transition-transform hover:scale-[1.01] duration-200">
                        <div class="flex items-center justify-center w-8 h-8 bg-white border-2 border-slate-100 rounded-lg group-hover:border-emerald-500 transition-colors">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                <path d="M4 12H7L9 5L12 19L15 12H20" stroke="#059669" stroke-width="2.5"
                                      stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                        <div class="flex items-center tracking-tight gap-0.5">
                            <span class="text-lg font-light text-slate-400">Био</span>
                            <span class="text-lg font-black text-slate-800 -ml-0.5 relative">метрик</span>
                        </div>
                    </a>
                    <button id="mobile-menu-close" class="md:hidden p-2 text-slate-400 hover:text-slate-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M6 18L18 6M6 6l12 12"/>
                        </svg>
                    </button>
                </div>

                <nav class="flex-1 px-4 space-y-1 overflow-y-auto">
                    <#list [
                    {"url": "/admin", "label": "Дашборд", "icon": "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6", "id": "dashboard"},
                    {"url": "/admin/indicators", "label": "Индикаторы", "icon": "M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10", "id": "indicators"},
                    {"url": "/admin/indicator-categories", "label": "Категории", "icon": "M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z", "id": "indicator-categories"},
                    {"url": "/admin/doctors", "label": "Доктора", "icon": "M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z", "id": "doctors"},
                    {"url": "/admin/professions", "label": "Профессии", "icon": "M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z", "id": "professions"}
                    ] as item>
                        <a href="${item.url}"
                           class="flex items-center gap-3 px-4 py-3 rounded-md text-sm font-medium transition-all
                           <#if selectedPage == item.id>bg-emerald-50 text-emerald-700 shadow-sm shadow-emerald-100/50<#else>text-slate-500 hover:bg-slate-50 hover:text-slate-900</#if>">
                            <svg class="w-5 h-5 <#if selectedPage == item.id>text-emerald-600<#else>text-slate-400</#if>"
                                 fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="${item.icon}"/>
                            </svg>
                            ${item.label}
                        </a>
                    </#list>
                </nav>

                <div class="p-6 border-t border-slate-50">
                    <a href="/"
                       class="flex items-center gap-2.5 text-xs font-semibold text-slate-400 hover:text-emerald-600 transition-colors group">
                        <svg class="w-4 h-4 transition-transform group-hover:-translate-x-1" fill="none"
                             stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                        </svg>
                        На главную
                    </a>
                </div>
            </aside>

            <main class="flex-1 md:ml-64 min-h-screen bg-white pt-16 md:pt-0">
                <div class="max-w-5xl mx-auto px-4 sm:px-6">
                    <#nested>
                </div>
            </main>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const sidebar = document.getElementById('admin-sidebar');
                const overlay = document.getElementById('sidebar-overlay');
                const openBtn = document.getElementById('mobile-menu-open');
                const closeBtn = document.getElementById('mobile-menu-close');

                const toggleSidebar = (state) => {
                    if (state) {
                        sidebar.classList.remove('-translate-x-full');
                        overlay.classList.remove('hidden');
                        document.body.classList.add('overflow-hidden');
                    } else {
                        sidebar.classList.add('-translate-x-full');
                        overlay.classList.add('hidden');
                        document.body.classList.remove('overflow-hidden');
                    }
                };

                openBtn?.addEventListener('click', () => toggleSidebar(true));
                closeBtn?.addEventListener('click', () => toggleSidebar(false));
                overlay?.addEventListener('click', () => toggleSidebar(false));
            });
        </script>
    </@layoutMacros.layout>
</#macro>