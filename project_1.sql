use hitman;
select * from hr;


-- Q1. What is gender breakdown of employees in the company?
select gender,count(*) as 'count'
 from hr
where age>=18 and  termdate ="0000-00-00"
group by gender;

-- Q2. what is the race/ethiccity brekdown of the employee in the company?
select race,count(*) as "count" 
from hr
where age>=18 and  termdate ="0000-00-00"
group by race
order by count desc;

-- Q3. What is the distrubtion of employee in the company?
select 
min(age) as "youngest",
max(age) as "oldest",
round(avg(age),0) as "avg_age"
  from hr
where age>=18 and  termdate ="0000-00-00";

select 
 case
   when age>18 and age<=24 then "18-24"
   when age>=25 and age<=34 then "25-34"
   when age>=35 and age<=44 then "35-44"
   when age>=45 and age<=54 then "45-54"
   when age>=55 and age<=64 then "55-64"
   else "65+"
 end as age_hroup,gender,
 count(*) as "count"
 from hr
 where age>=18 and  termdate ="0000-00-00"
 group by age_hroup,gender
 order by age_hroup,gender;
 
 
 
-- Q4. How many employee work at headquarter versus remote location?
select location,count(*) 
from hr
where age>=18 and  termdate ="0000-00-00"
group by location; 



-- Q5. What is the average length of the employment for employee who have been terminated?
select 
round(avg(datediff(termdate,hire_date))/365,0) as "avg_lenght_employment"
from hr
where termdate <=curdate() and termdate<>"000-00-00" and age>18;

-- Q6. How does the gender distrubttion vary across department and job titlles?
select department,count(*) 
from hr
where age>=18 and termdate="000-00-00"
group by department 
order by count(*);

-- Q7. What is the distrubtion of job titles across of the comapny?  
select jobtitle,count(*) 
from hr
where age>=18 and termdate="000-00-00"
group by jobtitle
order by count(*) desc

;
-- Q8. Which department has the highest turnover rate?
select * from hr;  

-- q9. What is the distruntion of employee across locations by city and state?
select location_state,count(*) 
from hr
where age>=18 and termdate="000-00-00"
group by location_state;


-- q10. How has the company employee count 	changed over the time based and hire time and term date?
select year	,hires,terminations,hires-terminations as net_change,
round((hires-terminations)/hires*100,2) as net_change_percent
  from ( select year(hire_date ) as year,
  count(*) as hires, 
  sum(case when termdate <> "000-00-00" and termdate <=curdate()then 1 else 0 end )as terminations
  from hr where age>=18 group by year(hire_date)
  ) as sub_query
  order by year asc;
  
  
-- Q11.What is the tenture distrubtion for each departmrnt?
select department,round(avg(datediff(termdate,hire_date)/365),0)as avg_tenure from hr
where termdate>=curdate() and termdate<> "00-000-00" and age>18
group by department
