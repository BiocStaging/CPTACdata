## Render the upsetSamples() figure of TCGA ovarian patients across the RPPA
## data and the CPTAC proteome and phosphoproteome experiments. The output,
## featured-ov-cptac-upset.png, is the featured image of the CPTACdata blog
## post.
library(CPTACdata)
library(curatedTCGAData)
library(MultiAssayExperiment)
mae <- curatedTCGAData("OV", "RPPAArray", version = "2.1.1", dry.run = FALSE)
mae <- appendCPTAC(mae, fraction = "Proteome")
mae <- appendCPTAC(mae, fraction = "Phosphoproteome")
mae

p <- upsetSamples(mae, text.scale = 1.4, mainbar.y.label = "Patients")
## UpSetR gives the bar chart a negative bottom margin (-0.65 lines), which
## hides the "0" on its y-axis behind the dot matrix
n <- length(p$Main_bar$heights)
p$Main_bar$heights[n] <- grid::unit(0.6, "lines")

ragg::agg_png("featured-ov-cptac-upset.png", width = 8, height = 5,
              units = "in", res = 300, scaling = 1.3, background = "white")
print(p)   # UpSetR objects draw only when printed
dev.off()
