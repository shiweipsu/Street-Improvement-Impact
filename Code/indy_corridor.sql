select a.geoid10 as geoid, a.c000 as c000,
a.cns07 as cns07, a.cns18 as cns18, a.cns12 as cns12, a.cns14 as cns14, a.cns15 as cns15, 
a.cns16 as cns16, a.cns17 as cns17, a.cns18 as cns18, a.cns19 as cns19, b.name as Name, 
b.buildstart as buildstart, b.buildend as buildend, b.group as corridor_group, 
b.grouptype as grouptype,  a.year as year, a.geom
FROM indy_lehd a, indy_corridors b
WHERE ST_Intersects(ST_Buffer(b.geom, 20), a.geom);