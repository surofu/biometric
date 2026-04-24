<#import "./shared/layout.ftl" as layoutMacros>
<#import "./shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="Политика конфиденциальности" selectedPage="">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">

            <@pageHeaderMacros.pageHeader backUrl="/" title="Политика конфиденциальности" subtitle="Последнее обновление: 19 апреля 2025 г." />

            <div class="mt-8 space-y-8 text-sm text-gray-700 leading-relaxed">

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">1. Общие положения</h2>
                    <p>Настоящая Политика конфиденциальности разработана в соответствии с Законом Республики Беларусь от
                        7 мая 2021 г. №99-З «О защите персональных данных» и регулирует порядок сбора, хранения и
                        обработки персональных данных пользователей сервиса Биометрик.</p>
                    <p class="mt-2">Используя сервис, вы подтверждаете, что ознакомились с настоящей Политикой и даёте
                        согласие на обработку ваших персональных данных на указанных условиях.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">2. Оператор персональных данных</h2>
                    <p>Оператором персональных данных является владелец сервиса Биометрик. По вопросам обработки
                        персональных данных вы можете обратиться по электронной почте: <a
                                href="mailto:support@biometrik.app" class="text-emerald-600 hover:text-emerald-700">support@biometrik.app</a>.
                    </p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">3. Какие данные мы собираем</h2>
                    <div class="space-y-3">
                        <div class="border border-slate-200 rounded-xl overflow-hidden">
                            <div class="px-4 py-3 bg-gray-50 border-b border-slate-200">
                                <p class="font-medium text-gray-700">Данные учётной записи</p>
                            </div>
                            <div class="px-4 py-3">
                                <p>Адрес электронной почты, хэш пароля (при регистрации через email) или идентификатор
                                    Google-аккаунта (при входе через Google).</p>
                            </div>
                        </div>
                        <div class="border border-slate-200 rounded-xl overflow-hidden">
                            <div class="px-4 py-3 bg-gray-50 border-b border-slate-200">
                                <p class="font-medium text-gray-700">Данные о здоровье <span
                                            class="text-xs font-normal text-amber-600 ml-1">специальная категория</span>
                                </p>
                            </div>
                            <div class="px-4 py-3">
                                <p>Результаты лабораторных анализов и медицинских показателей, которые вы вносите
                                    самостоятельно. Эти данные относятся к специальной категории персональных данных и
                                    обрабатываются исключительно с вашего явного согласия.</p>
                            </div>
                        </div>
                        <div class="border border-slate-200 rounded-xl overflow-hidden">
                            <div class="px-4 py-3 bg-gray-50 border-b border-slate-200">
                                <p class="font-medium text-gray-700">Технические данные</p>
                            </div>
                            <div class="px-4 py-3">
                                <p>Файлы cookie сессии (необходимы для поддержания авторизованного состояния), IP-адрес,
                                    дата и время входа.</p>
                            </div>
                        </div>
                    </div>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">4. Цели обработки данных</h2>
                    <ul class="space-y-2">
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Предоставление доступа к сервису и аутентификация пользователя</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Хранение и отображение внесённых вами результатов анализов</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Построение графиков и аналитики на основе ваших данных</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Обеспечение безопасности и предотвращение несанкционированного доступа</span>
                        </li>
                    </ul>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">5. Правовые основания обработки</h2>
                    <p>Обработка персональных данных осуществляется на основании вашего согласия, которое вы даёте при
                        регистрации. Данные о здоровье обрабатываются исключительно на основании отдельного явного
                        согласия. Вы вправе отозвать согласие в любой момент, направив запрос на электронную почту
                        оператора.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">6. Передача данных третьим лицам</h2>
                    <p>Мы не продаём и не передаём ваши данные третьим лицам в коммерческих целях. Исключения:</p>
                    <ul class="mt-2 space-y-2">
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>
                            <span><strong>Google LLC</strong> — при использовании входа через Google OAuth 2.0. Обработка данных Google регулируется <a
                                        href="https://policies.google.com/privacy" target="_blank"
                                        class="text-emerald-600 hover:text-emerald-700">Политикой конфиденциальности Google</a>.</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>
                            <span>По требованию уполномоченных государственных органов Республики Беларусь в случаях, предусмотренных законодательством.</span>
                        </li>
                    </ul>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">7. Срок хранения данных</h2>
                    <p>Ваши данные хранятся в течение всего срока действия вашей учётной записи. После удаления аккаунта
                        данные уничтожаются в течение 30 дней, если иное не требуется законодательством.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">8. Ваши права</h2>
                    <p>В соответствии с Законом РБ «О защите персональных данных» вы имеете право:</p>
                    <ul class="mt-2 space-y-2">
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Получить информацию о том, какие ваши данные обрабатываются и с какой целью</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Потребовать исправления неточных данных</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Отозвать согласие и потребовать удаления данных</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Получить информацию о передаче ваших данных третьим лицам</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Подать жалобу в Национальный центр защиты персональных данных Республики Беларусь</span>
                        </li>
                    </ul>
                    <p class="mt-3">Для реализации прав направьте запрос на: <a href="mailto:support@biometrik.app"
                                                                                class="text-emerald-600 hover:text-emerald-700">support@biometrik.app</a>.
                        Мы ответим в течение 15 дней.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">9. Файлы cookie</h2>
                    <p>Мы используем только технически необходимые cookie для поддержания сессии авторизованного
                        пользователя. Эти файлы не используются в рекламных или аналитических целях и не передаются
                        третьим лицам.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">10. Изменение политики</h2>
                    <p>Мы оставляем за собой право изменять настоящую Политику. При существенных изменениях мы уведомим
                        вас по электронной почте. Продолжение использования сервиса после уведомления означает ваше
                        согласие с обновлённой Политикой.</p>
                </section>

            </div>
        </div>
    </div>
</@layoutMacros.layout>
