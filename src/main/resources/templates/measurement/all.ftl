<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Мои показатели" selectedPage="1">
    <div class="container max-w-6xl mx-auto px-4 pt-8 pb-16">
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
            <div>
                <h1 class="text-xl sm:text-2xl font-semibold text-slate-800 tracking-tight">Мои показатели</h1>
                <p class="text-slate-500 text-sm mt-1">История ваших медицинских измерений</p>
            </div>
            <div class="flex items-center gap-2 w-full sm:w-auto">
                <a href="/measurements/add"
                   class="flex-1 sm:flex-none bg-emerald-600 text-white px-4 py-2 rounded-lg text-sm font-semibold hover:bg-emerald-700 transition-colors flex items-center justify-center gap-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>
                    Добавить
                </a>
                <div class="flex gap-1">
                    <button id="expandAll" class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg transition-colors" title="Развернуть все">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" /></svg>
                    </button>
                    <button id="collapseAll" class="p-2 text-slate-500 hover:bg-slate-100 rounded-lg transition-colors" title="Свернуть все">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7" /></svg>
                    </button>
                </div>
            </div>
        </div>

        <#if page.content()?size == 0>
            <div class="bg-white rounded-xl border border-slate-200 p-12 text-center max-w-2xl mx-auto">
                <div class="flex flex-col items-center">
                    <div class="w-16 h-16 bg-slate-50 rounded-full flex items-center justify-center mb-4">
                        <svg class="w-8 h-8 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                    </div>
                    <h3 class="text-slate-800 font-semibold">Нет записей</h3>
                    <p class="text-slate-500 text-sm mt-1 mb-6">Вы еще не добавили ни одного измерения</p>
                    <a href="/measurements/add" class="text-emerald-600 hover:text-emerald-700 font-semibold text-sm">Добавить первый показатель →</a>
                </div>
            </div>
        <#else>
            <div id="measurementGroups" class="space-y-4">
                <#include "groups.ftl">
                <div id="scroll-trigger" class="py-4 text-center text-[10px] text-slate-400 font-mono uppercase tracking-widest"></div>
            </div>
        </#if>
    </div>

    <div id="pagination-data" data-next-cursor="${page.nextCursor()!''}" data-has-next="${page.hasNext()?c}" data-page-size="${pageSize}"></div>

    <style>
        details[open] .chevron-icon { transform: rotate(180deg); }
        .measurement-group summary::-webkit-details-marker { display: none; }
    </style>
</@layoutMacros.layout>