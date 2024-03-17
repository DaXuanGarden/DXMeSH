#####包的检查#####
getwd()
setwd("D:/文档/GitHub/DXMeSH")
# Load the devtools package
library(usethis)
library(utils)
library(devtools)
# install.packages(c("devtools", "roxygen2", "usethis", "testthat"))
#detach(package:DXMeSH)
rm(list = c())
#devtools::install_github("elizagrames/litsearchr") #安装litsearchr包
# 在R控制台中运行以下命令
library(roxygen2)
roxygen2::roxygenize()
# Load the package
devtools::load_all()
# Generate documentation
roxygen2::roxygenize()
devtools::document()

# Check the package
#check()

#####包的打包######
# 假设你的R包项目目录是"DXMeSH"，请将路径替换为你的实际路径
getwd()
devtools::build("D:/文档/GitHub/DXMeSH")

####试运行#####
getwd()
setwd("D:/文档/GitHub/DXMeSH")
######本地安装DCMarkers#####
gc()
library(usethis)
library(devtools)
install_local("D:/文档/GitHub/DXMeSH_1.1.0.tar.gz")
devtools::install_github("DaXuanGarden/DXMeSH",force = TRUE)
#get_mesh("DXMeSH.csv")
# Get writing materials
setwd("D:/文档/GitHub/DXMeSH/test/Sample file")
library(DXMeSH)
get_Writing_materials('Introduction-1.docx')

get_Writing_materials('Introduction-1.md')
get_Writing_materials
#######生成并查看说明书#####
# 使用usethis包添加一个名为"my-vignette"的vignette
usethis::use_vignette("DXMeSH")

# Load devtools package
library(devtools)

# Build your vignettes
build_vignettes()

# 查看使用说明书
browseVignettes("DXMeSH")

name.vec <- c("1,3-Diaminopropane;2-Ketobutyric acid;2-Hydroxybutyric acid;2-Methoxyestrone")
toSend = list(queryList = name.vec, inputType = "name")

library(httr)

# The MetaboAnalyst API url
call <- "https://www.xialab.ca/api/mapcompounds"

# Use httr::POST to send the request to the MetaboAnalyst API
# The response will be saved in query_results
query_results <- httr::POST(call, body = toSend, encode = "json")

# Check if response is ok (TRUE)
# 200 is ok! 401 means an error has occured on the user's end.
query_results$status_code==200
# Parse the response into a table
# Will show mapping to "hmdb_id", "kegg_id", "pubchem_id", "chebi_id", "metlin_id", "smiles"
query_results_text <- content(query_results, "text", encoding = "UTF-8")
query_results_json <- jsonlite::fromJSON(query_results_text, flatten = TRUE)
query_results_table <- rbind.data.frame(query_results_json)

write.csv(query_results_table,file = "KEGG_id_used")

