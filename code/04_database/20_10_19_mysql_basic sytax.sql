# Create, Alter, Drop, Insert, Select

# 1. Create
	## 1-1 Database
	# 데이터 베이스 생성 - 명칭: test
	create database test;
	# 데이터 베이스 선택 - test 선택
	use test;
	# 현재 데이터 베이스 확인
	select database();
	## 1-2 Table
	# 제약조건이 없는 user1 테이블 생성
	create table user1( 
		user_id INT, 
		name Varchar(20), 
		email Varchar(30), 
		age INT(3), 
		rdate DATE 
	)
	# 제약조건이 있는 user2테이블  생성
		# PRIMARY KEY : 테이블내에 유일한 값, Null을 가질수 없음
		# AUTO_INCREMENT: 자동으로 증가
		# -> PK 값 없으면(입력값 없으면) 자동으로 값이 1씩 증가
	create table  user2( 
		user_id INT PRIMARY KEY AUTO_INCREMENT, 
		name Varchar(20) NOT NULL, 
		email Varchar(30) UNIQUE NOT NULL, 
		age INT(3) DEFAULT '30', 
		rdate TIMESTAMP 
	)
# 2. Alter
	# 2-1 Database
	# 현재 인코딩값 확인
	show variables like "character_set_database";
	# test DB의 문자열 인코딩을 utf8로 변경
	alter database test character set = utf8;
	# 문자열 인코딩 변경 결과 확인
	show variables like "character_set_database";
	
	# 2-2 Table
	# user2 테이블에 Text 데이터 타입을 갖는 tmp 컬럼 추가
		# 2-2-1 add
		alter table user2 add tmp TEXT;
		# 2-2-2 modify
		alter table user2 modify column tmp INT(3);
		# 2-2-3 drop
		alter table user2 drop tmp;
# 3. Drop
	# 3-1 Database
	# tmp db 생성
	create database tmp;
	show databases;
	# tmp db 삭제
	drop database tmp;
	show databases;
	# 3-2 Table
	create database tmp;
	use tmp;
	create table tmp( id INT );
	drop table tmp;

# 4. Insert
	# 4-1 user1 테이블에 insert
	use test;
	
	insert into user1(user_id, name, email, age, rdate)
	values (1, "jin", "pdj@gmail.com", 30, now()), 
	(2, "peter", "peter@daum.net", 33, '2017-02-20'), 
	(3, "alice", "alice@naver.com", 23, '2018-01-05'), 
	(4, "po", "po@gmail.com", 43, '2002-09-16'), 
	(5, "andy", "andy@gmail.com", 17, '2016-04-28'), 
	(6, "jin", "jin1224@gmail.com", 33, '2013-09-02');

# 5. Select
	select * from user1;
	select user_id, name, rdate from user1;
	# 5-1. alias (as) : 별칭
	select user_id as "아이디", name as "이름", rdate as "등록일" from user1
	# 5-2. distinct, 중복제거
	select distinct(name) from user1;
	# 5-3. where
	select * from user1 where age >= 30;
	select * from user1 where age between 19 and 30;
	# 5-4. order by
	select * from user1 order by age; # 디폴트 오름차순
	select * from user1 order by age desc; # 내림차순
	# 5-5. concat
	select email, concat(name, "(", age, ")") as "name_age" from user1;
	# 5-6. like
	select * from user1 where email like "%@daum%";
	# 5-7. in
	select * from user1 where age in(20, 24, 25)
# 6. Update
	update user1
	set age = 20, email = "pdj@daum.net"
	where name = "jin"
# 7. Delete
	delete from user1 where rdate < "2016-01-01"

# 8. Group by - having
	# city 테이블에서 나라별 도시의 갯수를 출력
	select * from city
	
	select CountryCode, count(CountryCode) from city
	group by CountryCode
	
	# countrylanguage 테이블에서 전체 언어의 갯수를 출력
	select * from countrylanguage
	
	select count(distinct(Language)) from countrylanguage
	
	# 대륙별 인구수와 GNP의 최대값을 출력
	select * from country
	
	select continent, max(Population), max(GNP) from country
	group by continent
	
	# 대륙별 전체인구를 구하고 5억 이상인 대륙만 출력
	select * from country
	
	select continent, sum(population) as TotalP from country
	# where population > 500000000
	group by continent
	having TotalP > 500000000
		# where: from에 있는 테이블에 적용되는 조건
		# having: group by가 동작한 테이블에 적용되는 조건
	