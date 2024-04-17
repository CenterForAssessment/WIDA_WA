##########################################################################################
###
### Script for calculating SGPs for 2023 WIDA/ACCESS Washington
###
##########################################################################################

### Load SGP package
require(SGP)


### Load Data
load("Data/WIDA_WA_Data_LONG.Rdata")

### Add baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("WIDA", "2023", "WIDA_WA")


### Run analyses
WIDA_WA_SGP <- abcSGP(
		WIDA_WA_Data_LONG,
#		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "visualizeSGP", "outputSGP"),
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged.baseline=TRUE,
		get.cohort.data.info=TRUE,
		sgp.target.scale.scores=TRUE,
		plot.types=c("growthAchievementPlot", "studentGrowthPlot"),
		sgPlot.demo.report=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results
save(WIDA_WA_SGP, file="Data/WIDA_WA_SGP.Rdata")
