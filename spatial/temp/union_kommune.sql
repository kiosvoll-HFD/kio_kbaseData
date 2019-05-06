  
	--- drop table #sf
	select 
	 ogr_fid, GEOM, gml_id, lokalid, navnerom, versjonid, datauttaksdato, kommunenummer, navn, [språk] as spraak, [samiskforvaltningsområde] samiskforvaltningsomrade, oppdateringsdato, [rekkefølge] rekkefolge 
	,GEOM as GEOM_Merga, case when kommunenummer in ('1433','1431','1432','1430') then '1499' else kommunenummer end as NyttKomnr , tellar_pos   = converT(int,1), Tellar_max = converT(int,1)
		into #sf From [ETL].[kommunar_norge] where kommunenummer like '14%'

	update #sf set tellar_pos = (select count(*) from #sf b where  b.ogr_fid >= #sf.ogr_fid and #sf.nyttKomnr = b.nyttKomnr ) 
	go
	update #sf set Tellar_max = (select max(b.tellar_pos) from #sf b where   #sf.nyttKomnr = b.nyttKomnr ) 


	--select NyttKomnr,tellar_pos, Tellar_max from #sf order by 1,2,3

	update #sf set GEOM_Merga = GEOM_Merga.STUnion((select b.GEOM_Merga from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 2)) 
					from #sf
					where exists (select *  from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 2) 
					and tellar_pos = 1
	go 
	update #sf set GEOM_Merga = GEOM_Merga.STUnion((select b.GEOM_Merga from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 3)) 
					where exists (select *  from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 3) 
					and tellar_pos = 1
	go 
		update #sf set GEOM_Merga = GEOM_Merga.STUnion((select b.GEOM_Merga from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 4)) 
					where exists (select *  from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 4) 
					and tellar_pos = 1
	
delete from #sf where tellar_pos > 1 
-- drop table  ETL.Resultat_Sammanslaaing
select  *  into ETL.Resultat_Sammanslaaing from #sf

select *from ETL.Resultat_Sammanslaaing

-- drop table  ETL.Resultat_Sammanslaaing
select   ogr_fid,GEOM,  gml_id, lokalid, navnerom, versjonid, datauttaksdato, kommunenummer, navn, spraak, samiskforvaltningsomrade, oppdateringsdato, rekkefolge,  NyttKomnr, tellar_pos, Tellar_max
 into ETL.Resultat_Sammanslaaing from #sf





-- drop table  ETL.Resultat_Sammanslaaing
select  ogr_fid,GEOM_Merga,  gml_id, lokalid, navnerom, versjonid, datauttaksdato, kommunenummer, navn, spraak, samiskforvaltningsomrade, oppdateringsdato, rekkefolge,  NyttKomnr, tellar_pos, Tellar_max
  into ETL.Resultat_Sammanslaaing from #sf



sp_help 'ETL.Resultat_Sammanslaaing'
-- drop table  ETL.Resultat_Sammanslaaing
select * from #sf
select top 2 ogr_fid,GEOM_Merga as Merg,NyttKomnr,Navn  into ETL.Resultat_Sammanslaaing  from #sf 

-- drop table  ETL.Resultat_Sammanslaaing
select top 2 ogr_fid,GEOM as Merg,NyttKomnr,Navn  into ETL.Resultat_Sammanslaaing  from #sf 


select  * from ETL.Resultat_Sammanslaaing

	select * from #sf where nyttkomnr = '1499' -- in ('1433','1431','1432','1430')
	and tellar_pos = 1


	select *, case when kommunenummer in ('1433','1431','1432','1430') then '1499' else kommunenummer end as NyttKomnr into #sf2
	from #sf


	select NyttKomnr,GEOM.STUniongeometry::UnionAggregate(GEOM) From #sf2
	group by NyttKomnr

 DECLARE @g geography = 'POLYGON ((-0.5 0, 0 1, 0.5 0.5, -0.5 0))'  
 DECLARE @h geography = 'CURVEPOLYGON(COMPOUNDCURVE(CIRCULARSTRING(0 0, 0.7 0.7, 0 1), (0 1, 0 0)))'  
 SELECT @g.STUnion(@h).ToString()



 	select   geom,GEOM_Merga = GEOM_Merga.STUnion((select b.GEOM_Merga from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 3)) 
	from #sf 
					where exists (select *  from #sf b where b.nyttKomnr = #sf.nyttKomnr and b.tellar_pos = 3) 
					and tellar_pos = 1





 

 DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('POLYGON((-122.358 47.653, -122.348 47.649, -122.348 47.658, -122.358 47.658, -122.358 47.653))', 4326);  
SET @h = geography::STGeomFromText('POLYGON((-122.351 47.656, -122.341 47.656, -122.341 47.661, -122.351 47.661, -122.351 47.656))', 4326);  
SELECT @g
SELECT @h
SELECT @g.STUnion(@h)  