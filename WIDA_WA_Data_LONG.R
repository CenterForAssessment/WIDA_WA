########################################################################
###                                                                  ###
###    Create LONG WIDA Washington data from 2022 and 2023 base file ###
###                                                                  ###
########################################################################

### Utility functions
strhead <- function (s, n) {
    if (n < 0)
        substr(s, 1, nchar(s) + n)
    else substr(s, 1, n)
}

strtail <- function (s, n = 1) {
    if (n < 0) 
        substring(s, 1 - n)
    else substring(s, nchar(s) - n + 1)
}

### Load packages
require(data.table)
require(SGPmatrices)

### Load data
#WIDA_WA_Data_LONG <- fread("Data/Base_Files/WIDA_WA_Data_LONG.csv", na.strings=c("NULL", "NA"))
WIDA_WA_Data_LONG <- fread("Data/Base_Files/Prelim_SGP_Pre_R_WIDA_2023_2024_only_CPSD.csv", na.strings=c("NULL", "NA"))

### Rename variables as necessary
setnames(WIDA_WA_Data_LONG, c("TESTED_GRADE", "ACHIEVEMENT_LEVEL"), c("GRADE", "ACHIEVEMENT_LEVEL_ORIGINAL"))

### Tidy up variables
WIDA_WA_Data_LONG[,CONTENT_AREA:="READING"]
WIDA_WA_Data_LONG[YEAR=="2021-22", YEAR:="2022"]
WIDA_WA_Data_LONG[YEAR=="2022-23", YEAR:="2023"]
WIDA_WA_Data_LONG[YEAR=="2023-24", YEAR:="2024"]
WIDA_WA_Data_LONG[,ID:=as.character(ID)]
WIDA_WA_Data_LONG[,GRADE:=as.character(as.numeric(GRADE))]
WIDA_WA_Data_LONG[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]
WIDA_WA_Data_LONG[,ACHIEVEMENT_LEVEL_ORIGINAL:=strtail(ACHIEVEMENT_LEVEL_ORIGINAL, 3)]
WIDA_WA_Data_LONG[,ACHIEVEMENT_LEVEL:=paste("WIDA Level", strhead(ACHIEVEMENT_LEVEL_ORIGINAL, 1))]
WIDA_WA_Data_LONG[ACHIEVEMENT_LEVEL_ORIGINAL %in% c("4.7", "4.8", "4.9"), ACHIEVEMENT_LEVEL:="WIDA Level 4.7"]
WIDA_WA_Data_LONG[,VALID_CASE:="VALID_CASE"]
#WIDA_WA_Data_LONG[GRADE=="12", VALID_CASE:="INVALID_CASE"]

### Save results
save(WIDA_WA_Data_LONG, file="Data/WIDA_WA_Data_LONG.Rdata")
