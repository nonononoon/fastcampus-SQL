-- 1. 고속도로 휴게소의 규모와 화장실 현황을 함께 출력 (휴게소명, 시설구분, 남자_변기수, 여자_변기수)

select s.휴게소명 , s.시설구분 , r.남자_변기수 , r.여자_변기수
from rest_area_scor s , rest_area_restroom r
where s.휴게소명  = r.시설명 ;

select s.휴게소명 , s.시설구분 , r.남자_변기수 , r.여자_변기수
from rest_area_scor s left outer join rest_area_restroom r
on s.휴게소명  = r.시설명 
union 
select r.시설명 , s.시설구분 , r.남자_변기수 , r.여자_변기수
from rest_area_restroom r left outer join rest_area_scor s on s.휴게소명  = r.시설명 ;

-- 2. 노선별 남자 변기수, 여자 변기수 최대값 출력

select 노선 , max(남자_변기수) , max(여자_변기수)
from rest_area_restroom 
group by 노선 ;

-- 3. 휴게소 중 total 변기수가 가장 많은 휴게소가 어디인지 출력 

select 시설명 , 남자_변기수+여자_변기수 as total
from rest_area_restroom 
order by total desc
limit 1;


-- 4. 노선별로 남자_변기수 , 여자_변기수의 평균값 출력

select 노선 , round(avg(남자_변기수)) , round(avg(여자_변기수))
from rest_area_restroom 
group by 노선 ;

-- 5. 노선별로 total 변기수가 가장 많은곳만 출력

select t.노선 ,  t.total 
from (
select 노선 , 남자_변기수+여자_변기수 as total ,
rank() over(partition by 노선 order by 남자_변기수+여자_변기수 desc) as rnk
from rest_area_restroom) t
where t.rnk = 1;

-- 6. 반려동물 놀이터가 있는 휴게소 중 wifi 사용이 가능한 곳 출력

select *
from rest_area_animal a left outer join rest_area_wifi w on a.휴게소명 = w.휴게소명
where w.가능여부 = 'o' ; 

-- 7. 반려동물 놀이터가 있는 휴게소 중 운영시간이 24시간인 곳이 몇 군데인지 출력

select count(*)
from rest_area_animal
where 운영시간 = '24시간' ;

-- 8. 본부별로 wifi 사용이 가능한 휴게소가 몇군데인지 출력

select 본부 , count(*)
from rest_area_wifi
where 가능여부 = 'o'
group by 본부 ;

-- 9. 8번 데이터를 휴게소가 많은 순서대로 정렬하여 출력

select 본부 , count(*) as total
from rest_area_wifi
where 가능여부 = 'o'
group by 본부 
order by total desc ;

-- 10. 9번 데이터에서 휴게소 수가 25보다 많은 곳만 출력 

select 본부 , count(*) as total
from rest_area_wifi
where 가능여부 = 'o'
group by 본부 
having total > 25 
order by total desc ;
