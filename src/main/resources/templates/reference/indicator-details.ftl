<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="${indicator.name} — Биометрик" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
            <@messageMacros.message />

            <div class="px-4 sm:px-6 pb-6 border-b border-gray-200 flex items-center gap-4">
                <a href="/reference/indicators"
                   class="flex items-center justify-center w-9 h-9 rounded-xl border border-gray-200 hover:bg-gray-50 transition-colors shrink-0">
                    <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                    </svg>
                </a>
                <div>
                    <h1 class="text-lg sm:text-xl font-semibold text-gray-800 leading-tight">${indicator.name}</h1>
                    <p class="text-sm text-gray-500 mt-0.5">${indicator.categoryName!"Общий показатель"}</p>
                </div>
            </div>

            <div class="mt-6 space-y-4">
                <div class="bg-emerald-50/50 border border-emerald-100 rounded-2xl p-5">
                    <div class="flex items-center gap-2 mb-3">
                        <div class="w-2 h-2 rounded-full bg-emerald-500"></div>
                        <h2 class="text-xs font-bold text-emerald-800 uppercase tracking-wider">Референсные значения</h2>
                    </div>
                    <div class="flex items-baseline gap-2">
                        <span class="text-3xl font-bold text-emerald-700">
                            <#if indicator.referenceMin?? && indicator.referenceMax??>
                                ${indicator.referenceMin?string["0.##"]} – ${indicator.referenceMax?string["0.##"]}
                            <#elseif indicator.referenceMin??>
                                ≥ ${indicator.referenceMin?string["0.##"]}
                            <#elseif indicator.referenceMax??>
                                ≤ ${indicator.referenceMax?string["0.##"]}
                            <#else>
                                —
                            </#if>
                        </span>
                        <span class="text-emerald-600/70 font-medium">${indicator.unit!""}</span>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-100 bg-slate-50/30">
                        <h2 class="font-medium text-gray-800">Описание</h2>
                    </div>
                    <div class="p-6">
                        <div class="text-gray-700 leading-relaxed text-sm sm:text-base">
                            <#if indicator.description?has_content>
                                ${indicator.description}
                            <#else>
                                <p class="text-gray-400 italic">Информация о данном показателе находится в процессе наполнения.</p>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>