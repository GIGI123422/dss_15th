
# Quiz 03 join & sub-query
# Quiz 1/ 멕시코보다 인구가 많은 나라 이름과 인구수를 조회하시고 
# 인구수 순으로 내림차순 하세요
select * from country
	# 멕시코 보다 인구가 많은 나라 이름 -> where 절에 sub-query
select name, population from country
where population > (select population from country where name = "Mexico")
order by population desc

# Quiz 2/ 국가별 몇개의 도시가 있는지 조회하고 
# 도시수 순으로 10위까지 내림차순 하세요.
select * from country;
select * from city;
	# 국가별 -> country, 몇개의 도시 -> 국가 코드로 join,  
select country.name, count(city.Name) as cnt_city from country
join city on country.Code = city.countrycode
group by country.name
order by cnt_city desc
limit 10

# Quiz 3/ 언어별 사용인구를 출력하고 
# 언어 사용인구 순으로 10위까지 내림차순하세요.
select * from countrylanguage;
select * from country;
	# 언어별 사용인구 -> country 별 인구 * 그 나라의 언어 사용율 곱하여 반환, 이후 조건대로 정렬
select language, sum(round(percentage * population*0.01)) as count from country as co
join countrylanguage as cl on cl.countrycode = co.Code
group by language
order by count desc
limit 10

# Quiz 4/ 나라 전체 인구의 10% 이상인 도시에서 
# 도시 인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.
SELECT * FROM city;
SELECT * FROM country;
	# 나라 전체 인구의 10% -> 나라 인구 비율과 도시 인구 계산한 테이블 생성
select ci.Name, ci.CountryCode, co.name, (ci.Population/co.population)*100 as percentage from country as co
join city as ci on ci.CountryCode = co.Code
where ci.population >= 5000000 
order by percentage desc

# Quiz 5/ 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 
# 인구밀도가 200이상인 국가들의 사용하고 있는 언어수가 5가지 이상인 나라를 조회하세요.
select * from country
select * from countrylanguage
	# country DB의 국가별 인구/면적 구하고, countrylanguage join 하여 laguage 카운트해서 표출
select density.name, count(cl.Language) as language_count from countrylanguage as cl
join (
	select code, name, (population/surfacearea) as density from country 
	where surfacearea >= 10000
	having density >= 200
	order by density desc
) as density
on density.code = cl.countrycode
group by name
having language_count >= 5
order by language_count desc

# Quiz 6/ 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
# * GROUP_CONCAT(LANGUAGE)을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다.
# * VIEW를 이용해서 query를 깔끔하게 수정하세요.
select * from city as ci
select * from country as co
select * from countrylanguage as cl
	# 1. 사용하는 언어가 3가지 이하인 국가중
		select co.name, count(cl.language) as language_count from country as co
		join countrylanguage as cl
		on co.code = cl.countrycode
		group by co.name
		having language_count <= 3
		order by language_count desc
	# 2. 도시인구가 300만 이상인 도시
select ci.countrycode, ci.name, ci.Population, col.name, 
	col.language_count, col.languages 
from (
	SELECT co.code, co.name, 
		group_concat(language) as languages, 
		COUNT(cl.language) AS language_count
	FROM country AS co
	JOIN countrylanguage AS cl ON co.code = cl.countrycode
	GROUP BY co.name, co.code
	HAVING language_count <= 3
	ORDER BY language_count DESC
) as col
join city as ci
on col.Code = ci.CountryCode
having ci.Population > 3000000
order by population desc

=======
# Quiz 03 join & sub-query
# Quiz 1/ 멕시코보다 인구가 많은 나라 이름과 인구수를 조회하시고 
# 인구수 순으로 내림차순 하세요
select * from country
	# 멕시코 보다 인구가 많은 나라 이름 -> where 절에 sub-query
select name, population from country
where population > (select population from country where name = "Mexico")
order by population desc

# Quiz 2/ 국가별 몇개의 도시가 있는지 조회하고 
# 도시수 순으로 10위까지 내림차순 하세요.
select * from country;
select * from city;
	# 국가별 -> country, 몇개의 도시 -> 국가 코드로 join,  
select country.name, count(city.Name) as cnt_city from country
join city on country.Code = city.countrycode
group by country.name
order by cnt_city desc
limit 10

# Quiz 3/ 언어별 사용인구를 출력하고 
# 언어 사용인구 순으로 10위까지 내림차순하세요.
select * from countrylanguage;
select * from country;
	# 언어별 사용인구 -> country 별 인구 * 그 나라의 언어 사용율 곱하여 반환, 이후 조건대로 정렬
select language, sum(round(percentage * population*0.01)) as count from country as co
join countrylanguage as cl on cl.countrycode = co.Code
group by language
order by count desc
limit 10

# Quiz 4/ 나라 전체 인구의 10% 이상인 도시에서 
# 도시 인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.
SELECT * FROM city;
SELECT * FROM country;
	# 나라 전체 인구의 10% -> 나라 인구 비율과 도시 인구 계산한 테이블 생성
select ci.Name, ci.CountryCode, co.name, (ci.Population/co.population)*100 as percentage from country as co
join city as ci on ci.CountryCode = co.Code
where ci.population >= 5000000 
order by percentage desc

# Quiz 5/ 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 
# 인구밀도가 200이상인 국가들의 사용하고 있는 언어수가 5가지 이상인 나라를 조회하세요.
select * from country
select * from countrylanguage
	# country DB의 국가별 인구/면적 구하고, countrylanguage join 하여 laguage 카운트해서 표출
select density.name, count(cl.Language) as language_count from countrylanguage as cl
join (
	select code, name, (population/surfacearea) as density from country 
	where surfacearea >= 10000
	having density >= 200
	order by density desc
) as density
on density.code = cl.countrycode
group by name
having language_count >= 5
order by language_count desc

# Quiz 6/ 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
# * GROUP_CONCAT(LANGUAGE)을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다.
# * VIEW를 이용해서 query를 깔끔하게 수정하세요.
select * from city as ci
select * from country as co
select * from countrylanguage as cl
	# 1. 사용하는 언어가 3가지 이하인 국가중
		select co.name, count(cl.language) as language_count from country as co
		join countrylanguage as cl
		on co.code = cl.countrycode
		group by co.name
		having language_count <= 3
		order by language_count desc
	# 2. 도시인구가 300만 이상인 도시
select ci.countrycode, ci.name, ci.Population, col.name, 
	col.language_count, col.languages 
from (
	SELECT co.code, co.name, 
		group_concat(language) as languages, 
		COUNT(cl.language) AS language_count
	FROM country AS co
	JOIN countrylanguage AS cl ON co.code = cl.countrycode
	GROUP BY co.name, co.code
	HAVING language_count <= 3
	ORDER BY language_count DESC
) as col
join city as ci
on col.Code = ci.CountryCode
having ci.Population > 3000000
order by population desc

>>>>>>> e88d9a714590f3b39acad8ecf440c9006683a944
=======
# Quiz 03 join & sub-query
# Quiz 1/ 멕시코보다 인구가 많은 나라 이름과 인구수를 조회하시고 
# 인구수 순으로 내림차순 하세요
select * from country
	# 멕시코 보다 인구가 많은 나라 이름 -> where 절에 sub-query
select name, population from country
where population > (select population from country where name = "Mexico")
order by population desc

# Quiz 2/ 국가별 몇개의 도시가 있는지 조회하고 
# 도시수 순으로 10위까지 내림차순 하세요.
select * from country;
select * from city;
	# 국가별 -> country, 몇개의 도시 -> 국가 코드로 join,  
select country.name, count(city.Name) as cnt_city from country
join city on country.Code = city.countrycode
group by country.name
order by cnt_city desc
limit 10

# Quiz 3/ 언어별 사용인구를 출력하고 
# 언어 사용인구 순으로 10위까지 내림차순하세요.
select * from countrylanguage;
select * from country;
	# 언어별 사용인구 -> country 별 인구 * 그 나라의 언어 사용율 곱하여 반환, 이후 조건대로 정렬
select language, sum(round(percentage * population*0.01)) as count from country as co
join countrylanguage as cl on cl.countrycode = co.Code
group by language
order by count desc
limit 10

# Quiz 4/ 나라 전체 인구의 10% 이상인 도시에서 
# 도시 인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.
SELECT * FROM city;
SELECT * FROM country;
	# 나라 전체 인구의 10% -> 나라 인구 비율과 도시 인구 계산한 테이블 생성
select ci.Name, ci.CountryCode, co.name, (ci.Population/co.population)*100 as percentage from country as co
join city as ci on ci.CountryCode = co.Code
where ci.population >= 5000000 
order by percentage desc

# Quiz 5/ 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 
# 인구밀도가 200이상인 국가들의 사용하고 있는 언어수가 5가지 이상인 나라를 조회하세요.
select * from country
select * from countrylanguage
	# country DB의 국가별 인구/면적 구하고, countrylanguage join 하여 laguage 카운트해서 표출
select density.name, count(cl.Language) as language_count from countrylanguage as cl
join (
	select code, name, (population/surfacearea) as density from country 
	where surfacearea >= 10000
	having density >= 200
	order by density desc
) as density
on density.code = cl.countrycode
group by name
having language_count >= 5
order by language_count desc

# Quiz 6/ 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
# * GROUP_CONCAT(LANGUAGE)을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다.
# * VIEW를 이용해서 query를 깔끔하게 수정하세요.
select * from city as ci
select * from country as co
select * from countrylanguage as cl
	# 1. 사용하는 언어가 3가지 이하인 국가중
		select co.name, count(cl.language) as language_count from country as co
		join countrylanguage as cl
		on co.code = cl.countrycode
		group by co.name
		having language_count <= 3
		order by language_count desc
	# 2. 도시인구가 300만 이상인 도시
select ci.countrycode, ci.name, ci.Population, col.name, 
	col.language_count, col.languages 
from (
	SELECT co.code, co.name, 
		group_concat(language) as languages, 
		COUNT(cl.language) AS language_count
	FROM country AS co
	JOIN countrylanguage AS cl ON co.code = cl.countrycode
	GROUP BY co.name, co.code
	HAVING language_count <= 3
	ORDER BY language_count DESC
) as col
join city as ci
on col.Code = ci.CountryCode
having ci.Population > 3000000
order by population desc

