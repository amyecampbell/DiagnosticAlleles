# Amy Campbell
# Making list of in-group vs. out-group genomes
# For WhatsGNU analysis of UTD Chile ST105 tree
# for the s. american clade rather than the chile-specific clade
library(dplyr)
library(stringr)

InSamerican = read.csv("Documents/Planet/ST105/UsefulData/InSAmericanClade.txt",header=F)
All=read.csv("Documents/Planet/ST105/UsefulData/AllWhatsGNUfiles.txt",header=F)
All$status="control"
All = All %>% mutate(status=if_else(V1 %in% InSamerican$V1, "case", "control"))
All = All %>% filter(V1!="GCF_000009645.1_WhatsGNU_report.txt")

All$InClade = if_else(All$status=="case", 1, 0)
All$OutOfClade = if_else(All$status=="control", 1, 0)
All$GenomeName = sapply(All$V1, function(x) str_remove_all(x, "_WhatsGNU_report.txt"))


TraitsMat = All %>% select(GenomeName, InClade,OutOfClade)
colnames(TraitsMat) = c("Name", "InClade", "OutOfClade")
write.csv(TraitsMat, file="Documents/Planet/DiagnosticAlleles/SAmericanAlleleScoringInput.csv",quote=F, row.names=F)

sum(All$OutOfClade)
