/*what are the top skills based on salary*/
SELECT
skills,
round(avg(salary_year_avg),0) as salary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Analyst' and salary_year_avg IS NOT NULL
group by skills
ORDER BY salary DESC
limit 5