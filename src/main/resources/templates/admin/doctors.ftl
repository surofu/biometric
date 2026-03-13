<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Врачи - Биометрик" selectedPage="doctors">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">

        <!-- ── Заголовок ───────────────────────────── -->
        <div class="mb-6">
            <h1 class="text-2xl font-bold text-gray-800">Врачи</h1>
            <p class="text-gray-500 text-sm mt-1">Список врачей-специалистов для медицинских осмотров</p>
        </div>

        <!-- ── Список врачей ───────────────────────────── -->
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-100 bg-emerald-50">
                <h2 class="font-medium text-gray-800 flex items-center gap-2">
                    <svg class="w-5 h-5 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                    Список врачей
                </h2>
            </div>

            <#if doctors?has_content>
                <ul class="divide-y divide-slate-100">
                    <#list doctors as doctor>
                        <li class="flex items-center gap-3 px-6 py-4 hover:bg-slate-50 transition-colors">
                            <span class="w-2 h-2 rounded-full bg-emerald-400 shrink-0"></span>
                            <span class="text-gray-700 flex-1">${doctor.name()}</span>
                        </li>
                    </#list>
                </ul>
            <#else>
                <div class="px-6 py-12 text-center">
                    <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                    <p class="text-gray-400 text-sm">Список врачей пуст</p>
                </div>
            </#if>
        </div>
    </div>
</@layoutMacros.layout>