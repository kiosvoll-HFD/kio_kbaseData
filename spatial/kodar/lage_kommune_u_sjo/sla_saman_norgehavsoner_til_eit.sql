
SELECT Geography::UnionAggregate(ogr_geometry2) HavGeo into norgehavInvertUnion  FROM norgehavInvert


--- dette er prinsippet må skrive det om til lokal kilde file med gjerne grunnkretsar som skal skjerast til.
select ogr_geometry.STDifference( (select HavGeo from norgehavInvertUnion) ) as NyGeo,kommunenummer,substring(navn,4,100) as navn 
into #komKart 
From kommunarnorge
-- 
select * From #komkart where kommunenummer < 1700