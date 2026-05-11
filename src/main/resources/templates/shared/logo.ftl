<#macro static>
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
</#macro>
<#macro animated>
    <a href="/" class="group flex items-center gap-3.5 transition-transform hover:scale-[1.02] duration-200">
        <div class="flex items-center justify-center w-10 h-10 bg-white border-2 border-slate-100 rounded-xl group-hover:border-emerald-500 transition-colors duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none">
                <path d="M4 12H7L9 5L12 19L15 12H20" stroke="#e2e8f0" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M4 12H7L9 5L12 19L15 12H20"
                      stroke="#059669" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
                      stroke-dasharray="36 200" stroke-dashoffset="36">
                    <animate attributeName="stroke-dashoffset" from="36" to="-164" dur="2s" repeatCount="indefinite" calcMode="linear"/>
                </path>
                <circle cx="20" cy="12" r="1.4" fill="#059669">
                    <animate attributeName="opacity" values="0;0;1;1;0" keyTimes="0;0.7;0.8;0.95;1" dur="2s" repeatCount="indefinite"/>
                </circle>
            </svg>
        </div>

        <div class="flex items-center tracking-tight gap-1">
            <span class="text-2xl font-light text-slate-400">Био</span>
            <span class="text-2xl font-black text-slate-800 -ml-0.5 relative">метрик<span
                        class="absolute -right-1.5 bottom-1.5 w-1 h-1 bg-emerald-500 rounded-full"></span>
                </span>
        </div>
    </a>
</#macro>