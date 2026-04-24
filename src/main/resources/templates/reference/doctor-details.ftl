<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="${doctor.name}" mobileTitle="Врачи" selectedPage="5">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto p-4 pb-20">
            <@messageMacros.message />
            <@pageHeaderMacros.pageHeader
            title="${doctor.name}"
            subtitle="Врачи"
            backUrl="/reference/doctors"
            />

            <div class="mt-6 px-2">
                <#if doctor.description?has_content>
                    <#outputformat "HTML">
                        ${doctor.description?no_esc}
                    </#outputformat>
                <#else>
                    <p class="text-gray-400 italic">Описание данной специализации находится в процессе наполнения.</p>
                </#if>
            </div>
        </div>
    </div>
</@layoutMacros.layout>