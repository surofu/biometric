-- 1. справочник категорий
create table indicator_categories
(
    id          bigint generated always as identity,
    name        varchar(50) not null,
    description text        not null,

    constraint pk_indicator_categories primary key (id),
    constraint uq_indicator_categories_name unique (name)
);

-- 2. справочник профессий
create table professions
(
    id          bigint generated always as identity,
    name        varchar(100) not null,
    description text         not null,

    constraint pk_professions primary key (id),
    constraint uq_professions_name unique (name)
);

-- 3. справочник врачей
create table doctors
(
    id          bigint generated always as identity,
    name        varchar(100) not null,
    description text         not null,

    constraint pk_doctors primary key (id),
    constraint uq_doctors_name unique (name)
);

-- 4. таблица пользователей
create table users
(
    id             bigint generated always as identity,
    email          varchar(255) not null,
    password_hash  varchar(255) not null,
    email_verified boolean      not null default false,
    role           smallint     not null,
    registered_at  timestamptz  not null default current_timestamp,
    updated_at     timestamptz  not null default current_timestamp,
    agreement      boolean               default false,
    agreement_at   timestamptz  not null default now(),

    constraint pk_users primary key (id),
    constraint uq_users_email unique (email)
);

-- 5. индикаторы (анализы/показатели)
create table indicators
(
    id            bigint generated always as identity,
    name          varchar(100)   not null,
    reference_min numeric(10, 2) not null,
    reference_max numeric(10, 2) not null,
    unit          varchar(20)    not null,
    category_id   bigint         not null,
    description   text           not null,

    constraint pk_indicators primary key (id),
    constraint uq_indicators_name unique (name),
    constraint fk_indicators_category foreign key (category_id)
        references indicator_categories (id) on delete restrict
);

-- 6. замеры (основная таблица данных)
create table measurements
(
    id           bigint generated always as identity,
    user_id      bigint         not null,
    indicator_id bigint         not null,
    value        numeric(10, 2) not null,
    created_at   timestamptz    not null default now(),
    date         date           not null default current_date,

    constraint pk_measurements primary key (id),
    constraint fk_measurements_user foreign key (user_id)
        references users (id) on update cascade on delete cascade,
    constraint fk_measurements_indicator foreign key (indicator_id)
        references indicators (id) on update cascade on delete restrict
);

-- индексы для оптимизации выборок и графиков
create index idx_measurements_user_indicator_date on measurements (user_id, indicator_id, date desc);
create index idx_measurements_date on measurements (date);

-- 7. токены верификации
create table email_verification_tokens
(
    id         bigint generated always as identity,
    user_id    bigint       not null,
    token      varchar(255) not null,
    expires_at timestamptz  not null,
    used       boolean      not null default false,

    constraint pk_email_verification_tokens primary key (id),
    constraint uq_email_verification_tokens_token unique (token),
    constraint fk_email_verification_tokens_user foreign key (user_id)
        references users (id) on update cascade on delete cascade
);

-- 8. связь профессии - врачи (many-to-many)
create table professions_doctors
(
    id            bigint generated always as identity,
    profession_id bigint not null,
    doctor_id     bigint not null,

    constraint pk_professions_doctors primary key (id),
    constraint fk_prof_doc_profession foreign key (profession_id) references professions (id) on delete cascade,
    constraint fk_prof_doc_doctor foreign key (doctor_id) references doctors (id) on delete cascade,
    constraint uq_prof_doc_pair unique (profession_id, doctor_id)
);

-- 9. spring session (стандартные таблицы)
create table spring_session
(
    primary_id            char(36) not null,
    session_id            char(36) not null,
    creation_time         bigint   not null,
    last_access_time      bigint   not null,
    max_inactive_interval integer  not null,
    expiry_time           bigint   not null,
    principal_name        varchar(100),

    constraint pk_spring_session primary key (primary_id)
);

create unique index idx_session_id on spring_session (session_id);
create index idx_session_expiry on spring_session (expiry_time);
create index idx_session_principal on spring_session (principal_name);

create table spring_session_attributes
(
    session_primary_id char(36)     not null,
    attribute_name     varchar(200) not null,
    attribute_bytes    bytea        not null,

    constraint pk_spring_session_attributes primary key (session_primary_id, attribute_name),
    constraint fk_session_attributes_session foreign key (session_primary_id)
        references spring_session (primary_id) on delete cascade
);