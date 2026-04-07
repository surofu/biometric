<#import "../shared/layout.ftl" as layoutMacros>

<@layoutMacros.layout title="${analytics.indicatorName()} - Биометрик" selectedPage="3">
    <link href="https://cdn.jsdelivr.net/npm/uplot@1.6.32/dist/uPlot.min.css" rel="stylesheet">
    <style>
        .u-wrap { width: 100%; }
        .u-title { display: none !important; }
        .u-legend { display: none !important; }
    </style>

    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">

        <!-- Заголовок -->
        <div class="px-4 sm:px-6 pb-4 border-b border-gray-200">
            <h1 class="text-lg sm:text-xl font-semibold text-gray-800">
                ${analytics.indicatorName()}
            </h1>
            <p class="text-sm text-gray-500 mt-1">${analytics.intervalName()}</p>
        </div>

        <!-- Сводная статистика -->
        <div class="grid grid-cols-3 gap-3 mt-6">
            <div class="bg-white rounded-xl border border-slate-200 px-4 py-3 text-center">
                <p class="text-xs text-gray-500 mb-1">Последнее</p>
                <p class="text-lg font-semibold text-gray-800" id="stat-last">—</p>
            </div>
            <div class="bg-white rounded-xl border border-slate-200 px-4 py-3 text-center">
                <p class="text-xs text-gray-500 mb-1">Среднее</p>
                <p class="text-lg font-semibold text-gray-800" id="stat-avg">—</p>
            </div>
            <div class="bg-white rounded-xl border border-slate-200 px-4 py-3 text-center">
                <p class="text-xs text-gray-500 mb-1">Отклонений</p>
                <p class="text-lg font-semibold" id="stat-out">—</p>
            </div>
        </div>

        <!-- График -->
        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-5 py-4 border-b border-slate-100">
                <h2 class="font-medium text-gray-800">График</h2>
                <p class="text-xs text-gray-400 mt-0.5">
                    Норма: ${analytics.referenceMin()?string["0.##"]} – ${analytics.referenceMax()?string["0.##"]}
                </p>
            </div>

            <div class="p-4 pt-5 pb-2 relative">
                <!-- Легенда -->
                <div class="flex flex-wrap gap-3 mb-4 px-1">
                    <div class="flex items-center gap-1.5">
                        <span class="w-3 h-3 rounded-full bg-emerald-500 inline-block"></span>
                        <span class="text-xs text-gray-500">В норме</span>
                    </div>
                    <div class="flex items-center gap-1.5">
                        <span class="w-3 h-3 rounded-full bg-red-400 inline-block"></span>
                        <span class="text-xs text-gray-500">Выход за норму</span>
                    </div>
                    <div class="flex items-center gap-1.5">
                        <span class="inline-block w-6 border-t-2 border-dashed border-slate-300"></span>
                        <span class="text-xs text-gray-500">Границы нормы</span>
                    </div>
                </div>

                <div id="chart" class="w-full relative"></div>

                <!-- Тултип -->
                <div id="tooltip"
                     class="absolute opacity-0 pointer-events-none z-10 bg-white rounded-lg shadow-lg border border-slate-200 px-3 py-2 text-sm min-w-[140px]"
                     style="transition: opacity 0.15s ease;">
                    <p id="tooltip-label" class="text-gray-500 text-xs mb-1"></p>
                    <p id="tooltip-value" class="font-semibold"></p>
                    <p id="tooltip-status" class="text-xs mt-0.5"></p>
                </div>
            </div>
        </div>

        <!-- История измерений -->
        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-6 py-4 border-b border-slate-100">
                <h2 class="font-medium text-gray-800">История измерений</h2>
            </div>
            <ul class="divide-y divide-slate-100">
                <#list analytics.measurements() as m>
                    <#assign out = (m.value() > analytics.referenceMax()) || (m.value() < analytics.referenceMin())>
                    <li class="flex items-center justify-between px-6 py-3">
                        <div class="flex items-center gap-3">
                            <span class="w-2.5 h-2.5 rounded-full shrink-0 ${out?then('bg-red-400', 'bg-emerald-400')}"></span>
                            <span class="text-sm text-gray-700">${m.label()}</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="font-semibold ${out?then('text-red-600', 'text-gray-800')}">${m.value()?string["0.##"]}</span>
                            <#if out>
                                <span class="text-xs px-2 py-0.5 rounded-full bg-red-50 text-red-500 font-medium">
                                    ${(m.value() > analytics.referenceMax())?then('↑ выше нормы', '↓ ниже нормы')}
                                </span>
                            </#if>
                        </div>
                    </li>
                </#list>
                <#if !analytics.measurements()?has_content>
                    <li class="px-6 py-8 text-center text-sm text-gray-400">Нет данных для отображения</li>
                </#if>
            </ul>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/uplot@1.6.32/dist/uPlot.iife.min.js"></script>
    <script>
        (function () {
            const NORM_HIGH = ${analytics.referenceMax()?c};
            const NORM_LOW  = ${analytics.referenceMin()?c};

            const labels = [<#list analytics.data().shotLabels() as l>"${l}"<#sep>, </#sep></#list>];
            const values = [<#list analytics.data().values() as v>${v?c}<#sep>, </#sep></#list>];
            const refMax  = [<#list analytics.data().referenceMax() as v>${v?c}<#sep>, </#sep></#list>];
            const refMin  = [<#list analytics.data().referenceMin() as v>${v?c}<#sep>, </#sep></#list>];

            const xs        = labels.map((_, i) => i);
            const chartData = [xs, values, refMax, refMin];

            const last     = values[values.length - 1];
            const avg      = (values.reduce((a, b) => a + b, 0) / values.length).toFixed(1);
            const outCount = values.filter(v => v > NORM_HIGH || v < NORM_LOW).length;

            document.getElementById('stat-last').textContent = +last.toFixed(2) + '';
            document.getElementById('stat-avg').textContent  = avg;
            const statOut = document.getElementById('stat-out');
            statOut.textContent  = outCount;
            statOut.className    = 'text-lg font-semibold ' + (outCount > 0 ? 'text-red-500' : 'text-emerald-600');

            const chartEl = document.getElementById('chart');
            const H = 220;

            const C_GREEN = '#10b981';
            const C_RED   = '#f87171';
            const C_NORM  = '#94a3b8';
            const C_GRID  = '#f1f5f9';
            const C_AXIS  = '#94a3b8';

            const opts = {
                width:   chartEl.getBoundingClientRect().width || 340,
                height:  H,
                padding: [8, 8, 0, 0],
                select:  {show: false},
                legend:  {show: false},
                series: [
                    {},
                    {
                        label: '${analytics.indicatorName()}',
                        scale: 'y', stroke: C_GREEN, width: 2.5,
                        fill: 'rgba(16,185,129,0.06)', points: {show: false},
                    },
                    {
                        label: 'Верхняя норма', scale: 'y',
                        stroke: C_NORM, dash: [5, 4], width: 1.5, points: {show: false},
                    },
                    {
                        label: 'Нижняя норма', scale: 'y',
                        stroke: C_NORM, dash: [5, 4], width: 1.5, points: {show: false},
                    },
                ],
                bands:  [{series: [2, 3], fill: 'rgba(16,185,129,0.08)'}],
                scales: {
                    x: {time: false, range: [-0.5, labels.length - 0.5]},
                    y: {}
                },
                axes: [
                    {
                        stroke: C_AXIS,
                        grid:   {stroke: C_GRID, width: 1},
                        ticks:  {stroke: C_GRID, width: 1, size: 4},
                        values: (u, ticks) => ticks.map(v => {
                            const i = Math.round(v);
                            return (i >= 0 && i < labels.length) ? labels[i] : '';
                        }),
                        size: 28, gap: 4, font: '11px system-ui',
                    },
                    {
                        scale: 'y', stroke: C_AXIS,
                        grid:  {stroke: C_GRID, width: 1},
                        ticks: {stroke: C_GRID, width: 1, size: 4},
                        size: 36, gap: 4, font: '11px system-ui',
                    },
                ],
                hooks: {
                    draw: [u => {
                        const ctx = u.ctx;
                        const dpr = devicePixelRatio;
                        ctx.save();
                        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
                        ctx.imageSmoothingEnabled = true;
                        values.forEach((val, i) => {
                            const cx  = Math.round(u.valToPos(xs[i], 'x', true) / dpr);
                            const cy  = Math.round(u.valToPos(val,   'y', true) / dpr);
                            const out = val > NORM_HIGH || val < NORM_LOW;
                            ctx.beginPath();
                            ctx.arc(cx, cy, 5, 0, Math.PI * 2);
                            ctx.fillStyle = out ? C_RED : C_GREEN;
                            ctx.fill();
                        });
                        ctx.restore();
                    }],
                    setCursor: [u => {
                        const tip = document.getElementById('tooltip');
                        const {idx} = u.cursor;
                        if (idx == null || idx < 0 || idx >= values.length) {
                            tip.style.opacity = 0;
                            return;
                        }
                        const val = values[idx];
                        const out = val > NORM_HIGH || val < NORM_LOW;
                        const cx  = u.valToPos(xs[idx], 'x') + u.bbox.left / devicePixelRatio;
                        const cy  = u.valToPos(val,     'y') + u.bbox.top  / devicePixelRatio;
                        const tipW = 150, tipH = 70;
                        let tx = cx + 12, ty = cy - tipH / 2;
                        if (tx + tipW > chartEl.getBoundingClientRect().width) tx = cx - tipW - 12;
                        if (ty < 0) ty = 4;
                        tip.style.left    = tx + 'px';
                        tip.style.top     = ty + 'px';
                        tip.style.opacity = 1;
                        document.getElementById('tooltip-label').textContent = labels[idx];
                        const valEl = document.getElementById('tooltip-value');
                        valEl.textContent = +val.toFixed(2) + '';
                        valEl.className   = 'font-semibold ' + (out ? 'text-red-600' : 'text-emerald-700');
                        const stEl = document.getElementById('tooltip-status');
                        stEl.textContent = out
                            ? (val > NORM_HIGH ? '▲ Выше нормы' : '▼ Ниже нормы')
                            : '✓ В пределах нормы';
                        stEl.className = 'text-xs mt-0.5 ' + (out ? 'text-red-400' : 'text-emerald-500');
                    }]
                }
            };

            const chart = new uPlot(opts, chartData, chartEl);
            window.addEventListener('resize', () =>
                chart.setSize({width: chartEl.getBoundingClientRect().width, height: H})
            );
        })();
    </script>
</@layoutMacros.layout>