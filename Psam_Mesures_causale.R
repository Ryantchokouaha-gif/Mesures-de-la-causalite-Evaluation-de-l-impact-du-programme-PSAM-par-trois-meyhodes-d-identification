setwd("C:/Users/DELL/Desktop/MASTER ECO-APPLIQUEE FRANCE/Mon  ANNEE/2e semestre/Evaluation de politique publiques, application sous R/Travaux Pratiques/entrainement")


###Installation des packages

install.packages("readxl")
install.packages("haven")
install.packages("formattable")
install.packages("questionr")
install.packages("car")
install.packages("carData")
install.packages("miceadds")
install.packages("psych")
install.packages("sandwich")
install.packages("AER")




####Lecture des bibliothèques

library(readxl)
library(haven)
library(formattable)
library(questionr)
library(car)
library(carData)
library(psych)
library(sandwich)
library(miceadds)
library(AER)


###Importation de la BDD

psam <- read_dta("evaluation.dta")


####Partie 1: EXPERIMENTATION ALEATOIRE

#1) Vérifier que les individus éligibles des 100 autres villages non
#pilotes peuvent constituer un contrefactuel valide pour évaluer le 
#programme PSAM 

#Il s'agit d'un bon contrefactuel ssi avant la MISE en place de la PP
#Il n'existe pas de différence signficative dans les deux sous groupes


psam_rando_R0  <- subset(psam, eligible==1 & round ==0)

###Test de différence pour voir s'il des différences


t.test(data=psam_rando_R0, health_expenditures~treatment_locality) #Pas de différence

t.test(data=psam_rando_R0, age_hh~treatment_locality) #Pas de différence

t.test(data=psam_rando_R0, age_sp~treatment_locality) #Pas de différence

t.test(data=psam_rando_R0, educ_hh~treatment_locality) #Pas de différence

t.test(data=psam_rando_R0, educ_sp~treatment_locality) #Pas de différence
t.test(data=psam_rando_R0, land~treatment_locality) #Pas de différence
t.test(data=psam_rando_R0, hospital_distance~treatment_locality) #Pas de différence
t.test(data=psam_rando_R0, hhsize~treatment_locality) #Pas de différence



chisq.test(psam_rando_R0$female_hh,psam_rando_R0$treatment_locality) #Pas de différence 
chisq.test(psam_rando_R0$hospital,psam_rando_R0$treatment_locality)  #Pas de différence
chisq.test(psam_rando_R0$bathroom,psam_rando_R0$treatment_locality) #Pas de différence
chisq.test(psam_rando_R0$dirtfloor,psam_rando_R0$treatment_locality) #Pas de différence
chisq.test(psam_rando_R0$indigenous,psam_rando_R0$treatment_locality) #Pas de différence


#Vu qu'en moyenne les deux sous groupes, ont les memes caractéristiques, alors il constitue un bon contrfactuel.



#2) Comparez les dépenses de santé parmi des individus éligibles des 
#villages pilotes et non pilotes après la mise en place du programme. 
#Concluez.  

psam_rando_R1 <- subset(psam, eligible==1 & round==1) 

t.test(data=psam_rando_R1, health_expenditures~treatment_locality)


t.test(data=psam_rando_R1, health_expenditures~enrolled)



###Voila ça:












###Partie 2: Variables instrumentales

#1 ) Déterminez le taux de participation à PSAM en fonction de villages 
#qui ont bénéficié de la promotion et ceux qui n’en ont pas bénéficié 


##Création des échantillons 

###Un sous groupe de personnes subit la promotion avant la PP

psam_vi_0 <- subset(psam, round==0)


prop.table(table(psam_vi_0$enrolled_rp, psam_vi_0$promotion_locality,deparse.level = 2,useNA = "ifany"),2)


#2 ) Déterminez l’impact de PSAM sur les dépenses de santé à partir de 
#la variable instrumentale décrivant le fait d’avoir bénéficié de la 
#promotion pour PSAM  


psam_vi_1  <-  subset(psam, round==1)

reg_vi  <-  ivreg(data=psam_vi_1, psam_vi_1$health_expenditures~psam_vi_1$enrolled_rp,~psam_vi_1$promotion_locality)

summary(reg_vi,diagnostics = TRUE)






###Partie 3: DOUBLE DIFFERENCE




#1 ) Mesurer les dépenses de santé des traités et des non traités en 
#fonction de la période 




##"Construction des sous groupes:

##Groupe des traités
psam_T  <- subset(psam,treatment_locality==1)


##Groupe des personnes  traités- non traité avant la pp

psam_DD_R0  <- subset(psam,treatment_locality==1 & round==0)

##Groupe des personnes  traités- non traité après  la pp

psam_DD_R1  <- subset(psam,treatment_locality==1 & round==1)

#Groupe des personnes  traités 
psam_DD_T  <- subset(psam,treatment_locality==1 & enrolled==1)


#Groupe des personnes  non traités 
psam_DD_NT  <- subset(psam,treatment_locality==1 & enrolled==0)




#####Comparaison des traité/non traité avant la PP

t.test(data=psam_DD_R0, health_expenditures~enrolled)

#####Comparaison des traité/non traité après la PP

t.test(data=psam_DD_R1, health_expenditures~enrolled)

###Comparaison des non traités avant/ après
t.test(data=psam_DD_NT, health_expenditures~round)


###Comparaison des  traités avant/ après

t.test(data=psam_DD_T, health_expenditures~round)



###Impact de la PP avec les DD
DD <- ivreg(data=psam_T, health_expenditures~enrolled*round)

summary(DD)















