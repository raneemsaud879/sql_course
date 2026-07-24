/*what skills are the required for the tob-paying data analyst job*/


with top_paying_job AS(
select 
job_title_short,
job_id,
salary_year_avg,
name as company_name
from job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id=company_dim.company_id
WHERE job_title_short='Data Analyst' AND job_location='Anywhere'AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10)
select
top_paying_job.*
skills
from top_paying_job
INNER JOIN skills_job_dim on top_paying_job.job_id=skills_job_dim.job_id
INNER join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY salary_year_avg DESC