/*Display every job title with its company name. If the salary is greater than 100000, display ‘High Salary’, otherwise display ‘Normal Salary’.*/
SELECT
    company_dim.name,
    job_postings_fact.job_title,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High Salary'
        ELSE 'Normal Salary'
    END AS Salary_Status
FROM job_postings_fact
INNER JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id;

/*Display all jobs posted during novamber*/
SELECT
job_title_short,
job_posted_date::Date
from job_postings_fact
where EXTRACT(month from job_posted_date)=11
/*Display the average salary for each job schedule type.*/
select
job_schedule_type,
avg(salary_year_avg)
from job_postings_fact
GROUP BY job_schedule_type

/*Display every company that posted a remote job (job_work_from_home = TRUE)*/
select
company_dim.name
from job_postings_fact INNER JOIN company_dim on job_postings_fact.company_id= company_dim.company_id 
where job_work_from_home =TRUE

/*Display every company that has posted more than one job*/
select
company_dim.name,
count(*)
from job_postings_fact
INNER JOIN company_dim on job_postings_fact.company_id= company_dim.company_id 
GROUP BY name
having count(*) >1

/*Display the highest-paying job for every company.*/

select
company_dim.name,
salary_year_avg,
job_title_short
from job_postings_fact
INNER JOIN company_dim on job_postings_fact.company_id= company_dim.company_id 
where salary_year_avg=(
select max(salary_year_avg)
from job_postings_fact
where job_postings_fact.company_id= company_dim.company_id 
)
/*Display all jobs whose salary is greater than the overall average salary.*/
select
job_title_short,
salary_year_avg
from job_postings_fact
where salary_year_avg >(
    select avg(salary_year_avg)
    from job_postings_fact
)

/*Create a CTE called high_salary_jobs that contains all jobs with salaries greater than 120000. Display only the job title and salary*/

with high_salary_jobs as (
select job_title_short,salary_year_avg
from job_postings_fact
where salary_year_avg>120000
)
select*
from high_salary_jobs

/*Display every company along with the number of different skills required across all its jobs.*/

select
company_dim.name,
count (distinct skills_dim.skill_id)
from job_postings_fact INNER join company_dim on job_postings_fact.company_id=company_dim.company_id
INNER join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
GROUP BY company_dim.name

/*Display all jobs that require either SQL or Python*/

select job_title_short,skills
from job_postings_fact 
INNER join skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where skills_dim.skills ='python' or skills_dim.skills = 'sql'

/*Use UNION to combine:all Data Analyst jobs all Data Scientist jobs Return only:Job Title Salary*/

select job_title_short,salary_year_avg
from job_postings_fact
where job_title_short ='Data Analyst'
UNION
select job_title_short,salary_year_avg
from job_postings_fact
where job_title_short ='Data Scientist'

/*Find companies whose average salary is higher than the average salary of all companies.*/

select company_dim.name,avg(salary_year_avg)
from job_postings_fact INNER join company_dim on job_postings_fact.company_id=company_dim.company_id
GROUP BY name
having avg(salary_year_avg )>(
    select avg(salary_year_avg)
    from job_postings_fact
)

/*Display the top-paying job for every job schedule type.*/
select
job_schedule_type,
salary_year_avg
from job_postings_fact j1
where salary_year_avg=(
    select max(salary_year_avg)
    FROM job_postings_fact j2
    where j2.job_schedule_type=j1.job_schedule_type
)
select
job_schedule_type,
max(salary_year_avg)
from job_postings_fact
GROUP BY job_schedule_type

/*Create a report showing:Company
Job
Skill
Salary Category (CASE)

Salary Category:

<70000      Low
70000-100000 Medium
>100000     High*/

SELECT
    company_dim.name,
    job_postings_fact.job_title,
    skills_dim.skills,
CASE
WHEN salary_year_avg < 70000 THEN 'Low'
WHEN salary_year_avg BETWEEN 70000 AND 100000
THEN 'Medium'
ELSE 'High'
END AS Salary_Level
FROM job_postings_fact
INNER JOIN company_dim
ON job_postings_fact.company_id = company_dim.company_id
INNER JOIN skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id;


/*Using a CTE, display only companies that posted more than 10 jobs.*/
WITH CompanyJobs AS
(
SELECT
    company_id,
    COUNT(*) AS Total_Jobs
FROM job_postings_fact
GROUP BY company_id
)
SELECT
    company_dim.name,
    CompanyJobs.Total_Jobs
FROM CompanyJobs
INNER JOIN company_dim
ON CompanyJobs.company_id = company_dim.company_id
WHERE Total_Jobs > 10;


