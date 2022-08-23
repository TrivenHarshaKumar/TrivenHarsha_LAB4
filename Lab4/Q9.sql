CREATE DEFINER=`root`@`localhost` PROCEDURE `DISPLAY_SUPPLIER_DETAILS`()
BEGIN

select report.supp_id,report.supp_name,report.Average,
Case 
	when report.Average=5 Then 'Excellent Service'
    when report.Average >4 Then 'Good Service'
    when report.Average>2 Then 'Average  Service'
    else 'Poor  Service'
END as Type_of_Service from
(
	select final.supp_id,supplier.supp_name,final.Average from
    (
		select test2.supp_id,sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
        (
			select supplier_pricing.supp_id,test.ord_id,test.rat_ratstars from supplier_pricing
            join
            (
				select `ORDER`.pricing_id,rating.ord_id,rating.rat_ratstars from `ORDER`
                join rating on rating.`ord_id`=`ORDER`.ord_id
            )as test on test.pricing_id = supplier_pricing.pricing_id
        )as test2 group by supplier_pricing.supp_id
    )as final
    join supplier where final.supp_id=supplier.supp_id
) as report;

END