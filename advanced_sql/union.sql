--UNION
/*هنا سويتي جمع لثلاث تيبل بدون عرض البيانات المكرره*/
SELECT
job_location,
company_id,
job_title_short
from jan_jobs
UNION
SELECT
job_location,
company_id,
job_title_short
from feb_jobs
UNION
SELECT
job_location,
company_id,
job_title_short
from mar_jobs

--UNION ALL
/*هنا سويتي جمع لثلاث تيبل مع عرض البيانات المكرره*/
SELECT
job_location,
company_id,
job_title_short
from jan_jobs
UNION ALL
SELECT
job_location,
company_id,
job_title_short
from feb_jobs
UNION ALL
SELECT
job_location,
company_id,
job_title_short
from mar_jobs
