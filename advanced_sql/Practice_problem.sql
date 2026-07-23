--practice problem 6

/*the value with only jan*/
SELECT*
FROM job_postings_fact
WHERE EXTRACT(MONTH from job_posted_date)=1
LIMIT 10;
/*create table to have jan jobs only*/
create table jan_jobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date)=1;


create table feb_jobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date)=2;

create table mar_jobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date)=3;

SELECT job_posted_date
from mar_jobs;

--practice problem 7
/*
find the count of remote job postings per skill
disply the top 5 skills by thire demand in remote job
include skill id, name, and count of postings requaring skill
*/
with remote_job_skills as(
select 
skill_id,
count(*) as skill_count
from
skills_job_dim inner join job_postings_fact on job_postings_fact.job_id=skills_job_dim.job_id
WHERE job_postings_fact.job_work_from_home=true AND job_postings_fact.job_title_short='Data Analyst'
GROUP BY skill_id)
select
skills_dim.skill_id,
skills,
skill_count
from remote_job_skills inner join skills_dim on skills_dim.skill_id=remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5

--practice problem 8
/*
find job postings from the first quarter that have a salary greater than 70$k
combine job postings tables from the first quarter of 2023 (jan-mar)
gets job postings with an average yearly salary >70$k

*/
select
job_location,
job_via,
salary_year_avg,
quarter1_job_postings.job_posted_date::Date
from(
SELECT*
from jan_jobs
UNION ALL
SELECT*
from feb_jobs
UNION ALL
SELECT*
from mar_jobs)
as quarter1_job_postings
WHERE salary_year_avg>70000 and job_title_short='Data Analyst'
ORDER BY
salary_year_avg DESC