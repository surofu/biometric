<#import "../shared/logo.ftl" as logo>

<#macro header title="" show=true>
    <header class="md:hidden <#if !show>hidden</#if> flex justify-between items-center gap-3 fixed top-0 left-0 z-10 w-full h-14 px-4 bg-white border-b border-slate-200 overflow-hidden">
        <@logo.static />

        <span class="text-base text-gray-400 tracking-tight truncate block">${title}</span>
    </header>
</#macro>