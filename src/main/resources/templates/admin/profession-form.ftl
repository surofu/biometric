<#import "../shared/admin-layout.ftl" as adminLayoutMacros>

<@adminLayoutMacros.adminLayout title="Профессия" selectedPage="professions">
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">

        <a href="/admin/professions"
           class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-emerald-600 transition-colors mb-6">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M10 19l-7-7 m0 0l7-7 m-7 7h18"/>
            </svg>
            Назад к списку
        </a>

        <div class="bg-white rounded-xl border border-gray-100 overflow-hidden shadow-sm">
            <div class="p-6 border-b border-gray-50">
                <h1 class="text-xl font-bold text-gray-800">
                    <#if request.id??>Редактирование профессии<#else>Новая профессия</#if>
                </h1>
            </div>

            <form action="/admin/professions/save" method="post" id="professionForm" class="p-6 space-y-6">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <#if request.id??>
                    <input type="hidden" name="id" value="${request.id}">
                </#if>

                <div id="doctorInputsContainer"></div>

                <div>
                    <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                        Название профессии <span class="text-red-500">*</span>
                    </label>
                    <input type="text" id="name" name="name" value="${(request.name)!}" required
                           placeholder="Например: Водитель категории C"
                           class="w-full px-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none transition-all">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-3">
                        Состав медицинской комиссии
                    </label>

                    <div id="selectedDoctorsList" class="flex flex-wrap gap-2 mb-4">
                    </div>

                    <button type="button" id="openDoctorPopup"
                            class="w-full flex items-center justify-center gap-2 px-4 py-3 border-2 border-dashed border-gray-300 rounded-xl text-sm text-gray-500 hover:border-emerald-400 hover:text-emerald-600 hover:bg-emerald-50 transition-all">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        Добавить врача
                    </button>
                </div>

                <div class="pt-4 flex items-center justify-end gap-3 border-t border-gray-50">
                    <a href="/admin/professions" class="px-5 py-2.5 text-sm text-gray-600 hover:bg-gray-50 rounded-lg">Отмена</a>
                    <button type="submit"
                            class="px-6 py-2.5 bg-emerald-600 text-white text-sm font-semibold rounded-lg hover:bg-emerald-700 transition-colors">
                        Сохранить
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div id="doctorPopup" class="fixed pl-64 inset-0 z-50 hidden flex-col bg-white" style="display: none;">
        <div class="flex items-center gap-3 py-3 px-4 border-b border-gray-200 bg-white">
            <button type="button" id="closePopupBtn" class="p-2 -ml-2 text-gray-500 hover:bg-gray-100 rounded-full">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
            <h2 class="text-lg font-semibold text-gray-800 flex-1">Добавление специалиста</h2>
        </div>

        <div class="p-4 bg-gray-50 border-b border-gray-100">
            <div class="relative max-w-2xl mx-auto">
                <input type="text" id="doctorSearchInput" placeholder="Введите название (например: Хирург)..."
                       class="w-full px-4 py-3 pl-11 border border-gray-300 rounded-xl focus:ring-2 focus:ring-emerald-500 outline-none">
                <svg class="absolute left-4 top-3.5 w-5 h-5 text-gray-400" fill="none" stroke="currentColor"
                     viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z"/>
                </svg>
            </div>
        </div>

        <div class="flex-1 overflow-y-auto p-4">
            <div id="doctorResults" class="grid grid-cols-1 sm:grid-cols-2 gap-3 max-w-2xl mx-auto"></div>
            <p id="noResults" class="hidden text-center py-10 text-gray-400">Врачи не найдены</p>
        </div>
    </div>

    <script>
        (function () {
            const catalog = [
                <#list allDoctors as d>
                {id: ${d.id()?c}, name: '${d.name()?js_string}'}<#sep>, </#sep>
                </#list>
            ];

            let selected = [
                <#list profession.doctors() as d>
                {id: ${d.id()?c}, name: '${d.name()?js_string}'}<#sep>, </#sep>
                </#list>
            ];

            const resultsContainer = document.getElementById('doctorResults');
            const selectedList = document.getElementById('selectedDoctorsList');
            const inputsContainer = document.getElementById('doctorInputsContainer');
            const searchInput = document.getElementById('doctorSearchInput');
            const popup = document.getElementById('doctorPopup');

            function renderSelected() {
                selectedList.innerHTML = '';
                inputsContainer.innerHTML = '';

                selected.forEach(doc => {
                    const chip = document.createElement('div');
                    chip.className = 'inline-flex items-center gap-2 px-3 py-2 bg-emerald-50 text-emerald-700 border border-emerald-100 rounded-lg text-sm font-medium';
                    chip.innerHTML = '<span>' + doc.name + '</span>' +
                        '<button type="button" class="text-emerald-400 hover:text-emerald-600" onclick="removeDoctor(' + doc.id + ')">' +
                        '<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/></svg>' +
                        '</button>';

                    selectedList.appendChild(chip);

                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'doctorIds';
                    input.value = doc.id;
                    inputsContainer.appendChild(input);
                });

                if (selected.length === 0) {
                    selectedList.innerHTML = '<p class="text-sm text-gray-400 py-2">Специалисты не выбраны</p>';
                }
            }

            window.removeDoctor = function (id) {
                selected = selected.filter(d => d.id !== id);
                renderSelected();
            };

            function renderResults(query = '') {
                resultsContainer.innerHTML = '';
                const q = query.toLowerCase().trim();

                const filtered = catalog.filter(d =>
                    d.name.toLowerCase().includes(q) && !selected.some(s => s.id === d.id)
                );

                filtered.forEach(doc => {
                    const btn = document.createElement('button');
                    btn.type = 'button';
                    btn.className = 'flex items-center justify-between px-4 py-3 border border-gray-200 rounded-xl hover:border-emerald-500 hover:bg-emerald-50 transition-all text-left';
                    btn.innerHTML = '<span class="text-sm font-medium text-gray-700">' + doc.name + '</span>' +
                        '<svg class="w-5 h-5 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>';

                    btn.onclick = () => {
                        selected.push(doc);
                        renderSelected();
                        closePopup();
                    };
                    resultsContainer.appendChild(btn);
                });

                document.getElementById('noResults').classList.toggle('hidden', filtered.length > 0);
            }

            function openPopup() {
                popup.style.display = 'flex';
                document.body.style.overflow = 'hidden';
                searchInput.value = '';
                renderResults();
                setTimeout(() => searchInput.focus(), 50);
            }

            function closePopup() {
                popup.style.display = 'none';
                document.body.style.overflow = '';
            }

            document.getElementById('openDoctorPopup').onclick = openPopup;
            document.getElementById('closePopupBtn').onclick = closePopup;
            searchInput.oninput = (e) => renderResults(e.target.value);

            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && popup.style.display === 'flex') closePopup();
            });

            renderSelected();
        })();
    </script>
</@adminLayoutMacros.adminLayout>