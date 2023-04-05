select *
from  cities;

##Number of rows in database

select count(*) from cities;

##Dataset for Jharkhand and Bihar 

select * from  cities 
where state_name in ('Jharkhand' , 'Bihar');

## Population of top 500 cities

select sum(population_total) from  cities;

## Total male pouplation

select  state_name, sum(population_male) as total_population_male from cities
group by state_name
order by total_population_male;

## Total female pouplation

select state_name, sum(population_female) total_population_female from cities
group by state_name
order by total_population_female;

## Average Sex Ratio 

select state_name, round(avg(sex_ratio),0) avg_sex_ratio from cities
group by state_name
order by avg_sex_ratio;

## Average literacy rate

select state_name, round(avg(effective_literacy_rate_total),0) avg_literacy_rate from cities
group by state_name
order by avg_literacy_rate desc;

## Top 3 states having highest population
select  state_name, sum(population_total) from  cities
group by state_name
order by sum(population_total) desc limit 3;

## Bottom 3 states population wise

select  state_name, sum(population_total) from  cities
group by state_name
order by sum(population_total) asc limit 3;

## Top 3 states showing lowest sex ratio

select state_name, round(avg(sex_ratio),0) avg_sex_ratio from cities
group by state_name
order by avg_sex_ratio asc limit 3;

## Top 3 states in literacy ratio
 drop table if exists Topstates;
 create table Topstates
 (state_name nvarchar(255),
 literacy_rate float);
 insert into Topstates
 select state_name, round(avg(effective_literacy_rate_total),0) avg_literacy_rate from cities
group by state_name
order by avg_literacy_rate desc limit 3;
select * from Topstates;

## Bottom 3 states in literacy ratio

drop table if exists Bottomstates;
 create table Bottomstates
 (state_name nvarchar(255),
 literacy_rate float);
 insert into Bottomstates
 select state_name, round(avg(effective_literacy_rate_total),0) avg_literacy_rate from cities
group by state_name
order by avg_literacy_rate asc limit 3;
select * from Bottomstates;

## States with letter a and b
select distinct State_name from cities 
where lower(state_name) like 'a%' or lower(state_name) like 'b%';

## Illiterate people and Literate people
select a.state_name, sum(literates_total) total_literate_people, sum(Illetrate_people) total_illiterate_people from
(select name_of_city, state_name ,literates_total,round((1-effective_literacy_rate_total/100)*population_total,0) Illetrate_people
from cities) a
group by a.state_name
order by total_illiterate_people desc;


## Top 3 states in literacy rate
select  state_name, name_of_city, effective_literacy_rate_total, rank() over(partition by name_of_city order by effective_literacy_rate_total) rnk
from cities
