<#import "./shared/layout.ftl" as layoutMacros>
<#import "./shared/page-header.ftl" as pageHeaderMacros>

<@layoutMacros.layout title="Пользовательское соглашение" selectedPage="">
    <div class="min-h-screen bg-white">
        <div class="container max-w-2xl mx-auto px-4 pt-8 pb-20">

            <@pageHeaderMacros.pageHeader backUrl="/" title="Пользовательское соглашение" subtitle="Последнее обновление: 19 апреля 2025 г." />

            <div class="mt-8 space-y-8 text-sm text-gray-700 leading-relaxed">

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">1. Предмет соглашения</h2>
                    <p>Настоящее Пользовательское соглашение (далее — Соглашение) регулирует условия использования сервиса Биометрик (далее — Сервис), предназначенного для самостоятельного отслеживания результатов медицинских анализов и построения графиков динамики показателей.</p>
                    <p class="mt-2">Регистрируясь в Сервисе, вы принимаете условия настоящего Соглашения в полном объёме. Если вы не согласны с какими-либо условиями, пожалуйста, воздержитесь от использования Сервиса.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">2. Регистрация и учётная запись</h2>
                    <ul class="space-y-2">
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Для использования Сервиса необходима регистрация с указанием действующего адреса электронной почты или через Google-аккаунт.</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Вы несёте ответственность за сохранность учётных данных и за все действия, совершённые под вашей учётной записью.</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>При регистрации вы должны быть не моложе 18 лет либо действовать с согласия законного представителя.</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-emerald-500 shrink-0"></span>
                            <span>Передача учётной записи третьим лицам запрещена.</span>
                        </li>
                    </ul>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">3. Назначение сервиса и ограничение ответственности</h2>
                    <div class="border border-amber-200 bg-amber-50 rounded-xl px-4 py-3 mb-3">
                        <p class="font-medium text-amber-800 mb-1">Важное предупреждение</p>
                        <p class="text-amber-700">Биометрик является информационным инструментом для личного учёта данных. Сервис <strong>не является медицинским устройством</strong>, не предоставляет медицинских консультаций и не заменяет обращение к врачу. Любые решения, касающиеся здоровья, принимайте только совместно с квалифицированным медицинским специалистом.</p>
                    </div>
                    <p>Сервис предназначен исключительно для визуализации данных, которые вы вносите самостоятельно. Мы не несём ответственности за точность введённых вами данных и за решения, принятые на основе отображаемой информации.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">4. Правила использования</h2>
                    <p>При использовании Сервиса запрещается:</p>
                    <ul class="mt-2 space-y-2">
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>
                            <span>Вносить заведомо ложные данные с целью введения в заблуждение</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>
                            <span>Предпринимать попытки несанкционированного доступа к данным других пользователей</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>
                            <span>Использовать автоматизированные инструменты для массового сбора данных (парсинг)</span>
                        </li>
                        <li class="flex gap-2">
                            <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-gray-400 shrink-0"></span>
                            <span>Нарушать работоспособность Сервиса любым способом</span>
                        </li>
                    </ul>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">5. Данные пользователя</h2>
                    <p>Все данные, которые вы вносите в Сервис, принадлежат вам. Мы не анализируем ваши медицинские данные в коммерческих целях и не передаём их третьим лицам, за исключением случаев, описанных в <a href="/privacy-policy" class="text-emerald-600 hover:text-emerald-700">Политике конфиденциальности</a>.</p>
                    <p class="mt-2">Вы можете запросить удаление всех ваших данных в любой момент, обратившись по адресу <a href="mailto:support@biometrik.app" class="text-emerald-600 hover:text-emerald-700">support@biometrik.app</a>.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">6. Доступность сервиса</h2>
                    <p>Мы стремимся обеспечить бесперебойную работу Сервиса, однако не гарантируем его круглосуточную доступность. Мы оставляем за собой право проводить технические работы с предварительным уведомлением пользователей, а также изменять или прекращать предоставление Сервиса.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">7. Интеллектуальная собственность</h2>
                    <p>Все элементы Сервиса — дизайн, код, логотипы, тексты — являются интеллектуальной собственностью владельца Сервиса и защищены законодательством. Копирование и воспроизведение без письменного разрешения запрещено.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">8. Расторжение соглашения</h2>
                    <p>Вы можете прекратить использование Сервиса и удалить свою учётную запись в любой момент. Мы вправе приостановить или заблокировать доступ к Сервису при нарушении условий настоящего Соглашения.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">9. Применимое право</h2>
                    <p>Настоящее Соглашение регулируется законодательством Республики Беларусь. Все споры разрешаются в порядке, предусмотренном действующим законодательством.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">10. Изменение соглашения</h2>
                    <p>Мы оставляем за собой право изменять условия Соглашения. Актуальная версия всегда доступна на этой странице. При существенных изменениях мы уведомим вас по электронной почте не менее чем за 7 дней до вступления изменений в силу.</p>
                </section>

                <section>
                    <h2 class="text-base font-semibold text-gray-800 mb-3">11. Контакты</h2>
                    <p>По вопросам, связанным с Соглашением, обращайтесь: <a href="mailto:support@biometrik.app" class="text-emerald-600 hover:text-emerald-700">support@biometrik.app</a></p>
                </section>

            </div>
        </div>
    </div>
</@layoutMacros.layout>
