select count(*) as No_of_Customers,CUS_GENDER
from
(select CUS_ID,CUS_GENDER
from (SELECT C.CUS_NAME,C.CUS_GENDER,O.*,SUM(O.ORD_AMOUNT) as Amount
FROM `ORDER` O join  CUSTOMER C
ON C.CUS_ID=O.CUS_ID 
group by C.CUS_ID
HAVING SUM(O.ORD_AMOUNT)>=3000) t1) t2 group by t2.CUS_GENDER