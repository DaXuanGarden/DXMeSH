#####包的检查#####
getwd()
setwd("/home/data/t050446/DX_Package/DXMeSH")
# Load the devtools package
library(usethis)
library(utils)
library(devtools)
# install.packages(c("devtools", "roxygen2", "usethis", "testthat"))
#detach(package:DXMarkers)
rm(list = c())
# 在R控制台中运行以下命令
library(roxygen2)
roxygen2::roxygenize()

# Remove the function from global environment
rm(list = c("get_mesh_terms"))

# Load the package
devtools::load_all()
# Generate documentation
roxygen2::roxygenize()
devtools::document()
# Check the package
# check()

#####包的打包######
# 假设你的R包项目目录是"DXMarkers"，请将路径替换为你的实际路径
getwd()
setwd("/home/data/t050446/DX_Package/DXMeSH")
# 使用devtools包进行打包
devtools::build("/home/data/t050446/DX_Package/DXMeSH")

####试运行#####
getwd()
setwd("/home/data/t050446/DX_Package/DXMeSH")
######本地安装DCMarkers#####
gc()
library(usethis)
library(devtools)
install_local("/home/data/t050446/DX_Package/DXMeSH_1.0.0.tar.gz")
devtools::install_github("DaXuanGarden/DXMeSH")
library(DXMeSH)
get_mesh("DXMeSH.csv")


#######生成并查看说明书#####
# 使用usethis包添加一个名为"my-vignette"的vignette
usethis::use_vignette("DXMarkers")

# Load devtools package
library(devtools)

# Build your vignettes
build_vignettes()

# 查看使用说明书
browseVignettes("DXMarkers")
