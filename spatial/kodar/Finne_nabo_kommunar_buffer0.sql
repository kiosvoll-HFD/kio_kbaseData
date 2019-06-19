 -- drop table #nabokommune
select b.komnr,a.komnr as naboKomnr into #nabokommune From [KartDatabase].[dbo].[GRUNNKART_K01_KOMMUNE_2018] a, [KartDatabase].[dbo].[GRUNNKART_K01_KOMMUNE_2018] b 
where  b.GEO.STBuffer(0).STIntersects(a.GEO) = 1 
---12 sek 


select *From #nabokommune

select a.* from [KartDatabase].[dbo].[GRUNNKART_K01_KOMMUNE_2018]  a
join #nabokommune b on a.komnr = b.naboKomnr
where b.komnr = '0301'