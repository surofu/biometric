<#import "../shared/admin-layout.ftl" as adminLayoutMacros>

<@adminLayoutMacros.adminLayout title="Категории" selectedPage="indicator-categories">
    <div class="py-6 sm:py-8 pb-16">
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
            <div class="min-w-0">
                <h1 class="text-xl sm:text-2xl font-semibold text-slate-800 tracking-tight break-words">Категории анализов</h1>
                <p class="text-slate-500 text-sm mt-1">Управление группами</p>
            </div>
            <div class="flex flex-col sm:flex-row items-center gap-3 w-full sm:w-auto">
                <div class="relative w-full sm:w-64">
                    <input type="text" id="searchInput" placeholder="Поиск..."
                           class="w-full pl-9 pr-4 py-2 bg-white border border-slate-200 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 transition-all">
                    <svg class="absolute left-3 top-2.5 w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                </div>
                <a href="/admin/indicator-categories/add" class="w-full sm:w-auto bg-emerald-600 text-white px-6 py-2 rounded-md text-sm font-semibold hover:bg-emerald-700 transition-colors flex items-center justify-center gap-2 whitespace-nowrap">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M12 4v16m8-8H4" stroke-width="2"/></svg> Добавить
                </a>
            </div>
        </div>

        <div class="bg-white border border-slate-100 rounded-md overflow-hidden">
            <div class="block sm:hidden divide-y divide-slate-100">
                <#list categories as item>
                    <div class="p-4 search-item" data-search="${item.name()?lower_case}">
                        <div class="flex justify-between items-center gap-4">
                            <div class="min-w-0 flex-1">
                                <h3 class="text-sm font-bold text-slate-800 break-words leading-snug">${item.name()}</h3>
                                <p class="text-[10px] text-slate-400 font-mono mt-1 uppercase tracking-wider">ID: ${item.id()}</p>
                            </div>
                            <div class="flex gap-2 shrink-0">
                                <a href="/admin/indicator-categories/${item.id()}/edit" class="p-2.5 bg-slate-100 text-slate-500 rounded-md hover:bg-slate-200 transition-colors"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" stroke-width="2"/></svg></a>
                                <form method="post" action="/admin/indicator-categories/${item.id()}" onsubmit="return confirm('Удалить?')">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="hidden" name="_method" value="delete"><button type="submit" class="p-2.5 bg-red-50 text-red-500 rounded-md hover:bg-red-100 transition-colors"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" stroke-width="2"/></svg></button>
                                </form>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>

            <table class="hidden sm:table min-w-full">
                <thead class="bg-slate-50/50 border-b border-slate-100">
                <tr>
                    <th class="px-6 py-4 text-left text-[10px] font-bold text-slate-400 uppercase tracking-widest w-24">ID</th>
                    <th class="px-6 py-4 text-left text-[10px] font-bold text-slate-400 uppercase tracking-widest">Название</th>
                    <th class="px-6 py-4 text-center text-[10px] font-bold text-slate-400 uppercase tracking-widest w-32">Действия</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                <#list categories as item>
                    <tr class="hover:bg-slate-50/50 transition-colors search-item" data-search="${item.name()?lower_case}">
                        <td class="px-6 py-4 text-[10px] text-slate-400 font-mono tracking-wider uppercase">${item.id()}</td>
                        <td class="px-6 py-4 text-sm font-semibold text-slate-800 break-words">${item.name()}</td>
                        <td class="px-6 py-4 text-center">
                            <div class="flex justify-center gap-2">
                                <a href="/admin/indicator-categories/${item.id()}/edit" class="p-2 text-slate-400 hover:text-emerald-600 hover:bg-emerald-50 rounded-md transition-all"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" stroke-width="2"/></svg></a>
                                <form method="post" action="/admin/indicator-categories/${item.id()}" onsubmit="return confirm('Удалить?')">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="hidden" name="_method" value="delete"><button type="submit" class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-md transition-all"><svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" stroke-width="2"/></svg></button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        document.getElementById('searchInput')?.addEventListener('input', (e) => {
            const val = e.target.value.toLowerCase();
            document.querySelectorAll('.search-item').forEach(el => {
                el.style.display = el.dataset.search.includes(val) ? '' : 'none';
            });
        });
    </script>
</@adminLayoutMacros.adminLayout>