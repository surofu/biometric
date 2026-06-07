alter table indicators
    add column user_id bigint,
    add constraint fk_indicators_user_id foreign key (user_id) references users (id)
        on update cascade
        on delete cascade;