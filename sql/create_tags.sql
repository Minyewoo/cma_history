/*
    PROCESS TAG
*/
read -r -d '' sql << EOF
    do \$\$
    begin
    if not exists (SELECT 1 FROM pg_type WHERE typname = 'tag_type_enum') THEN
        create type tag_type_enum as enum('Bool','Int','UInt','DInt','Word','LInt','Real','Time','Date_And_Time');
    end if;
    end
    \$\$;
    create table if not exists tags (
        id 		serial not null,
        type      tag_type_enum not null,                   /* 'S7DataType(bool, int, uInt, dInt, word, lInt, real, time, dateAndTime)' */
        name      varchar(255) not null unique,	            /* 'Имя тэга в системе' */
        description   varchar(255) not null DEFAULT '',     /* 'Дополнительная информация о тэге' */
        PRIMARY KEY (id)
    );
    comment on table tags is 'Справочник тэгов проекта.';
EOF