<<<<<<< HEAD
# Quiz 1/ country 테이블에서 몇 개의 대륙이 있는지 조회하세요.
# 몇개의 대륙 -> 중복 제거, 수량 조사 -> 카운트
select * from country

select count(distinct(continent)) as count from country

# Quiz 2/ country 테이블에서 continent별 몇개의 나라가 있는지 조회하세요
# continent 별 -> group by, 몇개의 나라 -> count
select * from country

select continent, count(name) from country
group by continent

# Quiz 3/ city 테이블에서 국가 코드별로 총 인구가 몇명인지 조회하고 총 인구 순으로 내림차순 하세요.
# (총인구 5천만 이상인 도시만 출력)
# 국가 코드별 -> group by, 총 인구 -> sum, 내림차순 -> order by
select * from city

select countrycode, sum(population) as popu from city
group by countrycode
having popu > 50000000
order by popu desc

# Quiz 4/ countrylanguage 테이블에서 언어별 사용하는 국가수를 조회하고 많이 사용하는 언어를 
# 5위에서 10위까지 조회하세요.
# 언어별 -> group by, 사용하는 국가수 -> count, 많이 사용하는 언어 -> order by 내림차순, 5위 ~10위 -> limit
select * from countrylanguage

select countrycode, count(language) as cntLang from countrylanguage
group by countrycode
order by cntLang desc
limit 4,6

# Quiz 5/ countrylanguage 테이블에서 언어별 15개 국가 이상에서 사용되는 언어를 조회하고 
# 언어별 국가수에 따라 내림차순 하세요.
# 언어별 15개 국가 이상에서 -> group by, having, 국가수 내림차순 -> order by DESC
select * from countrylanguage

select language, count(countrycode) as cntCC from countrylanguage
group by language
having cntCC >= 15
order by cntCC DESC

# Quiz 6/ country 테이블에서 대륙별 전체 표면적크기를 구하고 표면적 크기 순으로 내림차순 하세요.
# 대륙별 -> group by, 전체 표면적 크기 -> sum, 크기순 내림차순 -> order by desc
select * from country

select continent, sum(surfacearea) as surfacearea from country
group by continent
order by surfacearea desc
=======
# Quiz 1/ country 테이블에서 몇 개의 대륙이 있는지 조회하세요.
# 몇개의 대륙 -> 중복 제거, 수량 조사 -> 카운트
select * from country

select count(distinct(continent)) as count from country

# Quiz 2/ country 테이블에서 continent별 몇개의 나라가 있는지 조회하세요
# continent 별 -> group by, 몇개의 나라 -> count
select * from country

select continent, count(name) from country
group by continent

# Quiz 3/ city 테이블에서 국가 코드별로 총 인구가 몇명인지 조회하고 총 인구 순으로 내림차순 하세요.
# (총인구 5천만 이상인 도시만 출력)
# 국가 코드별 -> group by, 총 인구 -> sum, 내림차순 -> order by
select * from city

select countrycode, sum(population) as popu from city
group by countrycode
having popu > 50000000
order by popu desc

# Quiz 4/ countrylanguage 테이블에서 언어별 사용하는 국가수를 조회하고 많이 사용하는 언어를 
# 5위에서 10위까지 조회하세요.
# 언어별 -> group by, 사용하는 국가수 -> count, 많이 사용하는 언어 -> order by 내림차순, 5위 ~10위 -> limit
select * from countrylanguage

select countrycode, count(language) as cntLang from countrylanguage
group by countrycode
order by cntLang desc
limit 4,6

# Quiz 5/ countrylanguage 테이블에서 언어별 15개 국가 이상에서 사용되는 언어를 조회하고 
# 언어별 국가수에 따라 내림차순 하세요.
# 언어별 15개 국가 이상에서 -> group by, having, 국가수 내림차순 -> order by DESC
select * from countrylanguage

select language, count(countrycode) as cntCC from countrylanguage
group by language
having cntCC >= 15
order by cntCC DESC

# Quiz 6/ country 테이블에서 대륙별 전체 표면적크기를 구하고 표면적 크기 순으로 내림차순 하세요.
# 대륙별 -> group by, 전체 표면적 크기 -> sum, 크기순 내림차순 -> order by desc
select * from country

select continent, sum(surfacearea) as surfacearea from country
group by continent
order by surfacearea desc
>>>>>>> e88d9a714590f3b39acad8ecf440c9006683a944
