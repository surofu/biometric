<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="${category.name}" mobileTitle="Категории индикаторов" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto p-4 pb-20">
            <@messageMacros.message />
            <@pageHeaderMacros.pageHeader
            title="${category.name}"
            subtitle="Категории индикаторов"
            backUrl="/reference/indicator-categories"
            />

            <div class="mt-6 space-y-4">
                <div class="bg-emerald-50/50 border border-emerald-100 rounded-2xl p-5">
                    <div class="flex items-center gap-2 mb-2">
                        <div class="w-2 h-2 rounded-full bg-emerald-500"></div>
                        <h2 class="text-xs font-bold text-emerald-800 uppercase tracking-wider">Группировка</h2>
                    </div>
                    <p class="text-gray-700 text-sm">Все показатели, относящиеся к данной системе организма или типу исследований.</p>
                </div>

                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden">
                    <div class="px-6 py-4 border-b border-slate-100 bg-slate-50/30">
                        <h2 class="font-medium text-gray-800">Описание</h2>
                    </div>
                    <div class="p-6">
                        <div class="text-gray-700 leading-relaxed text-sm sm:text-base">
                            <#if category.description?has_content>
                                ${category.description}
                            <#else>
                                <p class="text-gray-400 italic">Информация о данной категории временно отсутствует.</p>
                            </#if>
                        </div>
                    </div>
                </div>

                <div class="pt-2">
                    <a href="/reference/indicators?categoryId=${category.id?c}"
                       class="flex items-center justify-between p-4 bg-slate-50 border border-slate-200 rounded-xl hover:bg-emerald-50 hover:border-emerald-200 transition-colors group">
                        <span class="text-sm font-medium text-gray-700 group-hover:text-emerald-700">Просмотреть все показатели</span>
                        <svg class="w-4 h-4 text-slate-400 group-hover:text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>