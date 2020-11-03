
# Sakila
use sakila
# quiz1/ 가장 돈을 많이 지불한 상위 5명의 고객의 이름과 지불 금액 출력
# customer, payment 테이블 사용
select * from customer as c;
select * from payment as p;
	# 고객 이름 join 돈-> 가장 돈 많이  
	select c.customer_id, concat(first_name, " ", last_name) as full_name,
		sum(p.amount) as amount from customer as c
	join payment as p on c.customer_id = p.customer_id
	group by c.customer_id
	order by amount desc
	limit 5

# quiz2/ 배우별 영화 출연 횟수 출력(상위 10개)
# - 컬럼: 배우이름, 출연횟수
# - 출연횟수 순으로 내림차순
select * from actor as a;
select * from film_actor as fa;

select a.actor_id, concat(first_name, " ", last_name) as full_name,
	count(a.actor_id) as count
from actor as a 
join film_actor as fa on a.actor_id = fa.actor_id
group by a.actor_id 
order by count desc
limit 10


# quiz3/ 영화 카테고리별 수입 데이터를 내림차순으로 정렬
# payment, rental, inventory, film_category, category 테이블 사용
select * from payment as p;
select * from rental as r;
select * from inventory as i;
select * from film_category as f;
select * from category as c;

	select category.name, sum(payment.amount) as amount 
	from payment, rental, inventory, film_category, category
	where payment.rental_id = rental.rental_id
		and rental.inventory_id = inventory.inventory_id
		and inventory.film_id = film_category.film_id
		and film_category.category_id = category.category_id
	group by category.name
	order by amount desc

test