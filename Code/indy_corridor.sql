select a.geoid10 as geoid, a.cns07 as cns07, a.cns18 as cns18, b.name as corridor, 
b.buildstart as buildstart, b.buildend as buildend, b.group as corridor_group, 
b.grouptype as grouptype, a.year as year, b.geom
FROM indy_lehd a, indy_corridors b
WHERE ST_Intersects(ST_Buffer(b.geom, 20), a.geom)
order by a.geoid10;