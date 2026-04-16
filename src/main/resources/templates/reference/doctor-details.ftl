<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="${doctor.name} — Биометрик" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
            <@messageMacros.message />

            <div class="px-4 sm:px-6 pb-6 border-b border-gray-200 flex items-center gap-4">
                <a href="/reference/doctors"
                   class="flex items-center justify-center w-9 h-9 rounded-xl border border-gray-200 hover:bg-gray-50 transition-colors shrink-0">
                    <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                    </svg>
                </a>
                <div>
                    <h1 class="text-lg sm:text-xl font-semibold text-gray-800 leading-tight">${doctor.name}</h1>
                    <p class="text-sm text-gray-500 mt-0.5">Врач-специалист</p>
                </div>
            </div>

            <div class="mt-6 space-y-4">
                <div class="bg-emerald-50/50 border border-emerald-100 rounded-2xl p-5 flex items-center gap-4">
                    <div class="w-12 h-12 bg-white rounded-xl border border-emerald-100 flex items-center justify-center shrink-0 shadow-sm">
                        <svg class="w-6 h-6 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <div>
                        <h2 class="text-xs font-bold text-emerald-800 uppercase tracking-wider">Тип специализации</h2>
                        <p class="text-lg font-semibold text-emerald-700">Медицинский специалист</p>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-100 bg-slate-50/30">
                        <h2 class="font-medium text-gray-800">Описание</h2>
                    </div>
                    <div class="p-6">
                        <div class="text-gray-700 leading-relaxed text-sm sm:text-base">
                            <#if doctor.description?has_content>
                                ${doctor.description}
                            <#else>
                                <p class="text-gray-400 italic">Описание данной специализации находится в процессе наполнения.</p>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>