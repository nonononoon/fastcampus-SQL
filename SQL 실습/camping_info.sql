select *
from camping_info ;

select count(*)
from camping_info ;

-- 1. 캠핑장의 사업장명과 소재지전체주소를 출력 (단, 사업장명은 NAME , 소재지전체주소는 ADDRESS로 출력)

select 사업장명 as NAME , 소재지전체주소 as ADDRESS
from camping_info ;


-- 2. 1번 데이터에서 정상영업 하고 있는 캠핑장만 출력

select 사업장명 as "NAME" , 소재지전체주소 as "ADDRESS"
from camping_info 
where 영업상태구분코드 = 1;

-- 3. 양양에 위치한 캠핑장은 몇개인지 출력
 
select count(*)
from camping_info 
where 소재지전체주소 like '%양양%';

-- 4. 3번 데이터에서 폐업한 캠핑장은 몇개인지 출력

select count(*)
from camping_info 
where 소재지전체주소 like '%양양%' and 영업상태구분코드 = 3 ;

-- 5. 태안에 위치한 캠핑장의 사업장명 출력

select 사업장명
from camping_info 
where 소재지전체주소 like '%태안%' ;

-- 6. 5번 데이터에서 2020년에 폐업한 캠핑장만 출력

select 사업장명
from camping_info 
where 소재지전체주소 like '%태안%' and 폐업일자 in (2020) ;

select 사업장명
from camping_info 
where 소재지전체주소 like '%태안%' and 폐업일자 like '2020%' ;

-- 7. 제주도와 서울에 위치한 캠핑장은 몇개인지 출력

select count(*)
from camping_info 
where 소재지전체주소 like '%제주도%' or 소재지전체주소 like '%서울%' ;

-- 1. 해수욕장에 위치한 캠핑장의 사업장명과 인허가일자를 출력

select 사업장명 , 인허가일자
from camping_info 
where 사업장명 like '%해수욕장%';

-- 2. 제주도 해수욕장에 위치한 캠핑장의 소재지전체주소와 사업장명 출력

select 소재지전체주소 , 사업장명 
from camping_info 
where 소재지전체주소 like '%제주%' and 사업장명 like '%해수욕장%' ;

-- 3. 2번 데이터에서 인허가일자가 가장 최근일 곳의 인허가일자 출력

select max(인허가일자)
from camping_info 
where 소재지전체주소 like '%제주%' and 사업장명 like '%해수욕장%' ;


select 인허가일자
from camping_info 
where 소재지전체주소 like '%제주%' and 사업장명 like '%해수욕장%' 
order by 인허가일자 desc 
limit 1;


-- 4. 해수욕장에 위치한 캠핑장 중 시설면적이 가장 넓은 곳의 시설면적 출력

select max(시설면적)
from camping_info 
where 사업장명 like '%해수욕장%' ;

-- 5. 해수욕장에 위치한 캠핑장의 평균 시설면적 출력 

select AVG(시설면적)
from camping_info 
where 사업장명 like '%해수욕장%' ;

-- 1. 캠핑장의 사업장명과 시설면적이 가장 넓은 순으로 출력

select 사업장명 , 시설면적 
from camping_info 
order by 시설면적 desc;

-- 2. 1번 데이터에서 10위까지만 출력

select 사업장명 , 시설면적 
from camping_info 
order by 시설면적 desc
limit 10;

-- 3. 경기도 캠핑장중에 면적이 가장 넓은 순으로 5개만 출력

select 사업장명 , 시설면적 
from camping_info 
where 소재지전체주소 like '경기%'
order by 시설면적 desc
limit 5;

-- 4. 3번 데이터에서 1위는 제외

select 사업장명 , 시설면적 
from camping_info 
where 소재지전체주소 like '경기도%'
order by 시설면적 desc
limit 1,4 ;

-- 5. 영업중인 캠핑장 중에서 인허가일자가 가장 오래된 순으로 20개 출력

select 영업상태명 , 인허가일자 , 사업장명
from camping_info 
where 영업상태구분코드 = 1
order by 인허가일자 asc
limit 20;

-- 6. 2020년 10월 ~ 2021년 3월 사이에 폐업한 캠핑장의 사업장명과 소재지 전체주소 출력

select 사업장명 , 소재지전체주소 , 폐업일자
from camping_info 
where 폐업일자 between '2020-10-01' and '2021-03-31';

select *
from camping_info ;

-- 7. 폐업한 캠핑장 중에서 시설면적이 가장 컸던 곳이 사업장명과 시설면적 출력 

select 사업장명 , 시설면적
from camping_info 
where 영업상태구분코드 = 3 
order by 시설면적 desc
limit 1;

-- 1. 각 지역별 캠핑장 수 출력 (단,지역은 LOCATION으로 출력)

select substr(소재지전체주소,1,instr(소재지전체주소,' ')) as "LOCATION" , count(*) 
from camping_info 
group by substr(소재지전체주소,1,instr(소재지전체주소,' ')) ;

-- 2. 1번 데이터를 캠핑장 수가 많은 지역부터 출력

select substr(소재지전체주소,1,instr(소재지전체주소,' ')) as "LOCATION" , count(*)
from camping_info 
group by substr(소재지전체주소,1,instr(소재지전체주소,' ')) 
order by count(*) desc;

-- 3. 각 지역별 영업중인 캠핑장 수 출력

select count(*) , substr(소재지전체주소,1,instr(소재지전체주소,' ')) as "LOCATION"
from camping_info 
where 영업상태구분코드 = 1
group by substr(소재지전체주소,1,instr(소재지전체주소,' '));

-- 4. 3번 데이터에서 캠핑장 수가 300개 이상인 지역만 출력

select count(*) , substr(소재지전체주소,1,instr(소재지전체주소,' ')) as "LOCATION"
from camping_info 
where 영업상태구분코드 = 1
group by substr(소재지전체주소,1,instr(소재지전체주소,' '))
having count(*) >= 300 ;

-- 5. 년도별 폐업한 캠핑장 수 출력 (단,년도는 year로 출력)

select substr(폐업일자 , 1 , 4) as year , count(*)
from camping_info 
where 영업상태구분코드 = 3
group by year ;

-- 6. 5번 데이터를 년도별로 내림차순하여 출력 

select substr(폐업일자 , 1 , 4) as year , count(*)
from camping_info 
where 영업상태구분코드 = 3
group by year 
order by year  desc;




