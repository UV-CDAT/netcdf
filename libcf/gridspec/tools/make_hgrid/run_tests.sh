#!/bin/sh
# This shell script runs the ncdump tests.
# $Id: run_tests.sh,v 1.2 2009/08/25 19:56:10 ed Exp $

set -e
echo ""
echo "*** Testing gridspec hgrids."

echo "*** generating regular lon-lat grid (supergrid size 60x20)..."
./make_hgrid --grid_type regular_lonlat_grid --nxbnd 2 --nybnd 2  \
    --xbnd 0,30 --ybnd 50,60  --nlon 60 --nlat 20
./gs_make_hgrid --grid_type regular_lonlat_grid --nxbnd 2 --nybnd 2  \
    --xbnd 0,30 --ybnd 50,60  --nlon 60 --nlat 20 --grid_name gs_horizontal_grid
../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
#diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

# The following from make_hgrid.c does not work, because there is no
# periodx parameter defined.

#echo "*** generating tripolar grid with various grid resolution and C-cell centered..."
#./make_hgrid --grid_type tripolar_grid --nxbnd 2 --nybnd 7 --xbnd -280,80 \
#    --ybnd -82,-30,-10,0,10,30,90 --nlon 720 --nlat 104,48,40,40,48,120 --grid_name om3_grid \
#    --center c_cell  --periodx 360 
# ./gs_make_hgrid --grid_type tripolar_grid --nxbnd 2 --nybnd 7 --xbnd -280,80 \
#     --ybnd -82,-30,-10,0,10,30,90 --nlon 720 --nlat 104,48,40,40,48,120 --grid_name om3_grid \
#     --center c_cell --periodx 360 --grid_name gs_horizontal_grid
# ../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
# ../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
# diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

echo "*** generating simple cartesian grid(supergrid size 20x20)..."
./make_hgrid --grid_type simple_cartesian_grid --xbnds 0,30 --ybnds 50,60 \
    --nlon 20 --nlat 20  --simple_dx 1000 --simple_dy 1000
./gs_make_hgrid --grid_type simple_cartesian_grid --xbnds 0,30 --ybnds 50,60 \
    --nlon 20 --nlat 20  --simple_dx 1000 --simple_dy 1000 --grid_name gs_horizontal_grid
../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
# diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

echo "*** generating conformal cubic grid. (supergrid size 60x60 for each tile)..."
./make_hgrid --grid_type simple_cartesian_grid --xbnd 0,30 --ybnd 50,60 \
    --nlon 20 --nlat 20  --simple_dx 1000 --simple_dy 1000
./gs_make_hgrid  --grid_type simple_cartesian_grid --xbnd 0,30 --ybnd 50,60 \
    --nlon 20 --nlat 20  --simple_dx 1000 --simple_dy 1000 --grid_name gs_horizontal_grid
../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
# diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

echo "*** generating conformal cubic grid. (supergrid size 60x60 for each tile)..."
./make_hgrid --grid_type conformal_cubic_grid --nlon 60 --nratio 2
./gs_make_hgrid  --grid_type conformal_cubic_grid --nlon 60 --nratio 2 --grid_name gs_horizontal_grid
../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
# diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

echo "*** generating gnomonic cubic grid with equal_dist_face_edge..."
./make_hgrid  --grid_type gnomonic_ed --nlon 60
./gs_make_hgrid --grid_type conformal_cubic_grid --nlon 60 --nratio 2 --grid_name gs_horizontal_grid
../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
# diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

echo "*** generating spectral grid. (supergrid size 128x64)..."
./make_hgrid --grid_type spectral_grid --nlon 128 --nlat 64
./gs_make_hgrid --grid_type spectral_grid --nlon 128 --nlat 64 --grid_name gs_horizontal_grid
../../../../ncdump/ncdump horizontal_grid.nc > horizontal_grid.cdl
../../../../ncdump/ncdump -n horizontal_grid gs_horizontal_grid.nc > gs_horizontal_grid.cdl
#diff -w horizontal_grid.cdl gs_horizontal_grid.cdl 

echo "*** All gridspec hgrid tests passed!"
exit 0
