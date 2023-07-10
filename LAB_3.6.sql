USE SAKILA;
-- 1 List each pair of actors that have worked together.
select * from actor; -- actor_id, first_name, last_name


select a.actor_id AS Actor_IDA, b.actor_id AS Actor_IDB
from film_actor a
join film_actor b ON a.film_id = b.film_id
where a.actor_id <> b.actor_id;

-- 2 For each film, list actor that has acted in more films.
select * from film_actor; -- actor_id, film_id

SELECT film_actor.film_id, film_actor.actor_id, sub.actuaciones,
       DENSE_RANK() OVER (PARTITION BY film_actor.film_id ORDER BY sub.actuaciones DESC) AS actor_rank
FROM film_actor
JOIN (
    SELECT actor_id, count(film_id) AS actuaciones
    FROM film_actor
    GROUP BY actor_id
) sub ON film_actor.actor_id = sub.actor_id
ORDER BY film_actor.film_id;

	