<#macro message>
    <#if successMessage??>
        <p class="bg-green-50 border-green-200 text-green-600 px-4 py-3 border rounded-md text-sm mb-4">${successMessage}</p>
    </#if>

    <#if infoMessage??>
        <p class="bg-blue-50 border-blue-200 text-blue-600 px-4 py-3 border rounded-md text-sm mb-4">${infoMessage}</p>
    </#if>

    <#if errorMessage??>
        <p class="bg-pink-50 border-pink-200 text-pink-600 px-4 py-3 border rounded-md text-sm mb-4">${errorMessage}</p>
    </#if>
</#macro>