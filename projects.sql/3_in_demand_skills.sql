/*in demand skills*/
SELECT
skills,
count(skills_job_dim.job_id) as demand_count
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id=skills_job_dim.job_id
INNER join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where job_title_short='Data Analyst'
group by skills
order by demand_count
limit 5