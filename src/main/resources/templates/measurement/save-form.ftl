<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Добавление показателя" selectedPage="2" showNavbar=true>
    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-18">
        <@messageMacros.message />

        <div class="px-4 pb-4 border-b border-slate-200 flex items-center">
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800">
                <#if measurement.id??>Редактирование показателя<#else>Добавление нового показателя</#if>
            </h1>
        </div>

        <form action="/measurements" method="post" id="measurementForm" class="pt-4">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <#if measurement.id??>
                <input type="hidden" name="id" value="${measurement.id}">
            </#if>
            <input type="hidden" name="indicatorId" id="hiddenIndicatorId" value="${(measurement.indicatorId?c)!}">
            <input type="hidden" name="value" id="hiddenValue" value="${(measurement.value?c)!}">
            <input type="hidden" name="date" id="hiddenDate" value="${dateFormatter.htmlInput(measurement.date)}">

            <div id="step-1">
                <p class="text-base font-semibold text-gray-800 mb-1">Выберите показатель</p>
                <p class="text-sm text-gray-500 mb-4">Найдите и выберите нужный показатель для измерения</p>

                <button type="button" id="selectedIndicatorCard"
                        class="hidden w-full items-center justify-between gap-3 bg-emerald-50 border-2 border-emerald-300 rounded-lg px-4 py-3 hover:border-emerald-500 hover:bg-emerald-100 transition-colors focus:outline-none focus:ring-2 focus:ring-emerald-500 text-left">
                    <svg class="w-5 h-5 text-emerald-600 shrink-0" fill="none" stroke="currentColor"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span class="flex flex-col min-w-0 w-full">
                        <span class="text-sm font-semibold text-emerald-800 truncate" id="selectedIndicatorName"></span>
                        <span class="text-xs text-emerald-600" id="selectedIndicatorRef"></span>
                    </span>
                    <svg class="w-4 h-4 text-emerald-400 shrink-0" fill="none" stroke="currentColor"
                         viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                    </svg>
                </button>

                <button type="button" id="openSelectorBtn"
                        class="w-full flex items-center justify-between gap-3 px-4 py-3 border-2 border-dashed border-slate-200 rounded-lg text-sm text-gray-500 hover:border-emerald-400 hover:text-emerald-600 hover:bg-emerald-50 transition-colors focus:outline-none focus:ring-2 focus:ring-emerald-500">
                    <span class="flex items-center gap-2">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                        </svg>
                        <span>Выбрать показатель</span>
                    </span>
                    <svg class="w-4 h-4 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                </button>
            </div>

            <div id="step-2" class="hidden">
                <p class="text-base font-semibold text-gray-800 mb-1">Укажите дату</p>
                <p class="text-sm text-gray-500 mb-4">Когда было сделано это измерение?</p>

                <label for="dateInput" class="block text-sm font-medium text-gray-700 mb-2">
                    Дата измерения <span class="text-red-500">*</span>
                </label>
                <input type="date" id="dateInput"
                       value="${dateFormatter.htmlInput(measurement.date)}"
                       class="w-full px-3 py-2 text-base border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
            </div>

            <div id="step-3" class="hidden">
                <p class="text-base font-semibold text-gray-800 mb-1">Укажите значение</p>
                <p class="text-sm text-gray-500 mb-4">Введите результат измерения</p>

                <label for="valueInput" class="block text-sm font-medium text-gray-700 mb-2">
                    Значение <span class="text-red-500">*</span>
                </label>
                <div class="flex items-center gap-3">
                    <input type="number" id="valueInput" value="${(measurement.value?c)!}" step="0.01"
                           placeholder="Введите значение"
                           class="flex-1 px-3 py-2 text-base border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all">
                    <span id="unitLabel" class="text-sm text-gray-500 shrink-0 min-w-8"></span>
                </div>
            </div>
        </form>

        <div class="w-full pt-6 flex justify-between items-center gap-3">
            <button type="button" id="navBack"
                    class="flex items-center justify-center w-full max-w-36 gap-1.5 px-5 py-2.5 border border-slate-200 rounded-md text-sm text-gray-700 hover:bg-gray-50 transition-colors focus:outline-none">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                </svg>
                Назад
            </button>
            <button type="button" id="navNext"
                    class="flex items-center justify-center w-full max-w-48 gap-1.5 px-5 py-2.5 bg-emerald-600 text-white text-sm font-semibold rounded-md hover:bg-emerald-700 focus:outline-none transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                    disabled>
                <span id="navNextText">Далее</span>
                <svg id="navNextIcon" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                </svg>
            </button>
        </div>
    </div>

    <div id="indicatorPopup" class="fixed inset-0 z-50 hidden flex-col bg-white px-4" style="display: none;">
        <div class="flex items-center gap-3 py-3 border-b border-slate-200 bg-white shrink-0 w-full max-w-2xl mx-auto">
            <button type="button" id="closePopupBtn"
                    class="p-2 -ml-2 rounded-md text-gray-500 hover:bg-gray-100 transition-colors focus:outline-none">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
            <h2 class="text-base font-semibold text-gray-800 flex-1">Выбор показателя</h2>
        </div>
        <div class="py-3 border-b border-slate-200 bg-white shrink-0 w-full max-w-2xl mx-auto">
            <div class="relative w-full">
                <label>
                    <input type="text" id="searchInput" placeholder="Поиск по названию…" autocomplete="off"
                           class="w-full px-3 py-2 pl-9 text-sm border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500">
                </label>
                <svg class="absolute left-2.5 top-2.5 w-4 h-4 text-gray-400 pointer-events-none" fill="none"
                     stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                          d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z"/>
                </svg>
            </div>
        </div>
        <div class="flex-1 overflow-y-auto py-3">
            <div class="space-y-4 max-w-2xl mx-auto mb-16" id="indicatorGroups"></div>
            <p id="noResults" class="hidden text-sm text-gray-500 py-8 text-center">Ничего не найдено</p>
        </div>
    </div>

    <script>
        (function () {
            const allIndicators = [
                <#list indicators as ind>
                {
                    id: ${ind.id?c},
                    name: '${ind.name?js_string}',
                    unit: '${ind.unit?js_string}',
                    categoryId: <#if ind.categoryId??>${ind.categoryId?c}<#else>null</#if>,
                    categoryName: '${ind.categoryName?js_string}',
                    referenceMin: <#if ind.referenceMin??>${ind.referenceMin?c}<#else>null</#if>,
                    referenceMax: <#if ind.referenceMax??>${ind.referenceMax?c}<#else>null</#if>
                }<#sep>, </#sep>
                </#list>
            ];

            let currentStep = 1;
            let selectedIndicator = null;

            const navBack = document.getElementById('navBack');
            const navNext = document.getElementById('navNext');
            const navNextText = document.getElementById('navNextText');
            const navNextIcon = document.getElementById('navNextIcon');
            const popup = document.getElementById('indicatorPopup');

            function openPopup() {
                popup.style.display = 'flex';
                document.body.style.overflow = 'hidden';
                qs('#searchInput').value = '';
                renderIndicators('');
                setTimeout(() => qs('#searchInput').focus(), 100);
            }

            function closePopup() {
                popup.style.display = 'none';
                document.body.style.overflow = '';
            }

            document.getElementById('openSelectorBtn').onclick = openPopup;
            document.getElementById('selectedIndicatorCard').onclick = openPopup;
            document.getElementById('closePopupBtn').onclick = closePopup;

            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && popup.style.display === 'flex') closePopup();
            });

            function goTo(step) {
                qs('#step-' + currentStep).classList.add('hidden');
                currentStep = step;
                qs('#step-' + currentStep).classList.remove('hidden');
                updateNav();
                window.scrollTo({top: 0, behavior: 'smooth'});
            }

            navBack.onclick = () => goTo(currentStep - 1);

            function updateNav() {
                navBack.classList.toggle('opacity-0', currentStep === 1);
                navBack.classList.toggle('pointer-events-none', currentStep === 1);

                if (currentStep === 3) {
                    navNextIcon.classList.add("hidden");
                    navNextText.textContent = '<#if measurement.id??>Сохранить<#else>Добавить</#if>';
                    navNext.disabled = false;
                    navNext.onclick = submitForm;
                } else {
                    navNextText.textContent = 'Далее';
                    navNextIcon.classList.remove("hidden");
                    navNext.onclick = handleNext;
                    navNext.disabled = (currentStep === 1 && selectedIndicator === null);
                }
            }

            function handleNext() {
                if (currentStep === 1 && selectedIndicator) {
                    goTo(2);
                } else if (currentStep === 2) {
                    if (!qs('#dateInput').value) {
                        highlightError('#dateInput');
                        return;
                    }
                    goTo(3);
                }
            }

            function submitForm() {
                if (!qs('#valueInput').value) {
                    highlightError('#valueInput');
                    return;
                }
                qs('#hiddenValue').value = qs('#valueInput').value;
                qs('#hiddenDate').value = qs('#dateInput').value;
                qs('#measurementForm').submit();
            }

            function highlightError(selector) {
                const el = qs(selector);
                el.classList.add('border-red-400', 'ring-2', 'ring-red-100');
                el.focus();
                el.oninput = () => el.classList.remove('border-red-400', 'ring-2', 'ring-red-100');
            }

            function referenceText(ind) {
                return (ind.referenceMin != null && ind.referenceMax != null)
                    ? 'Норма: ' + ind.referenceMin + ' – ' + ind.referenceMax + ' ' + ind.unit
                    : (ind.unit || '');
            }

            function applyIndicator(ind) {
                qs('#selectedIndicatorName').textContent = ind.name;
                qs('#selectedIndicatorRef').textContent = referenceText(ind);
                qs('#selectedIndicatorCard').classList.remove('hidden');
                qs('#selectedIndicatorCard').classList.add('flex');
                qs('#openSelectorBtn').classList.add('hidden');
                qs('#unitLabel').textContent = ind.unit || '';
                qs('#hiddenIndicatorId').value = ind.id;
            }

            function renderIndicators(query) {
                const container = qs('#indicatorGroups');
                const noResults = qs('#noResults');
                container.innerHTML = '';

                const q = query.trim().toLowerCase();
                const filtered = q ? allIndicators.filter(i => i.name.toLowerCase().includes(q)) : allIndicators;

                if (filtered.length === 0) {
                    noResults.classList.remove('hidden');
                    return;
                }
                noResults.classList.add('hidden');

                const groups = new Map();
                filtered.forEach(ind => {
                    if (!groups.has(ind.categoryId)) groups.set(ind.categoryId, {name: ind.categoryName, items: []});
                    groups.get(ind.categoryId).items.push(ind);
                });

                groups.forEach(group => {
                    const groupEl = document.createElement('div');
                    groupEl.innerHTML = '<p class="text-xs font-semibold text-gray-400 uppercase tracking-wide mb-2 px-1">' + group.name + '</p>';
                    const list = document.createElement('div');
                    list.className = 'grid grid-cols-1 gap-2';

                    group.items.forEach(ind => {
                        const isSelected = selectedIndicator && selectedIndicator.id === ind.id;
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'text-left px-4 py-3 border rounded-lg w-full hover:border-emerald-400 hover:bg-emerald-50 transition-colors focus:outline-none flex items-center justify-between gap-3 ' + (isSelected ? 'border-emerald-400 bg-emerald-50' : 'border-slate-200');

                        btn.innerHTML = '<div><p class="font-medium text-gray-800 text-sm">' + esc(ind.name) + '</p><p class="text-xs text-gray-500 mt-0.5">' + esc(referenceText(ind)) + '</p></div>' +
                            (isSelected ? '<svg class="w-5 h-5 text-emerald-500 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 13l4 4L19 7"/></svg>' : '<svg class="w-4 h-4 text-gray-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/></svg>');

                        btn.onclick = () => {
                            selectedIndicator = ind;
                            applyIndicator(ind);
                            closePopup();
                            navNext.disabled = false;
                            updateNav();
                        };
                        list.appendChild(btn);
                    });
                    groupEl.appendChild(list);
                    container.appendChild(groupEl);
                });
            }

            qs('#searchInput').oninput = function () {
                renderIndicators(this.value);
            };

            const editIndicatorId = <#if measurement.indicatorId??>${measurement.indicatorId?c}<#else>null</#if>;
            if (editIndicatorId) {
                const ind = allIndicators.find(i => i.id === editIndicatorId);
                if (ind) {
                    selectedIndicator = ind;
                    applyIndicator(ind);
                    renderIndicators('');
                    goTo(3);
                }
            } else {
                renderIndicators('');
                updateNav();
            }

            function qs(sel) {
                return document.querySelector(sel);
            }

            function esc(s) {
                return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
            }
        })();
    </script>
</@layoutMacros.layout>