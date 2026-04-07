<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="Индикаторы">
    <div class="container mx-auto px-4 pt-8 pb-16">
        <!-- Шапка + поиск -->
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
            <h1 class="text-xl sm:text-2xl font-semibold text-gray-800">Медицинские показатели</h1>
            <div class="flex items-center gap-3 w-full sm:w-auto">
                <div class="relative w-full sm:w-64">
                    <input type="text" id="searchInput" placeholder="Поиск по названию..."
                           class="w-full pl-9 pr-4 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500">
                    <svg class="absolute left-3 top-2.5 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>
                <a href="/admin/indicators/add"
                   class="bg-emerald-500 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-emerald-600 transition-colors flex items-center gap-2 whitespace-nowrap">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Добавить
                </a>
            </div>
        </div>

        <!-- Контейнер с карточками (моб) и таблицей (десктоп) -->
        <div class="bg-white sm:rounded-lg sm:border sm:border-gray-200 overflow-hidden">
            <!-- Мобильные карточки с действиями -->
            <div class="block sm:hidden space-y-3" id="mobileCardsContainer">
                <#list indicators as indicator>
                    <div class="bg-white rounded-xl shadow-sm border border-slate-200 p-4 hover:shadow-md transition-shadow" data-category="${indicator.categoryName()?lower_case}" data-name="${indicator.name()?lower_case}">
                        <div class="flex justify-between items-start gap-3">
                            <div class="flex-1">
                                <h3 class="text-base font-semibold text-gray-800 mb-2">${indicator.name()}</h3>
                                <div class="text-sm text-gray-500 space-y-1">
                                    <div>Категория: <span class="text-gray-700">${indicator.categoryName()}</span></div>
                                    <div>Ед. изм: <span class="text-gray-700">${indicator.unit()}</span></div>
                                    <div>Мин: <span class="font-medium text-gray-900">${indicator.referenceMin()}</span> | Макс: <span class="font-medium text-gray-900">${indicator.referenceMax()}</span></div>
                                </div>
                            </div>
                            <div class="flex gap-1">
                                <a href="/admin/indicators/${indicator.id()}/edit" class="p-2 text-emerald-600 hover:bg-emerald-50 rounded-lg transition-colors" title="Редактировать">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                                </a>
                                <form method="post" action="/admin/indicators/${indicator.id()}/delete" onsubmit="return confirm('Удалить показатель?')" class="inline">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors" title="Удалить">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                <#else>
                    <div class="text-center text-gray-400 py-8">Нет показателей</div>
                </#list>
            </div>

            <!-- Десктопная таблица с действиями -->
            <table class="hidden sm:table min-w-full" id="desktopTable">
                <thead class="bg-gray-50 text-xs font-medium text-gray-500 uppercase tracking-wider">
                <tr>
                    <th class="px-6 py-3 text-left">Название</th>
                    <th class="px-6 py-3 text-left">Категория</th>
                    <th class="px-6 py-3 text-left">Ед. изм.</th>
                    <th class="px-6 py-3 text-left">Мин</th>
                    <th class="px-6 py-3 text-left">Макс</th>
                    <th class="px-6 py-3 text-center">Действия</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                <#list indicators as indicator>
                    <tr class="hover:bg-gray-50 transition-colors" data-name="${indicator.name()?lower_case}" data-category="${indicator.categoryName()?lower_case}">
                        <td class="px-6 py-4 text-sm font-medium text-gray-900">${indicator.name()}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${indicator.categoryName()}</td>
                        <td class="px-6 py-4 text-sm text-gray-500">${indicator.unit()}</td>
                        <td class="px-6 py-4 text-sm text-gray-900">${indicator.referenceMin()}</td>
                        <td class="px-6 py-4 text-sm text-gray-900">${indicator.referenceMax()}</td>
                        <td class="px-6 py-4 text-center">
                            <div class="flex justify-center gap-2">
                                <a href="/admin/indicators/${indicator.id()}/edit" class="text-emerald-600 hover:text-emerald-800 p-1 rounded-full hover:bg-emerald-50 transition-colors" title="Редактировать">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                                </a>
                                <form method="post" action="/admin/indicators/${indicator.id()}/delete" onsubmit="return confirm('Удалить показатель?')" class="inline">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="text-red-500 hover:text-red-700 p-1 rounded-full hover:bg-red-50 transition-colors" title="Удалить">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                <#else>
                    <tr><td colspan="6" class="px-6 py-8 text-center text-gray-500">Нет показателей</td></tr>
                </#list>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        (function() {
            const searchInput = document.getElementById('searchInput');
            if (!searchInput) return;

            const filterItems = () => {
                const query = searchInput.value.trim().toLowerCase();
                // Фильтр для мобильных карточек
                const cards = document.querySelectorAll('#mobileCardsContainer > div[data-name]');
                cards.forEach(card => {
                    const name = card.getAttribute('data-name');
                    const category = card.getAttribute('data-category');
                    card.style.display = (name && name.includes(query)) || (category && category.includes(query)) ? '' : 'none';
                });
                // Фильтр для десктопной таблицы
                const rows = document.querySelectorAll('#desktopTable tbody tr[data-name]');
                rows.forEach(row => {
                    const name = row.getAttribute('data-name');
                    const category = row.getAttribute('data-category');
                    row.style.display = (name && name.includes(query)) || (category && category.includes(query)) ? '' : 'none';
                });
            };

            searchInput.addEventListener('input', filterItems);
            filterItems(); // начальная фильтрация (на случай пустого поиска)
        })();
    </script>
</@layoutMacros.layout>