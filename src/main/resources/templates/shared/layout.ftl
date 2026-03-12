<#macro layout title="" showNavbar=true bodyClass="" selectedPage="-1">
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Основные мета-теги -->
        <title><#if title?has_content>${title}<#else>Биометрик</#if></title>
        <meta name="description" content="Биометрик — платформа для персонального мониторинга показателей здоровья. Отслеживайте важные метрики: давление, пульс, инсулин, калий, уровень глюкозы и другие.">
        <meta name="keywords" content="здоровье, мониторинг, показатели, глюкоза, инсулин, калий, трекер здоровья, Биометрик">
        <meta name="author" content="Биометрик">
        <meta name="theme-color" content="#10b981">

        <!-- Для мобильных веб-приложений -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="default">
        <meta name="format-detection" content="telephone=no">

        <!-- Иконки и манифест -->
        <link rel="icon" type="image/png" href="/favicon-96x96.png" sizes="96x96" />
        <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
        <meta name="apple-mobile-web-app-title" content="Биометрик" />
        <link rel="manifest" href="/site.webmanifest" />

        <!-- Стили -->
        <link href="/css/style.css" rel="stylesheet">
    </head>
    <body class="${bodyClass}">
    <main class="<#if showNavbar>md:pt-16</#if>">
        <#nested>
        <#if showNavbar>
            <#import "./navbar.ftl" as navbar>
            <@navbar.navbar selectedPage=selectedPage/>
        </#if>
    </main>
    </body>
    </html>
</#macro>