DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
#1 question
Select distinct type from netflix;
select type,Count(type) as Type_count
From netflix
Group by type;

#2 QUESTION
SELECT distinct rating from netflix;
Select rating,count(rating) as Rating_count
From netflix
where type='TV Show'
Group by rating
Order by Rating_count desc
Limit 1;

#3 List all movies released in a specific year (e.g., 2020)
SELECT title, date_added 
FROM netflix
WHERE TO_DATE(date_added, 'FMMonth DD, YYYY') 
      BETWEEN '2021-01-01' AND '2021-12-31';

#4 Find the top 5 countries with the most content on Netflix
Select * from netflix;
Select country,count(country) as country_count
from netflix
group by country
order by country_count desc;

#5 Identify the longest movie
Select type,duration
from netflix
where type='Movie' and duration is not null
Order by 
 cast(regexp_replace(duration,'[^0-9]','','g') as integer) desc
limit 1;

#6 Find content added in the last 5 years
Select *
from netflix
WHERE TO_DATE(date_added, 'FMMonth DD, YYYY') 
      >=(current_date-interval'5 years');

#7 Find all the movies/TV shows by director 'Rajiv Chilaka'!
select type,director
from netflix
where director='Rajiv Chilaka';

#8 List all TV shows with more than 5 seasons
SELECT * 
FROM netflix 
WHERE type = 'TV Show' 
AND CAST(REGEXP_REPLACE(duration, '[^0-9]', '', 'g') AS INTEGER) > 5;

#9 Count the number of content items in each genre
Select 
   unnest(string_to_array(listed_in, ',')) as genre_listed,
count(*) as Total_content
from netflix
group by 1;

#10 Find each year and the average numbers of content release in India on netflix
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'FMMonth DD, YYYY')) AS year_added,
    COUNT(*) as Total_content,
	Round(
	COUNT(*)::numeric/(select count(*) from netflix where country='India')::numeric * 100
	,2)as avg_content
FROM netflix
WHERE country = 'India'
GROUP BY year_added
limit 5;

#11 List all movies that are documentaries
select 
     title,
	 listed_in
from netflix
Where listed_in like '%Documentaries';

#12 Find all content without a director
Select *
from netflix
where director is null ;

13 Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

14 Find the top 10 actors who have appeared in the highest number of movies produced in India.  
SELECT UNNEST(STRING_TO_ARRAY(casts, ',')) AS Actor,
count(*) as Number_of_film_appeared
FROM netflix
where country='India'
group by Actor 
Order by Number_of_film_appeared DeSC
limit 10;




   


