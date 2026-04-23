<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>
<#import "../shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="${analytics.indicatorName} - Биометрик" selectedPage="3">
    <link href="https://cdn.jsdelivr.net/npm/uplot@1.6.32/dist/uPlot.min.css" rel="stylesheet">
    <style>
        .u-wrap {
            width: 100%;
        }

        .u-title, .u-legend {
            display: none !important;
        }

        .chart-scroll-container {
            width: 100%;
            overflow-x: auto;
            overflow-y: hidden;
            cursor: grab;
            -webkit-overflow-scrolling: touch;
        }

        .chart-scroll-container:active {
            cursor: grabbing;
        }

        .chart-scroll-container::-webkit-scrollbar {
            height: 4px;
        }

        .chart-scroll-container::-webkit-scrollbar-thumb {
            background: #e2e8f0;
            border-radius: 10px;
        }

        .chart-wrapper {
            position: relative;
            display: block;
            min-width: 100%;
        }

        #tooltip {
            position: fixed;
            z-index: 1000;
            pointer-events: none;
            transition: opacity 0.1s ease;
        }
    </style>

    <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">
        <@messageMacros.message />
        <@pageHeaderMacros.pageHeader
        title="${analytics.indicatorName}"
        subtitle="Аналитика"
        backUrl="/analytics"
        />

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

        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-5 py-4 border-b border-slate-100 flex justify-between items-center">
                <div>
                    <h2 class="font-medium text-gray-800">График</h2>
                    <p class="text-xs text-gray-400 mt-0.5">
                        Норма: ${analytics.referenceMin?string["0.##"]} – ${analytics.referenceMax?string["0.##"]}
                    </p>
                </div>
                <div id="scroll-hint" class="hidden">
                    <span class="text-[10px] text-slate-400 uppercase tracking-widest">Листайте →</span>
                </div>
            </div>

            <div class="p-4 pt-5 pb-2">
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

                <div class="chart-scroll-container" id="scroll-parent">
                    <div class="chart-wrapper">
                        <div id="chart"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
            <div class="px-6 py-4 border-b border-slate-100">
                <h2 class="font-medium text-gray-800">История измерений</h2>
            </div>
            <ul class="divide-y divide-slate-100">
                <#list analytics.measurements as m>
                    <#assign out = (m.value > analytics.referenceMax) || (m.value < analytics.referenceMin)>
                    <li class="flex items-center justify-between px-6 py-3">
                        <div class="flex items-center gap-3">
                            <span class="w-2.5 h-2.5 rounded-full shrink-0 ${out?then('bg-red-400', 'bg-emerald-400')}"></span>
                            <span class="text-sm text-gray-700">${m.label}</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="font-semibold ${out?then('text-red-600', 'text-gray-800')}">${m.value?string["0.##"]}</span>
                            <#if out>
                                <span class="text-xs px-2 py-0.5 rounded-full bg-red-50 text-red-500 font-medium">
                                    ${(m.value > analytics.referenceMax)?then('↑ выше нормы', '↓ ниже нормы')}
                                </span>
                            </#if>
                        </div>
                    </li>
                </#list>
                <#if !analytics.measurements?has_content>
                    <li class="px-6 py-8 text-center text-sm text-gray-400">Нет данных для отображения</li>
                </#if>
            </ul>
        </div>

    </div>

    <div id="tooltip" class="hidden bg-white rounded-lg border border-slate-200 px-3 py-2 text-sm min-w-35 shadow-lg">
        <p id="tooltip-label" class="text-gray-500 text-xs mb-1"></p>
        <p id="tooltip-value" class="font-semibold"></p>
        <p id="tooltip-status" class="text-xs mt-0.5"></p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/uplot@1.6.32/dist/uPlot.iife.min.js"></script>
    <script>
        (function () {
            const NORM_HIGH = ${analytics.referenceMax?c};
            const NORM_LOW = ${analytics.referenceMin?c};

            const labels = [<#list analytics.data.shotLabels as l>"${l}"<#sep>, </#sep></#list>];
            const values = [<#list analytics.data.values as v>${v?c}<#sep>, </#sep></#list>];
            const refMax = [<#list analytics.data.referenceMax as v>${v?c}<#sep>, </#sep></#list>];
            const refMin = [<#list analytics.data.referenceMin as v>${v?c}<#sep>, </#sep></#list>];

            const last = values[values.length - 1];
            const avg = (values.reduce((a, b) => a + b, 0) / values.length).toFixed(1);
            const outCount = values.filter(v => v > NORM_HIGH || v < NORM_LOW).length;

            document.getElementById('stat-last').textContent = last ? last.toFixed(2) : '—';
            document.getElementById('stat-avg').textContent = avg || '—';
            const statOut = document.getElementById('stat-out');
            statOut.textContent = outCount;
            statOut.className = 'text-lg font-semibold ' + (outCount > 0 ? 'text-red-500' : 'text-emerald-600');

            const xs = labels.map((_, i) => i);
            const chartData = [xs, values, refMax, refMin];

            const chartEl = document.getElementById('chart');
            const scrollParent = document.getElementById('scroll-parent');
            const tooltip = document.getElementById('tooltip');
            const H = 220;
            const MIN_POINT_DISTANCE = 60;

            function calculateWidth() {
                const containerWidth = scrollParent.clientWidth;
                const dynamicWidth = labels.length * MIN_POINT_DISTANCE;
                const finalWidth = Math.max(containerWidth, dynamicWidth);
                const hint = document.getElementById('scroll-hint');
                if (hint) hint.classList.toggle('hidden', finalWidth <= containerWidth);
                return finalWidth;
            }

            const C_GREEN = '#10b981';
            const C_RED = '#f87171';
            const C_NORM = '#94a3b8';
            const C_GRID = '#f1f5f9';
            const C_AXIS = '#94a3b8';

            function showTooltip(idx, mouseX, mouseY) {
                const val = values[idx];
                const out = val > NORM_HIGH || val < NORM_LOW;

                document.getElementById('tooltip-label').textContent = labels[idx];
                const valEl = document.getElementById('tooltip-value');
                valEl.textContent = val.toFixed(2);
                valEl.className = 'font-semibold ' + (out ? 'text-red-600' : 'text-emerald-700');

                const stEl = document.getElementById('tooltip-status');
                stEl.textContent = out
                    ? (val > NORM_HIGH ? '▲ Выше нормы' : '▼ Ниже нормы')
                    : '✓ В пределах нормы';
                stEl.className = 'text-xs mt-0.5 ' + (out ? 'text-red-400' : 'text-emerald-500');

                tooltip.classList.remove('hidden');

                const tipRect = tooltip.getBoundingClientRect();
                let x = mouseX - (tipRect.width / 2);
                let y = mouseY - tipRect.height - 15;

                if (x < 10) x = 10;
                if (x + tipRect.width > window.innerWidth - 10) x = window.innerWidth - tipRect.width - 10;
                if (y < 10) y = mouseY + 20;

                tooltip.style.transform = 'translate(' + x + 'px, ' + y + 'px)';
                tooltip.style.left = '0';
                tooltip.style.top = '0';
            }

            const opts = {
                width: calculateWidth(),
                height: H,
                padding: [8, 12, 0, 12],
                select: {show: false},
                legend: {show: false},
                series: [
                    {},
                    {
                        label: '${analytics.indicatorName}',
                        scale: 'y', stroke: C_GREEN, width: 2.5,
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
                scales: {
                    x: {time: false, range: [-0.5, labels.length - 0.5]},
                    y: {}
                },
                axes: [
                    {
                        stroke: C_AXIS,
                        grid: {stroke: C_GRID, width: 1},
                        ticks: {stroke: C_GRID, width: 1, size: 4},
                        values: (u, ticks) => ticks.map(v => {
                            const i = Math.round(v);
                            return (i >= 0 && i < labels.length) ? labels[i] : '';
                        }),
                        size: 28, gap: 4, font: '11px system-ui',
                    },
                    {
                        scale: 'y', stroke: C_AXIS,
                        grid: {stroke: C_GRID, width: 1},
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
                        if (refMax.length && refMin.length) {
                            ctx.beginPath();
                            refMax.forEach((val, i) => {
                                const cx = u.valToPos(xs[i], 'x', true) / dpr;
                                const cy = u.valToPos(val, 'y', true) / dpr;
                                i === 0 ? ctx.moveTo(cx, cy) : ctx.lineTo(cx, cy);
                            });
                            for (let i = refMin.length - 1; i >= 0; i--) {
                                const cx = u.valToPos(xs[i], 'x', true) / dpr;
                                const cy = u.valToPos(refMin[i], 'y', true) / dpr;
                                ctx.lineTo(cx, cy);
                            }
                            ctx.closePath();
                            ctx.fillStyle = 'rgba(16,185,129,0.08)';
                            ctx.fill();
                        }
                        values.forEach((val, i) => {
                            const cx = Math.round(u.valToPos(xs[i], 'x', true) / dpr);
                            const cy = Math.round(u.valToPos(val, 'y', true) / dpr);
                            const out = val > NORM_HIGH || val < NORM_LOW;
                            ctx.beginPath();
                            ctx.arc(cx, cy, 5, 0, Math.PI * 2);
                            ctx.fillStyle = out ? C_RED : C_GREEN;
                            ctx.fill();
                        });
                        ctx.restore();
                    }],
                    setCursor: [u => {
                        const {idx, left, top} = u.cursor;
                        if (idx === null || left < 0) {
                            tooltip.classList.add('hidden');
                            return;
                        }
                        const val = values[idx];
                        const canvasRect = u.over.getBoundingClientRect();
                        const mouseX = canvasRect.left + left;
                        const mouseY = canvasRect.top + top;
                        showTooltip(idx, mouseX, mouseY);
                    }]
                }
            };

            const chart = new uPlot(opts, chartData, chartEl);

            requestAnimationFrame(() => {
                setTimeout(() => {
                    scrollParent.scrollTo({
                        left: scrollParent.scrollWidth,
                        behavior: 'smooth'
                    });
                }, 1000);
            });

            window.addEventListener('resize', () => {
                chart.setSize({
                    width: calculateWidth(),
                    height: H
                });
            });

            chartEl.addEventListener('mouseleave', () => {
                tooltip.classList.add('hidden');
            });
        })();
    </script>
</@layoutMacros.layout>