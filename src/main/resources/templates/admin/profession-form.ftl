<#import "layout.ftl" as adminLayoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@adminLayoutMacros.adminLayout title="Профессия" selectedPage="professions">
    <div class="container max-w-2xl mx-auto sm:px-4 sm:pt-8 pb-20">
        <div class="bg-white rounded-xl sm:border border-slate-200 overflow-hidden">
            <div class="mx-2 sm:px-6 py-5 border-b border-slate-100">
                <h1 class="text-lg font-bold text-slate-800">
                    <#if request.id??>Редактирование профессии<#else>Новая профессия</#if>
                </h1>
                <p class="text-slate-400 text-xs mt-1">Параметры профессии</p>
            </div>

            <@messageMacros.message />

            <form action="/admin/professions/save" method="post" id="professionForm" class="p-2 pt-0 sm:p-6 space-y-6">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <#if request.id??>
                    <input type="hidden" name="id" value="${request.id}">
                </#if>

                <div id="doctorInputsContainer"></div>

                <div class="space-y-5">
                    <div>
                        <label for="name" class="block text-xs text-slate-400 mb-2">Название профессии *</label>
                        <input type="text" id="name" name="name" value="${(request.name)!}" required
                               placeholder="Например: Водитель категории C"
                               class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                    </div>

                    <div>
                        <label for="description" class="block text-xs text-slate-400 mb-2">Описание</label>
                        <textarea id="description"
                                  name="description"
                                  rows="4"
                                  oninput="this.style.height = ''; this.style.height = Math.min(this.scrollHeight, 300) + 'px'"
                                  class="w-full px-4 py-2.5 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm resize-y"
                                  placeholder="Краткое описание профессии и профессиональных рисков">${request.description!''}</textarea>
                    </div>

                    <div>
                        <label class="block text-xs text-slate-400 mb-2">Состав медицинской комиссии</label>

                        <div id="selectedDoctorsList" class="flex flex-wrap gap-2 mb-3">
                        </div>

                        <button type="button" id="openDoctorPopup"
                                class="w-full flex items-center justify-center gap-2 px-4 py-3 border-2 border-dashed border-slate-200 rounded-lg text-sm text-slate-400 hover:border-emerald-400 hover:text-emerald-600 hover:bg-emerald-50 transition-all">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                      d="M12 4v16m8-8H4"/>
                            </svg>
                            Добавить врача
                        </button>
                    </div>
                </div>

                <div class="flex sm:justify-end gap-3 border-t border-slate-100 mt-6 pt-6">
                    <a href="/admin/professions"
                       class="not-sm:w-full px-8 py-2.5 text-center border border-slate-200 rounded-lg text-slate-600 hover:bg-slate-50 transition-colors text-sm">Отмена</a>
                    <button type="submit"
                            class="not-sm:w-full px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-sm font-semibold">
                        Сохранить
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div id="doctorPopup" class="fixed sm:pl-64 inset-0 z-50 hidden flex-col bg-white" style="display: none;">
        <div class="flex items-center gap-3 py-3 px-4 border-b border-slate-100 bg-white">
            <button type="button" id="closePopupBtn" class="p-2 -ml-2 text-slate-400 hover:bg-slate-100 rounded-full">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
            <h2 class="text-lg font-bold text-slate-800 flex-1">Добавление специалиста</h2>
        </div>

        <div class="p-4 bg-slate-50 border-b border-slate-100">
            <div class="relative max-w-2xl mx-auto">
                <label>
                    <input type="text" id="doctorSearchInput" placeholder="Введите название (например: Хирург)..."
                           class="w-full px-4 py-2.5 pl-11 border border-slate-200 rounded-lg focus:bg-white focus:ring-2 focus:ring-emerald-500/20 focus:border-emerald-500 outline-none transition-all text-sm">
                </label>
                <svg class="absolute left-4 top-3 w-5 h-5 text-slate-400" fill="none" stroke="currentColor"
                     viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z"/>
                </svg>
            </div>
        </div>

        <div class="flex-1 overflow-y-auto p-4">
            <div id="doctorResults" class="grid grid-cols-1 sm:grid-cols-2 gap-3 max-w-2xl mx-auto"></div>
            <p id="noResults" class="hidden text-center py-10 text-slate-400">Врачи не найдены</p>
        </div>
    </div>

    <script>
        (function () {
            const catalog = [
                <#list doctors as d>
                {id: ${d.id?c}, name: '${d.name?js_string}'}<#sep>, </#sep>
                </#list>
            ];

            let selected = [<#if profession??>
                <#list profession.doctors as d>
                {id: ${d.id?c}, name: '${d.name?js_string}'}<#sep>, </#sep>
                </#list>
                </#if>
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
                    selectedList.innerHTML = '<p class="text-sm text-slate-400 py-2">Специалисты не выбраны</p>';
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
                    btn.className = 'flex items-center justify-between px-4 py-3 border border-slate-200 rounded-lg hover:border-emerald-500 hover:bg-emerald-50 transition-all text-left';
                    btn.innerHTML = '<span class="text-sm font-medium text-slate-700">' + doc.name + '</span>' +
                        '<svg class="w-5 h-5 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>';

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