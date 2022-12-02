# load libraries
library(ncdf4) # needed to open and write netcdf files
library(ismev) # this has GEV stuff, for example gev.fit
# define file to read in
infile="/data2/Climpact_CORDEX/CORDEX-Australasia/data/obs/AUS-44i_grid/climpact/r95p/r95p_ANN_agcd_historical_v1_1950-2020.nc"
# open the file
file_open <- nc_open(infile)
# jfkdlkjklf
#print(file_open)
# extract variable of interest, in this case, yearly total precipitation above 95 pct of precipitation
r95p <- ncvar_get(file_open,"r95p")
# check the dimensions
dim_r95p <- dim(r95p)
# see if we can fit GEV to data?
# i am not sure, but we might have to loop over every grid point, as gev.fit takes as input numberic vector data, but we have a 3-dimensional array/matrix of size (lon,lat,time), note that some grid points will have all missing data or n/a, we should do nothing for these grid points
# note also, data over ocean is not masked, Will need to mask over ocean values
# Wafaa and Nayomi can take it from here. Suggest to write the outputs to netcdf so we can take a look
# you will probably need to pre-allocate some arrays to store the outputs from gev fitting
# these arrays should be same size as r95p 
#print(dim_r95p)
#stop()
# loop over every grid point 
for (i in 1:dim_r95p[1]) {
     for (j in 1:dim_r95p[2]) {
             # extract r95p at that grid point
             r95p_time_series = r95p[i,j,]
             # if all values are not NA, then continue on
             if (all(is.na(r95p_time_series)) == FALSE) {
                   # it seems there can be one or so NA, and also sometimes, all values are zero
                   # i would suggest to remove the last NA, and if the sum equal zero, do not try to fit gev, as all values would be zero
                    print(r95p_time_series)
                } # this bracket ends the if statement 

} # this bracket end the j loop

} # this bracket ends the i loop

# write the outputs to netcdf, so we  can plot and have a look later on
