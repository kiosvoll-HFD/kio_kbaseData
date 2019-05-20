-- drop table GRUNNKART_K01_Fylke_2018
select fylkesnr, fylke, Geography::UnionAggregate( GEO ) as GEO
---into GRUNNKART_K01_Fylke_2018
from  GRUNNKART_K01_Grunnkretsar_2018
group by fylkesnr, fylke 
-- select * from GRUNNKART_K01_Fylke_2018