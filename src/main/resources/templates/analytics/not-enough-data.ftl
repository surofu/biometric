<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="${analytics.indicatorName} - Биометрик" selectedPage="3">
    <div class="container max-w-2xl h-screen mx-auto px-4 pt-8 pb-20">
        <@messageMacros.message />
        <@pageHeaderMacros.pageHeader
        title="${analytics.indicatorName}"
        subtitle="Недостаточно данных"
        backUrl="/analytics"
        />

        <div class="relative top-0 text-center w-full h-full mt-6">
            <div class="absolute top-2 w-full flex justify-center -z-1">
                <img src="/images/chart-placeholder.webp"
                     alt="placeholder"
                     class="w-full max-w-md rounded-xl blur-xs opacity-70">
            </div>

            <div class="h-full flex flex-col justify-center items-center pb-20">
                <h2 class="text-xl font-semibold text-gray-800">Недостаточно данных</h2>
                <p class="text-gray-500 mt-2 max-w-xs mx-auto">
                    Для построения аналитики по показателю «${analytics.indicatorName}»
                    необходимо минимум <strong>2&nbsp;результата измерений</strong>.
                </p>
                <div class="mt-8">
                    <a href="/measurements/add"
                       class="inline-flex items-center gap-2 px-6 py-3 bg-emerald-600 text-white text-sm font-semibold rounded-xl hover:bg-emerald-700 transition-colors">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Добавить показатель
                    </a>
                </div>
            </div>
        </div>
    </div>
</@layoutMacros.layout>