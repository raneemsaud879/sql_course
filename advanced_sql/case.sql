
SELECT
job_title_short,
job_location,
CASE
when job_location='Anywhere'then 'remote'
when job_location='New York, NY' then 'local'
else 'onsite'
end as location_categroy
from job_postings_fact

SELECT
count(job_id),
CASE
when job_location='Anywhere'then 'remote'
when job_location='New York, NY' then 'local'
else 'onsite'
end as location_categroy
from job_postings_fact
WHERE job_title_short='Data Analyst'
GROUP BY
location_categroy