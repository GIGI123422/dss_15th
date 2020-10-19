# Quiz1/ Country 테이블에서 중복을 제거한 Continent를 조회하세요.
select distinct(Continent) from country

# Quiz2/ 한국 도시중에 인구가 100만이 넘는 도시를 조회하여 인구순으로 내림차순 하세요.
select distinct(CountryCode)  from city

select Name, Population from city
where Population > 1000000 and CountryCode = "KOR"
order by Population DESC

# Quiz3/ city 테이블에서 Populaion이 800aks ~ 1000만 사이인 도시 데이터를 인구수순으로 내림차순 하세요.
select * from city

select Name, CountryCode, Population from city
where Population BETWEEN 8000000 and 20000000
order by Population DESC

# Quiz4/ country 테이블에서 1940 ~ 1950년도 사이에 독립한 국가들을 조회하고 
# 독립한 년도 순으로 오름차순 하세요.
select * from country

select Code, Concat(Name, "(", IndepYear, ")") as Independent, Continent, Population from country
where IndepYear BETWEEN 1940 and 1950
order by IndepYear , Population

# Quiz5/ contrylanguage 테이블에서 스페인어, 한국어, 영어를 95% 이상 사용하는 
# 국가 코드를 Percentage로 내림차순하여 아래와 같이 조회하세요. 

# Language 조건, Percentage 조건
select * from countrylanguage

select CountryCode, Language, Percentage from countrylanguage
where Language IN ("Korean", "Spanish", "English") and Percentage > 95
order by Percentage desc

# Quiz6/ country 테이블에서 Code가 A로 시작하고 GovernmentForm에 
# Republic이 포함되는 데이터를 아래와 같이 조회 하세요.

# 데이터의 부분 검색 >> like
select * from country

select Code, Name, Continent, GovernmentForm, Population from country
where Code like "A%" and GovernmentForm like "%Republic%"



