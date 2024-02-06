library(dplyr)
library(stringr)

ResultsScoaryWGChile = read.csv("Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/InClade_allele_scoring_Chile.csv")
ResultsScoaryWGChile$specificity = sapply(ResultsScoaryWGChile$specificity, function(x) as.numeric(as.character(x)))
ResultsScoaryWGChile$sensitivity = sapply(ResultsScoaryWGChile$sensitivity, function(x) as.numeric(as.character(x)))


top10Chilean= (ResultsScoaryWGChile %>% arrange(-specificity, -sensitivity))[1:10,]
write.csv(top10Chilean, "Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/InClade_allele_scoring_Chile_top10.csv")

Over90Chile = (ResultsScoaryWGChile %>% filter(specificity>90 & sensitivity>90))


ResultsScoaryWGChile_OutOfClade = read.csv("Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/OutOfClade_allele_scoring_Chile.csv")
ResultsScoaryWGChile_OutOfClade$specificity = sapply(ResultsScoaryWGChile_OutOfClade$specificity, function(x) as.numeric(as.character(x)))
ResultsScoaryWGChile_OutOfClade$sensitivity = sapply(ResultsScoaryWGChile_OutOfClade$sensitivity, function(x) as.numeric(as.character(x)))
Over90Chile_OutofClade = (ResultsScoaryWGChile_OutOfClade %>% filter(specificity>90 & sensitivity>90))
top10ChileanOutOfClade= (ResultsScoaryWGChile_OutOfClade %>% arrange(-specificity, -sensitivity))[1:10,]
write.csv(top10ChileanOutOfClade, "Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/OutOfClade_allele_scoring_Chile_top10.csv")

# ald1 is the only one which has a really high sensitivity/specificity allele 
# for the in-clade genomes and a different one for the out-of-genome clades
intersect(top10ChileanOutOfClade$ortholog_group,top10Chilean$ortholog_group )


ResultsScoaryWGSamerican = read.csv("Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/InClade_allele_scoring_Samerican.csv")
ResultsScoaryWGSamerican$specificity = sapply(ResultsScoaryWGSamerican$specificity, function(x) as.numeric(as.character(x)))
ResultsScoaryWGSamerican$sensitivity = sapply(ResultsScoaryWGSamerican$sensitivity, function(x) as.numeric(as.character(x)))
top10Samerican = (ResultsScoaryWGSamerican %>% arrange(-specificity, -sensitivity))[1:10,]
View(top10Samerican)
write.csv(top10Samerican, "Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/InClade_allele_scoring_Samerican_top10.csv")

ResultsScoaryWGSamerican_OutOfClade = read.csv("Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/OutOfClade_allele_scoring_Samerican.csv")
ResultsScoaryWGSamerican_OutOfClade$specificity = sapply(ResultsScoaryWGSamerican_OutOfClade$specificity, function(x) as.numeric(as.character(x)))
ResultsScoaryWGSamerican_OutOfClade$sensitivity = sapply(ResultsScoaryWGSamerican_OutOfClade$sensitivity, function(x) as.numeric(as.character(x)))
top10Samerican_OutOfClade = (ResultsScoaryWGSamerican_OutOfClade %>% arrange(-specificity, -sensitivity))[1:10,]
View(top10Samerican)
PresentInBothSamerican = intersect(top10Samerican_OutOfClade$ortholog_group,ResultsScoaryWGSamerican$ortholog_group )
write.csv(top10Samerican_OutOfClade, "Documents/Planet/DiagnosticAlleles/AlleleScoringOutputJan31_DecTree/OutOfClade_allele_scoring_Samerican_top10.csv")

ResultsScoaryWGChilean_AEC = read.csv("Documents/PlanetGithubs/DiagnosticAlleles/WhatsGNUSAmericanClade/InClade_allele_scoring_AEC.csv")
ResultsScoaryWGChilean_AEC_OutOfClade = read.csv("Documents/PlanetGithubs/DiagnosticAlleles/WhatsGNUSAmericanClade/OutOfClade_allele_scoring_AEC.csv")

top10_fixed = (ResultsScoaryWGChilean_AEC %>% arrange(-sensitivity, -specificity))[1:10,]
top10_pre_fixed = (ResultsScoaryWGChile %>% arrange(-sensitivity, -specificity))[1:10,]


Over90_fixed = (ResultsScoaryWGChilean_AEC %>% filter(sensitivity>90 & specificity > 90))
Over90_fixed %>% select(sensitivity,specificity,ortholog_group)


ResultsScoaryWGChilean_UTDtest = read.csv("Documents/PlanetGithubs/DiagnosticAlleles/WhatsGNUSAmericanClade/InClade_allele_scoring_UTDtest.csv")
ResultsScoaryWGChilean_UTDtest_OutOfClade = read.csv("Documents/PlanetGithubs/DiagnosticAlleles/WhatsGNUSAmericanClade/OutOfClade_allele_scoring_UTDtest.csv")
Over90_fixed_again = (ResultsScoaryWGChilean_UTDtest %>% filter(sensitivity>90 & specificity > 90))
Over90_fixed_again %>% select(sensitivity,specificity,ortholog_group)

Over90_fixed_again_out = (ResultsScoaryWGChilean_UTDtest_OutOfClade %>% filter(sensitivity>90 & specificity > 90))
Over90_fixed_again_out %>% select(sensitivity,specificity,ortholog_group)

