<#import "../shared/layout.ftl" as layoutMacros>
<#import "../shared/message.ftl" as messageMacros>

<@layoutMacros.layout title="Оформление подписки" selectedPage="5">
    <div class="container max-w-2xl mx-auto p-4">

        <@messageMacros.message />

        <#-- Карточка плана -->
        <div class="bg-white rounded-xl border border-slate-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-slate-100 flex items-center justify-between">
                <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Подписка</p>
                <span class="inline-flex items-center gap-1 text-xs font-semibold text-amber-600 bg-amber-50 border border-amber-200 rounded-full px-2.5 py-0.5">
                    <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                    </svg>
                    Премиум
                </span>
            </div>

            <div class="px-6 py-5">
                <div class="flex items-start justify-between gap-4">
                    <div>
                        <h2 class="text-lg font-bold text-gray-900">${plan.name()}</h2>
                        <p class="text-sm text-gray-500 mt-1">${plan.description()}</p>
                    </div>
                    <div class="text-right shrink-0">
                        <p class="text-2xl font-bold text-gray-900">${plan.price()} <span class="text-base font-normal text-gray-400">${plan.currency()}</span></p>
                        <p class="text-xs text-gray-400">за ${plan.durationMonths()} мес.</p>
                    </div>
                </div>
            </div>
        </div>

        <#if hasActive>
            <#-- Уже есть активная подписка -->
            <div class="bg-white rounded-xl border border-amber-200 overflow-hidden mt-3">
                <div class="px-6 py-5 flex items-center gap-4">
                    <div class="w-10 h-10 bg-amber-100 rounded-full flex items-center justify-center shrink-0">
                        <svg class="w-5 h-5 text-amber-600" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                        </svg>
                    </div>
                    <div>
                        <p class="text-sm font-semibold text-gray-800">Подписка активна</p>
                        <p class="text-xs text-gray-400 mt-0.5">
                            Действует до ${dateFormatter.format(activeSubscription.endDate())}
                        </p>
                    </div>
                </div>
            </div>
        <#else>
            <#-- Форма оплаты -->
            <div class="bg-white rounded-xl border border-slate-200 overflow-hidden mt-3">
                <div class="px-6 py-4 border-b border-slate-100">
                    <p class="text-xs font-semibold text-gray-400 uppercase tracking-wide">Данные карты</p>
                </div>

                <form action="/subscription" method="post" class="px-6 py-5 space-y-4">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="planId" value="${plan.savedId()}"/>

                    <#-- Ошибки -->
                    <#if errors?? && errors?size gt 0>
                        <div class="rounded-lg bg-red-50 border border-red-200 px-4 py-3 text-sm text-red-600 space-y-1">
                            <#list errors as error>
                                <p>${error.defaultMessage}</p>
                            </#list>
                        </div>
                    </#if>

                    <#-- Имя владельца -->
                    <label class="block">
                        <span class="text-sm text-gray-700 mb-1 block">Имя владельца</span>
                        <input type="text" name="cardHolder"
                               value="${(formRequest.cardHolder())!''}"
                               placeholder="IVAN IVANOV"
                               maxlength="100"
                               autocomplete="cc-name"
                               class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all uppercase tracking-wider placeholder:normal-case placeholder:tracking-normal"/>
                    </label>

                    <#-- Номер карты -->
                    <label class="block">
                        <span class="text-sm text-gray-700 mb-1 block">Номер карты</span>
                        <div class="relative">
                            <input type="text" name="cardNumber" id="cardNumber"
                                   value="${(formRequest.cardNumber())!''}"
                                   placeholder="0000 0000 0000 0000"
                                   maxlength="19"
                                   autocomplete="cc-number"
                                   inputmode="numeric"
                                   class="w-full border border-slate-300 rounded-lg pl-4 pr-12 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all tracking-widest"/>
                            <svg class="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                            </svg>
                        </div>
                    </label>

                    <div class="grid grid-cols-2 gap-3">
                        <#-- Срок действия -->
                        <label class="block">
                            <span class="text-sm text-gray-700 mb-1 block">Срок действия</span>
                            <input type="text" name="expiryDate" id="expiryDate"
                                   value="${(formRequest.expiryDate())!''}"
                                   placeholder="ММ/ГГ"
                                   maxlength="5"
                                   autocomplete="cc-exp"
                                   inputmode="numeric"
                                   class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all tracking-widest"/>
                        </label>

                        <#-- CVV -->
                        <label class="block">
                            <span class="text-sm text-gray-700 mb-1 block">CVV</span>
                            <input type="password" name="cvv"
                                   placeholder="•••"
                                   maxlength="3"
                                   autocomplete="cc-csc"
                                   inputmode="numeric"
                                   class="w-full border border-slate-300 rounded-lg px-4 py-3 md:py-2 text-sm outline-none focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 transition-all"/>
                        </label>
                    </div>

                    <p class="text-[11px] text-slate-400 text-center pt-1">
                        Тестовый режим. Для успешной оплаты используйте карту с одинаковыми цифрами, например <span class="font-mono">1111&nbsp;1111&nbsp;1111&nbsp;1111</span>.
                    </p>

                    <button type="submit"
                            class="w-full bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium px-5 py-3 md:py-2 rounded-lg transition-colors mt-2">
                        Оформить подписку — ${plan.price()} ${plan.currency()}
                    </button>
                </form>
            </div>
        </#if>

        <div class="mt-3 text-center">
            <a href="/profile" class="text-sm text-gray-400 hover:text-gray-600 transition-colors">← Назад к профилю</a>
        </div>
    </div>

    <script>
        // Форматирование номера карты: 4-4-4-4
        const cardInput = document.getElementById('cardNumber');
        if (cardInput) {
            cardInput.addEventListener('input', function () {
                let val = this.value.replace(/\D/g, '').substring(0, 16);
                this.value = val.replace(/(.{4})/g, '$1 ').trim();
            });
            // При сабмите убираем пробелы — но name="cardNumber" отправит с пробелами,
            // поэтому очищаем перед отправкой через hidden input
            cardInput.closest('form')?.addEventListener('submit', function () {
                cardInput.value = cardInput.value.replace(/\s/g, '');
            });
        }

        // Форматирование срока: MM/YY
        const expiryInput = document.getElementById('expiryDate');
        if (expiryInput) {
            expiryInput.addEventListener('input', function () {
                let val = this.value.replace(/\D/g, '').substring(0, 4);
                if (val.length >= 3) {
                    this.value = val.substring(0, 2) + '/' + val.substring(2);
                } else {
                    this.value = val;
                }
            });
        }
    </script>
</@layoutMacros.layout>
