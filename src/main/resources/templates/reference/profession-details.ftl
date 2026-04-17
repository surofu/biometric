<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="${profession.name} — Биометрик" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
            <@messageMacros.message />

            <div class="px-4 sm:px-6 pb-6 border-b border-gray-200 flex items-center gap-4">
                <a href="/reference/professions"
                   class="flex items-center justify-center w-9 h-9 rounded-xl border border-gray-200 hover:bg-gray-50 transition-colors shrink-0">
                    <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                    </svg>
                </a>
                <div>
                    <h1 class="text-lg sm:text-xl font-semibold text-gray-800 leading-tight">${profession.name}</h1>
                    <p class="text-sm text-gray-500 mt-0.5">Профессия / Фактор риска</p>
                </div>
            </div>

            <div class="mt-6 space-y-6">
                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-100 bg-slate-50/30">
                        <h2 class="font-medium text-gray-800">Описание</h2>
                    </div>
                    <div class="p-6">
                        <div class="text-gray-700 leading-relaxed text-sm sm:text-base">
                            <#if profession.description?has_content>
                                ${profession.description}
                            <#else>
                                <p class="text-gray-400 italic">Сведения об обязательных обследованиях для данной профессии в данный момент обновляются.</p>
                            </#if>
                        </div>
                    </div>
                </div>

                <div class="space-y-3">
                    <div class="px-2 flex items-center justify-between">
                        <h2 class="text-sm font-bold text-gray-500 uppercase tracking-wider">Медицинская комиссия</h2>
                        <span class="text-xs font-medium px-2 py-0.5 bg-emerald-100 text-emerald-700 rounded-full">
                            ${(profession.doctors?size)!0} спец.
                        </span>
                    </div>

                    <div class="grid gap-2">
                        <#if profession.doctors?has_content>
                            <#list profession.doctors as doctor>
                                <a href="/reference/doctors/${doctor.id?c}"
                                   class="flex items-center justify-between p-4 bg-white border border-slate-200 rounded-2xl hover:border-emerald-300 hover:bg-emerald-50/30 transition-all group">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 rounded-xl bg-slate-50 flex items-center justify-center border border-slate-100 group-hover:bg-white transition-colors">
                                            <svg class="w-5 h-5 text-slate-400 group-hover:text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                            </svg>
                                        </div>
                                        <span class="font-medium text-gray-700 group-hover:text-gray-900">${doctor.name}</span>
                                    </div>
                                    <svg class="w-5 h-5 text-slate-300 group-hover:text-emerald-400 transform group-hover:translate-x-1 transition-all" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                            </#list>
                        <#else>
                            <div class="p-8 text-center bg-slate-50 rounded-2xl border border-dashed border-slate-200">
                                <p class="text-sm text-slate-400">Список необходимых врачей уточняется</p>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>