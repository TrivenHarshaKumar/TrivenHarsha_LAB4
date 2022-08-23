
select SUP.* from SUPPLIER SUP join (select * 
from SUPPLIER_PRICING
group by SUPP_ID
having count(SUPP_ID)>1) SP 
on SP.SUPP_ID=SUP.SUPP_ID 