<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Профессии - Биометрик" selectedPage="professions">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">

        <!-- ── Заголовок ───────────────────────────── -->
        <div class="mb-6">
            <h1 class="text-2xl font-bold text-gray-800">Профессии</h1>
            <p class="text-gray-500 text-sm mt-1">Список профессий, требующих регулярного медицинского осмотра</p>
        </div>

        <!-- ── Список профессий ───────────────────────────── -->
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-100 bg-emerald-50">
                <h2 class="font-medium text-gray-800 flex items-center gap-2">
                    <svg class="w-5 h-5 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                    </svg>
                    Список профессий
                </h2>
            </div>

            <#if professions?has_content>
                <ul class="divide-y divide-slate-100">
                    <#list professions as profession>
                        <li class="flex items-center gap-3 px-6 py-4 hover:bg-slate-50 transition-colors">
                            <span class="w-2 h-2 rounded-full bg-emerald-400 shrink-0"></span>
                            <span class="text-gray-700 flex-1">${profession.name()}</span>
                        </li>
                    </#list>
                </ul>
            <#else>
                <div class="px-6 py-12 text-center">
                    <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                    </svg>
                    <p class="text-gray-400 text-sm">Список профессий пуст</p>
                </div>
            </#if>
        </div>
    </div>
</@layoutMacros.layout>