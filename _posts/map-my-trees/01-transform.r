# Load the spatial packages
library(raster)
library(rgdal) # geographical data abstraction layer

# Import the original raster and project with the new CRS
imported_raster <- raster("./acer-campestre.grd")
plot(imported_raster)
crs <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
projected_raster <- projectRaster(imported_raster, crs=crs, method="ngb") 

# Take a look at the 
plot(projected_raster)
projected_raster
width <- 992
height <- 676

# Create an image without a background and deform to match the CRS
png(filename="./tree-map.png", bg="transparent", width=width, height=height)
par(mar = c(0,0,0,0))
raster::image(projected_raster, axes=FALSE, xlab=NA, ylab=NA)
dev.off()
