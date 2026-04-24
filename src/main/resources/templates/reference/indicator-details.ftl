<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="${indicator.name}" mobileTitle="Медицинские показатели" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto p-4 pb-20">
            <@messageMacros.message />
            <@pageHeaderMacros.pageHeader
            title="${indicator.name}"
            subtitle="Медицинские показатели"
            backUrl="/reference/indicators"
            />

            <div class="mt-6 space-y-4">
                <div class="bg-emerald-50/50 border border-emerald-100 rounded-2xl p-5">
                    <div class="flex items-center gap-2 mb-3">
                        <div class="w-2 h-2 rounded-full bg-emerald-500"></div>
                        <h2 class="text-xs font-bold text-emerald-800 uppercase tracking-wider">Референсные
                            значения</h2>
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

                <div class="rounded-2xl border border-slate-200 overflow-hidden px-6 py-4 bg-amber-50/30">
                    <p class="font-medium text-gray-800">Категория: ${indicator.categoryName}</p>
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
                                <p class="text-gray-400 italic">Информация о данном показателе находится в процессе
                                    наполнения.</p>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>