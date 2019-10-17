-- Did you know you can make multiple CTEs? Here's the syntax
WITH <name> AS (Query)
, <name> AS (Query)
, <name> AS (Query)
SELECT ....


-- Get all actors that have been in the same films as the most popular actor
-- OPTION: Try to get it all in one go, or do this in steps (see HINTS on the repo)

WITH most_popular_actor AS (
    SELECT actor_id, COUNT(film_id) AS film_count
    FROM film_actor
    GROUP BY actor_id
    ORDER BY film_count DESC
    LIMIT 1
),

films_with_most_poopular_actor AS (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = (SELECT actor_id FROM most_popular_actor)
    ORDER BY film_id
)

SELECT DISTINCT a.actor_id AS actor_id, a.first_name AS first_name, a.last_name AS last_name
FROM film_actor INNER JOIN actor a USING(actor_id)
WHERE actor_id != (SELECT actor_id FROM most_popular_actor) AND film_id IN (SELECT film_id FROM films_with_most_poopular_actor)
ORDER BY actor_id;
