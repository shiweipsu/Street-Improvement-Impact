for f in *.shp
do
	echo "Processing $f"
ogr2ogr -t_srs EPSG:4269 $f_NAD83.shp $f
done
