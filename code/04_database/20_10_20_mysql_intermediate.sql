<<<<<<< HEAD
# 소수점 올림, 반올림, 버림 함수
	# 소수점 올림
	select ceil(12.345)
	# 반올림
	select round(12.346, 2)
	# 버림
	select truncate(12.345, 2)
	
# 예제
select code,round((GNP/population)* 1000, 2) from country

# 조건문 
# IF: IF(조건, 참, 거짓)
	# 도시의 인구가 100만이상 big city, 100만 미만 small city
	# column: city_scale
	select name, population, IF(population >= 1000000, "big city", "small city") as city_scale 
	from city
	
# IFNULL: IFNULL(컬럼, 값), 해당 값에 NULL이 있을때 표출값 지정
	# country 테이블에서 독립년도(Indep year)가 없으면 0으로 출력
	select name, IFNULL(IndepYear, 0) from country
# CASE
		# WHEN (조건1) THEN (출력1)
		# WHEN (조건2) THEN (출력2)
		# ELSE (출력3)
	# END AS (컬럼명)
	# 나라별 10억 이상, 1억 이상, 1억 이하 조건을 출력
	select name, population,
	CASE 
		WHEN population > 1000000000 THEN "upper 1 bilion"	
		WHEN population > 100000000 THEN "upper 100 milion"
		ELSE "below 100 milion"
	END AS result
	from country

# DATE_FORMAT: 날짜 데이터의 포멧을 변경해주는 함수
use sakila
	select * from payment
	# paymont 에서 웗별 매출 출력
	select DATE_FORMAT(payment_date, "%Y-%m") as monthly, count(amount), sum(amount) 
	from payment
	group by monthly
	# 일자별
	select DATE_FORMAT(payment_date, "%d") as monthly, count(amount), sum(amount) 
	from payment
	group by monthly
	# 요일별
	select DATE_FORMAT(payment_date, "%W") as monthly, count(amount), sum(amount) 
	from payment
	group by monthly

# JOIN: merge()
use world
	# 실습을 위한 데이터
	CREATE TABLE user (
		user_id int(11) unsigned NOT NULL AUTO_INCREMENT,
		name varchar(30) DEFAULT NULL,
		PRIMARY KEY (user_id)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE addr (		 
		id int(11) unsigned NOT NULL AUTO_INCREMENT,	 
		addr varchar(30) DEFAULT NULL,
		user_id int(11) DEFAULT NULL,		 
		PRIMARY KEY (id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
	INSERT INTO user(name)
	VALUES ("jin"),
	("po"),
	("alice"),
	("petter");
	INSERT INTO addr(addr, user_id)
	VALUES ("seoul", 1),
	("pusan", 2),
	("deajeon", 3),
	("deagu", 5),
	("seoul", 6); 
	
	# inner join
	select addr.addr, addr.user_id, user.name from addr
	join user on addr.user_id = user.user_id
	
	# world 도시이름, 국가이름을 출력
	select city.countrycode, city.name, country.Name from city 
	join country on city.CountryCode = country.code
	
	# left join
	select * from addr left join user
	on addr.user_id = user.user_id
	
	# right join
	select * from addr right join user
	on addr.user_id = user.user_id
	
	# union: select문의 결과를 합쳐서 출력
		# 컬럼 갯수가 같아야함
		# 자동으로 중복을 제거
	SELECT name
	FROM user UNION
	SELECT addr
	FROM addr
	# 중복데이터 표출 union all	
	SELECT name
	FROM user UNION all
	SELECT addr
	FROM addr
	
	# outer join
	select user.name, addr.addr, addr.user_id from user
	left join addr
	on user.user_id = addr.user_id	
	union
	select user.name, addr.addr, addr.user_id from user
	right join addr
	on user.user_id = addr.user_id	
	
# sub-query: 쿼리문 안에 쿼리가 있는 문법	
	# select, from, where
	# 전체 나라수, 전체 도시수, 전체 언어수를 출력
	select 
		(select count(*) from city) as total_city,
		(select count(*) from country) as total_country,
		(select count(distinct(language)) from countrylanguage) as total_language

	# 800만 이상 되는 도시의 국가 코드, 도시이름, 국가이름, 도시인구수를 출력
	select * from (select countrycode, name, population from city 
		where population >= 8000000) as city
	join (select code, name from country) as country
	on city.countrycode = country.code
	
	# 800만 이상 도시의 국가코드, 국가이름, 대통령이름 출력
	select * from country

	select code, name, HeadOfState from country 
	where code in(
		select distinct(countrycode)
		from city
		where population >= 8000000
	)
# index: 데이터를 검색할때 빠르게 찾을수 있도록 해주는 기능
	# 사용: where절에 자주쓰이는 컬럼을 인덱스로 지정
	# 단점: index가 존재하면, select는 빠르나 insert가 느려짐
		# insert 추가하때마다 index값도 저장및 갱신되기에 그만큼 느려짐
use employees
	# explain: 실행 계획 확인 가능
	explain
	select count(*)
	from salaries
	where to_date > "2000-01-01" # 0.625초 소요
	# 인덱스 추가
	create index tdate
	on salaries (to_date) # 6.250초 소요
	# 결과
		# 인덱스 추가 시 0.218 초 소요
		# 0.625초 -> 0.218초 : 시간 절약
	drop index tdate on salaries

# view: 특정 query문에 대한 결과를 저장하는 개념
use world
	# 뷰 생성
	create view code_name as 
	select code, name from country
	# 뷰 활용
	select * from city
=======
# 소수점 올림, 반올림, 버림 함수
	# 소수점 올림
	select ceil(12.345)
	# 반올림
	select round(12.346, 2)
	# 버림
	select truncate(12.345, 2)
	
# 예제
select code,round((GNP/population)* 1000, 2) from country

# 조건문 
# IF: IF(조건, 참, 거짓)
	# 도시의 인구가 100만이상 big city, 100만 미만 small city
	# column: city_scale
	select name, population, IF(population >= 1000000, "big city", "small city") as city_scale 
	from city
	
# IFNULL: IFNULL(컬럼, 값), 해당 값에 NULL이 있을때 표출값 지정
	# country 테이블에서 독립년도(Indep year)가 없으면 0으로 출력
	select name, IFNULL(IndepYear, 0) from country
# CASE
		# WHEN (조건1) THEN (출력1)
		# WHEN (조건2) THEN (출력2)
		# ELSE (출력3)
	# END AS (컬럼명)
	# 나라별 10억 이상, 1억 이상, 1억 이하 조건을 출력
	select name, population,
	CASE 
		WHEN population > 1000000000 THEN "upper 1 bilion"	
		WHEN population > 100000000 THEN "upper 100 milion"
		ELSE "below 100 milion"
	END AS result
	from country

# DATE_FORMAT: 날짜 데이터의 포멧을 변경해주는 함수
use sakila
	select * from payment
	# paymont 에서 웗별 매출 출력
	select DATE_FORMAT(payment_date, "%Y-%m") as monthly, count(amount), sum(amount) 
	from payment
	group by monthly
	# 일자별
	select DATE_FORMAT(payment_date, "%d") as monthly, count(amount), sum(amount) 
	from payment
	group by monthly
	# 요일별
	select DATE_FORMAT(payment_date, "%W") as monthly, count(amount), sum(amount) 
	from payment
	group by monthly

# JOIN: merge()
use world
	# 실습을 위한 데이터
	CREATE TABLE user (
		user_id int(11) unsigned NOT NULL AUTO_INCREMENT,
		name varchar(30) DEFAULT NULL,
		PRIMARY KEY (user_id)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	CREATE TABLE addr (		 
		id int(11) unsigned NOT NULL AUTO_INCREMENT,	 
		addr varchar(30) DEFAULT NULL,
		user_id int(11) DEFAULT NULL,		 
		PRIMARY KEY (id)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
	INSERT INTO user(name)
	VALUES ("jin"),
	("po"),
	("alice"),
	("petter");
	INSERT INTO addr(addr, user_id)
	VALUES ("seoul", 1),
	("pusan", 2),
	("deajeon", 3),
	("deagu", 5),
	("seoul", 6); 
	
	# inner join
	select addr.addr, addr.user_id, user.name from addr
	join user on addr.user_id = user.user_id
	
	# world 도시이름, 국가이름을 출력
	select city.countrycode, city.name, country.Name from city 
	join country on city.CountryCode = country.code
	
	# left join
	select * from addr left join user
	on addr.user_id = user.user_id
	
	# right join
	select * from addr right join user
	on addr.user_id = user.user_id
	
	# union: select문의 결과를 합쳐서 출력
		# 컬럼 갯수가 같아야함
		# 자동으로 중복을 제거
	SELECT name
	FROM user UNION
	SELECT addr
	FROM addr
	# 중복데이터 표출 union all	
	SELECT name
	FROM user UNION all
	SELECT addr
	FROM addr
	
	# outer join
	select user.name, addr.addr, addr.user_id from user
	left join addr
	on user.user_id = addr.user_id	
	union
	select user.name, addr.addr, addr.user_id from user
	right join addr
	on user.user_id = addr.user_id	
	
# sub-query: 쿼리문 안에 쿼리가 있는 문법	
	# select, from, where
	# 전체 나라수, 전체 도시수, 전체 언어수를 출력
	select 
		(select count(*) from city) as total_city,
		(select count(*) from country) as total_country,
		(select count(distinct(language)) from countrylanguage) as total_language

	# 800만 이상 되는 도시의 국가 코드, 도시이름, 국가이름, 도시인구수를 출력
	select * from (select countrycode, name, population from city 
		where population >= 8000000) as city
	join (select code, name from country) as country
	on city.countrycode = country.code
	
	# 800만 이상 도시의 국가코드, 국가이름, 대통령이름 출력
	select * from country

	select code, name, HeadOfState from country 
	where code in(
		select distinct(countrycode)
		from city
		where population >= 8000000
	)
# index: 데이터를 검색할때 빠르게 찾을수 있도록 해주는 기능
	# 사용: where절에 자주쓰이는 컬럼을 인덱스로 지정
	# 단점: index가 존재하면, select는 빠르나 insert가 느려짐
		# insert 추가하때마다 index값도 저장및 갱신되기에 그만큼 느려짐
use employees
	# explain: 실행 계획 확인 가능
	explain
	select count(*)
	from salaries
	where to_date > "2000-01-01" # 0.625초 소요
	# 인덱스 추가
	create index tdate
	on salaries (to_date) # 6.250초 소요
	# 결과
		# 인덱스 추가 시 0.218 초 소요
		# 0.625초 -> 0.218초 : 시간 절약
	drop index tdate on salaries

# view: 특정 query문에 대한 결과를 저장하는 개념
use world
	# 뷰 생성
	create view code_name as 
	select code, name from country
	# 뷰 활용
	select * from city
>>>>>>> e88d9a714590f3b39acad8ecf440c9006683a944
	join code_name on city.countrycode = code_name.code