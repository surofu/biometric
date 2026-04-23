<#macro pageHeader backUrl="" title="" subtitle="">
    <div class="flex <#if subtitle?has_content>items-start<#else>items-center</#if> gap-4">
        <#if backUrl?has_content>
            <a href="${backUrl}"
               class="flex items-center justify-center w-9 h-9 rounded-xl border border-slate-200 hover:bg-gray-50 transition-colors shrink-0">
                <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
            </a>
        </#if>
        <div>
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800 leading-tight">${title}</h1>
            <#if subtitle?has_content>
                <p class="text-sm text-gray-500 mt-0.5">${subtitle}</p>
            </#if>
        </div>
    </div>
</#macro>
