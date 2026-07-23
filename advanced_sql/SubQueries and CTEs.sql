--subqueries 

/*subqueries inside querie (subquerie)*/
SELECT *
from(SELECT*
from job_postings_fact
WHERE EXTRACT(MONTH from job_posted_date)=1

)as jan_jobs


/*here i just select the id from the result of subquere)*/
SELECT job_id
from(SELECT*
from job_postings_fact
WHERE EXTRACT(MONTH from job_posted_date)=1

)as jan_jobs

--CTEs

with jan_jobs as(
  select*
  from job_postings_fact
  WHERE EXTRACT(month from job_posted_date)=1
)select*
from jan_jobs

with jan_jobs as(
  select*
  from job_postings_fact
  WHERE EXTRACT(month from job_posted_date)=1
)select job_title_short
from jan_jobs

--subqueries

select name as company_name
from company_dim
WHERE company_id in(
select company_id
from job_postings_fact
WHERE job_no_degree_mention=true

)

--CTEs
with company_job_count AS (
select company_id,
count(*) as total_jobs
from job_postings_fact
GROUP BY company_id
)
select name,
company_job_count.total_jobs
from  company_dim 
left join company_job_count on company_dim.company_id=company_job_count.company_id
ORDER BY  total_jobs  DESC