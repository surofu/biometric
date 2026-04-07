<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Врачи - Биометрик" selectedPage="doctors">
    <div class="container max-w-6xl mx-auto px-4 pt-8 pb-20">

        <!-- Адаптивный заголовок с кнопкой добавления -->
        <div class="bg-linear-to-r from-emerald-400 to-emerald-500 p-4 sm:p-6 text-white rounded-xl shadow-sm mb-6 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
            <div class="flex items-center gap-3 sm:gap-4">
                <div class="w-10 h-10 sm:w-12 sm:h-12 bg-white/20 rounded-full flex items-center justify-center backdrop-blur-sm shrink-0">
                    <svg class="w-5 h-5 sm:w-6 sm:h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                </div>
                <div>
                    <h1 class="text-lg sm:text-xl font-semibold">Врачи</h1>
                    <p class="text-emerald-100 text-xs sm:text-sm mt-0.5">Список врачей-специалистов для медицинских осмотров</p>
                </div>
            </div>
            <a href="/admin/doctors/add"
               class="bg-white text-emerald-600 px-3 py-1.5 sm:px-4 sm:py-2 rounded-lg text-xs sm:text-sm font-medium hover:bg-emerald-50 transition-colors flex items-center gap-1 sm:gap-2 self-end sm:self-auto">
                <svg class="w-3.5 h-3.5 sm:w-4 sm:h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                </svg>
                Добавить
            </a>
        </div>

        <!-- Список врачей -->
        <#if doctors?has_content>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
                <#list doctors as doctor>
                    <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden hover:shadow-md transition-shadow">
                        <div class="p-6">
                            <h2 class="text-lg font-semibold text-gray-800 mb-2">${doctor.name()}</h2>
                            <div class="flex justify-end gap-2">
                                <a href="/admin/doctors/${doctor.id()}/edit"
                                   class="text-emerald-600 hover:text-emerald-800 p-1 rounded-full hover:bg-emerald-50 transition-colors"
                                   title="Редактировать">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/>
                                    </svg>
                                </a>
                                <a href="/admin/doctors/${doctor.id()}/delete"
                                   class="text-red-500 hover:text-red-700 p-1 rounded-full hover:bg-red-50 transition-colors"
                                   title="Удалить"
                                   onclick="return confirm('Вы уверены, что хотите удалить этого врача?')">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        <#else>
            <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-8 text-center text-gray-400">
                <svg class="w-16 h-16 mx-auto text-gray-300 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
                <p class="text-gray-400 text-sm">Список врачей пуст</p>
            </div>
        </#if>
    </div>
</@layoutMacros.layout>