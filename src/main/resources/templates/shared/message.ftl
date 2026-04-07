<#macro message>
    <div id="message-container" class="space-y-2.5 transition-opacity duration-500 ease-in-out">
        <#if successMessage??>
            <div class="flex items-center gap-3 bg-emerald-50 border border-emerald-100 px-4 py-3 rounded-xl mb-3">
                <svg class="w-5 h-5 text-emerald-600 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <p class="text-sm text-emerald-800 font-medium leading-none">${successMessage}</p>
            </div>
        </#if>

        <#if infoMessage??>
            <div class="flex items-center gap-3 bg-blue-50 border border-blue-100 px-4 py-3 rounded-xl mb-3">
                <svg class="w-5 h-5 text-blue-600 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <p class="text-sm text-blue-800 font-medium leading-none">${infoMessage}</p>
            </div>
        </#if>

        <#if errorMessage??>
            <div class="flex items-center gap-3 bg-red-50 border border-red-100 px-4 py-3 rounded-xl mb-3">
                <svg class="w-5 h-5 text-red-600 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <p class="text-sm text-red-800 font-medium leading-none">${errorMessage}</p>
            </div>
        </#if>
    </div>

    <#if successMessage?? || infoMessage?? || errorMessage??>
        <script>
            setTimeout(() => {
                const msg = document.getElementById('message-container');
                if (msg) {
                    msg.style.opacity = '0';
                    setTimeout(() => msg.remove(), 500);
                }
            }, 3000);
        </script>
    </#if>
</#macro>