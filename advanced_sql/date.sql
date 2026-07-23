SELECT  job_posted_date
FROM job_postings_fact
LIMIT 10;
SELECT '2023-09-25';
SELECT '2023-09-25'::DATE;
/*تحويل من التاريخ اللي فيه وقت الى تاريخ فقط*/
select 
job_posted_date::DATE as date,
job_title_short as title,
job_location as location
from job_postings_fact
/*بما ان ماعندنا تايم زون محدده بنكرر الجمله مرتين كاننا بنقول حول من كذا الى كذا
*/
select 
job_posted_date at time zone 'UTC' at time zone 'EST' as date,
job_title_short as title,
job_location as location
from job_postings_fact
LIMIT 5;
/*بنستخدمها لاخذ متغير محدد سواء شهر او يوم الخ*/
select 
job_posted_date at time zone 'UTC' at time zone 'EST'  as date,
EXTRACT(MONTH from job_posted_date),
job_title_short as title,
job_location as location
from job_postings_fact
LIMIT 5;
/*استخدمت الكاونت وجمعتهم ب الاشهر المخصصه */
select 
count (job_id ),
EXTRACT(MONTH from job_posted_date)as month
from job_postings_fact
GROUP by month;
/*زياده حطيت شرط ان النواتج تتضمن محلل بيانات فقط ورتبتها ب الكاونت */
select 
count (job_id )as job_posted_count,
EXTRACT(MONTH from job_posted_date)as month
from job_postings_fact
WHERE job_title_short='Data Analyst'
GROUP by month
order by job_posted_count DESC
/*هنا رتبتها بالاشهر*/
select 
count (job_id )as job_posted_count,
EXTRACT(MONTH from job_posted_date)as month
from job_postings_fact
WHERE job_title_short='Data Analyst'
GROUP by month
order by month