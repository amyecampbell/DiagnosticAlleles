# Amy Campbell
# Making list of in-group vs. out-group genomes
# For WhatsGNU analysis of UTD Chile ST105 tree
library(dplyr)
library(stringr)

InChile = read.csv("Documents/Planet/ST105/UsefulData/InChileanClade.txt",header=F)
All=read.csv("Documents/Planet/ST105/UsefulData/AllWhatsGNUfiles.txt",header=F)
All$status="control"
All = All %>% mutate(status=if_else(V1 %in% InChile$V1, "case", "control"))

# Exclude the outgroup from this analysis
#All$V1 = sapply(All$V1, function(x) paste0(x, "/", x))

All$V1 = sapply(All$V1, function(x) paste0(x,"_WhatsGNU_report.txt"))
All = All %>% filter(V1!="GCF_000009645.1_WhatsGNU_report.txt")
write.table(All, file="Documents/Planet/DiagnosticAlleles/ChileanCladeCaseControlDecTree.csv", sep=',', quote = F, col.names = F, row.names = F)


All$InClade = if_else(All$status=="case", 1, 0)
All$OutOfClade = if_else(All$status=="control", 1, 0)
All$GenomeName = sapply(All$V1, function(x) str_remove_all(x, "_WhatsGNU_report.txt"))

TraitsMat = All %>% select(GenomeName, InClade,OutOfClade)
colnames(TraitsMat) = c("Name", "InClade", "OutOfClade")
write.csv(TraitsMat, file="Documents/Planet/DiagnosticAlleles/ChileanAlleleScoringInput.csv",quote=F)

# WhatsGNU results
####################
WGresults = read.csv2("Documents/Planet/DiagnosticAlleles/WhatsGNU_ChileCladeVolcanoDecemberTreeNoOutgroup/WhatsGNU_ChileCladeVolcanoDecemberTreeNoOutgroup_WhatsGNU_volcano.txt",sep='\t' )
WGresults$DELTA_AVG_GNU = sapply(WGresults$DELTA_AVG_GNU, function(x) as.numeric(as.character(x)))
WGresults$X.log10.pvalue = sapply(WGresults$X.log10.pvalue, function(x) as.numeric(as.character(x)))
PresentInBoth=WGresults %>% filter(case==max(case) & control==max(control))

# WhatsGNU x Scoary results for chile
# Andries's Allele_Scoring script 
##################################
ResultsScoaryWG = read.csv("Documents/Planet/DiagnosticAlleles/InClade_allele_scoring.csv")
ResultsScoaryWG$specificity = sapply(ResultsScoaryWG$specificity, function(x) as.numeric(as.character(x)))
ResultsScoaryWG$sensitivity = sapply(ResultsScoaryWG$sensitivity, function(x) as.numeric(as.character(x)))

top10Chilean= (ResultsScoaryWG %>% arrange(-specificity, -sensitivity))[1:10,]

