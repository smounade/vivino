-- 1. We want to highlight 10 wines to increase our sales. Which ones should we choose and why?
-- We will choose the 10 wines with the highest average ratings, as this is a strong indicator of quality and customer satisfaction. By showcasing these top-rated wines, we can attract more customers and boost sales.

SELECT name FROM wines ORDER BY ratings_average DESC LIMIT 10;

--2. We have a marketing budget for this year. Which country should we prioritise and why?
-- We should prioritize marketing efforts in the country that has the highest number of wine reviews, as this indicates a strong interest and engagement with our products. By focusing on this market, we can maximize the impact of our marketing budget.

SELECT countries.name AS country, SUM(ratings_count) AS total_ratings_count
FROM wines JOIN regions ON wines.region_id = regions.id
JOIN countries ON regions.country_code = countries.code
GROUP BY country
ORDER BY total_ratings_count DESC
LIMIT 5;

--3.We would like to give awards to the best wineries. Come up with 3 relevant ones. Which wineries should we choose and why? Be creative ;)

SELECT wineries.name AS winery, AVG(wines.ratings_average) AS avg_rating
FROM wineries JOIN wines ON wineries.id = wines.winery_id
GROUP BY winery
ORDER BY avg_rating DESC
LIMIT 3;

--4. We have detected that a big cluster of customers like a specific combination of tastes. We have identified a few primary keywords that match this. We would like you to find all the wines that have those keywords. To ensure the accuracy of our selection, ensure that more than 10 users confirmed those keywords. Also, identify the group_name related to those keywords.

SELECT wines.id, wines.name AS wine_name, SUM(keywords_wine.count) AS total_confirmations
FROM wines
JOIN keywords_wine ON wines.id = keywords_wine.wine_id
JOIN keywords ON keywords_wine.keyword_id = keywords.id
WHERE keywords.name IN ('coffee', 'toast', 'green apple', 'cream', 'citrus')
GROUP BY wines.id
HAVING COUNT(DISTINCT keywords.name) = 5
   AND SUM(keywords_wine.count) >= 10;

--5. We would like to select wines that are easy to find all over the world. Find the top 3 most common grape all over the world and for each grape, give us the the 5 best rated wines.


--6. We would to give create a country leaderboard, give us a visual that shows the average wine rating for each country. Do the same for the vintages.

SELECT countries.name AS country, AVG(wines.ratings_average) AS avg_rating
FROM wines JOIN regions ON wines.region_id = regions.id
JOIN countries ON regions.country_code = countries.code
GROUP BY country
ORDER BY avg_rating DESC
LIMIT 10;
