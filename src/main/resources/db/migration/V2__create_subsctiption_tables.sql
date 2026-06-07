create table subscription_plans
(
    id              bigint generated always as identity,
    name            varchar(50)    not null,
    description     text           not null,
    price           numeric(10, 2) not null,
    currency        varchar(50)    not null,
    duration_months int            not null,
    is_active       boolean        not null default true,
    created_at      timestamptz    not null default now(),
    updated_at      timestamptz    not null default now(),

    constraint pk_subscription_plans primary key (id),
    constraint uq_subscription_plans_name unique (name)
);

create table user_payment_methods
(
    id            bigint generated always as identity,
    user_id       bigint       not null,
    provider      varchar(50)  not null,
    gateway_token varchar(255) not null,
    card_last4    char(4),
    card_type     varchar(20),
    expiry_date   varchar(7),
    is_default    boolean      not null default false,
    is_active     boolean      not null default true,
    created_at    timestamptz  not null default now(),

    constraint pk_user_payment_methods primary key (id),
    constraint fk_payment_methods_user_id foreign key (user_id) references users (id)
        on update cascade
        on delete cascade
);

create table user_subscriptions
(
    id                bigint generated always as identity,
    user_id           bigint         not null,
    plan_id           bigint         not null,
    payment_method_id bigint         not null,
    status            smallint       not null,
    price_at_purchase numeric(10, 2) not null,
    currency          varchar(50)    not null,
    start_date        timestamptz    not null,
    end_date          timestamptz    not null,
    renew             boolean        not null default true,
    created_at        timestamptz    not null default now(),

    constraint pk_user_subscriptions primary key (id),
    constraint fk_user_subscriptions_user_id foreign key (user_id) references users (id)
        on update cascade
        on delete cascade,
    constraint fk_user_subscriptions_plan_id foreign key (plan_id) references subscription_plans (id)
        on update cascade
        on delete restrict
);

create table billing_history
(
    id                bigint generated always as identity,
    user_id           bigint         not null,
    subscription_id   bigint         not null,
    payment_method_id bigint         not null,
    amount            numeric(10, 2) not null,
    currency          varchar(50)    not null,
    status            smallint       not null,
    gateway_tx_id     varchar(255),
    failure_reason    text,
    created_at        timestamptz    not null default now(),

    constraint pk_billing_history primary key (id),
    constraint fk_billing_history_user_id foreign key (user_id) references users (id)
        on update cascade
        on delete cascade,
    constraint fk_billing_history_subscription_id foreign key (subscription_id) references user_subscriptions (id)
        on update cascade
        on delete restrict,
    constraint fk_billing_history_payment_method_id foreign key (payment_method_id) references user_payment_methods (id)
        on update cascade
        on delete restrict
);