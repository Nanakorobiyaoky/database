drop table if exists spectators;
drop table if exists starring;
drop table if exists roles_duplicated;
drop table if exists films;
drop table if exists genres;
drop table if exists person;
drop table if exists film_person;

create table genres
(
	id serial primary key,
	genre varchar unique not null
);

create table person
(
	id serial primary key,
	"name" varchar not null
);

create table film_person
(
	id serial primary key,
	"name" varchar not null
);

CREATE TABLE films
(
	id serial PRIMARY KEY,
	"name" varchar not null,
	"year" integer not null check (year >= 1888),
	country varchar not null,
	tagline varchar,
	genre_id integer
	    references genres (id)
	    on delete set null
        on update cascade,
	director_id integer
	    references person (id)
	    on delete set null
	    on update cascade,
	screenwriter_id integer
	    references person (id)
	    on delete set null
	    on update cascade,
	producer_id integer
	    references person (id)
	    on delete set null
	    on update cascade,
	operator_id integer
	    references person (id)
	    on delete set null
	    on update cascade,
	composer_id integer
	    references person (id)
	    on delete set null
	    on update cascade,
	artist_id integer
	    references person (id)
	    on delete set null
	    on update cascade,
	editor_id integer
	    references person (id)
        on delete set null
        on update cascade,
    budget integer default 0 check ( budget >= 0 ),
    marketing integer default 0 check ( marketing >= 0 ),
    US_fees integer default 0 check ( US_fees >= 0 ),
    world_fees integer default 0 check ( world_fees >= 0 ),
    ru_premiere date,
    world_premiere date,
    dvd_release date,
    age integer default 0 check ( age >= 0 ),
    MPAA_rating varchar,
    "time" integer
);

create table starring
(
	film_id integer not null check (film_id > 0)
	    references films (id)
        on delete cascade
        on update cascade,
	film_person_id integer not null check (film_id > 0)
        references film_person (id)
        on delete cascade
        on update cascade,
    primary key (film_id, film_person_id)

);

create table roles_duplicated
(
	film_id integer not null check (film_id > 0)
	    references films (id)
        on delete cascade
        on update cascade,
	film_person_id integer not null check (film_id > 0)
        references film_person (id)
        on delete cascade
        on update cascade,
    primary key (film_id, film_person_id)
);

create table spectators
(
    film_id integer not null check (film_id > 0)
        references films (id)
        on delete cascade
        on update cascade,
    US integer default 0 check (US >= 0),
    RU integer default 0 check (RU >= 0),
    DE integer default 0 check (DE >= 0),
    GB integer default 0 check (GB >= 0),
    IT integer default 0 check (IT >= 0)
);

create index film_name on films (name);
create index film_year on films (year);







