<#macro header title="" show=true>
    <header class="md:hidden <#if !show>hidden</#if> flex justify-between items-center gap-3 fixed top-0 left-0 z-10 w-full h-14 px-4 bg-white border-b border-slate-200 overflow-hidden">
        <a href="/" class="flex items-center gap-2.5">
            <div class="flex items-center justify-center w-8 h-8 bg-white border border-slate-200 rounded-lg">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                    <path d="M4 12H7L9 5L12 19L15 12H20" stroke="#059669" stroke-width="2.5"
                          stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <div class="flex items-center tracking-tight gap-1">
                <span class="text-base font-light text-gray-400">Био</span>
                <span class="text-base font-bold text-gray-800 -ml-0.5 relative">
                            метрик
                            <span class="absolute -right-1 bottom-1 w-0.5 h-0.5 bg-emerald-500 rounded-full"></span>
                        </span>
            </div>
        </a>

        <span class="text-base text-gray-400 tracking-tight truncate block">${title}</span>
    </header>
</#macro>