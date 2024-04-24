# TREBALL EINES INFORMATIQUES PER A ESTADISTICA

## Nom: Jose Calatayud Mateu
## NIU: 1630376

### Títol: Renda disponible de les llars de la ciutat de Barcelona (per capita)
#### Descripció: Cadascuna de les taules són la renda disponible de les llars de la ciutat de Barcelona, per barris, 
####             per càpita en els anys 2015, 2016, 2017 i 2018. L'objectiu serà juntar aquestes taules per tal de tindre
####             en un mateix dataframe la renda disponible per càpita en cada uns dels anys diferents per barris.

##### Pas (1): Carregar les dades 

url_renda18 = "https://opendata-ajuntament.barcelona.cat/data/dataset/78db0c75-fa56-4604-9510-8b92834a7fd2/resource/34ededd1-6271-4b9b-bac9-18a3fc264a48/download/2018_renda_disponible_llars.csv"
url_renda17 = "https://opendata-ajuntament.barcelona.cat/data/dataset/78db0c75-fa56-4604-9510-8b92834a7fd2/resource/f11301eb-5210-4e61-b6e4-b0837f8309dc/download/2017_renda_disponible_llars.csv"
url_renda16 = "https://opendata-ajuntament.barcelona.cat/data/dataset/78db0c75-fa56-4604-9510-8b92834a7fd2/resource/c4ea1ca7-c2d4-440f-82c0-e3c713e8e3fc/download/2016_renda_disponible_llars.csv"
url_renda15 = "https://opendata-ajuntament.barcelona.cat/data/dataset/78db0c75-fa56-4604-9510-8b92834a7fd2/resource/bb7040fe-608a-41f2-b1d9-bf126392e08a/download/2015_renda_disponible_llars.csv"

renda15=read.csv(url_renda15,sep=',', header=T); head(renda15)
renda16=read.csv(url_renda16,sep=',', header=T); head(renda16)
renda17=read.csv(url_renda17,sep=',', header=T); tail(renda17)
renda18=read.csv(url_renda18,sep=',',header=T); tail(renda18)


##### Pas (2): Manupilar les dades per tal de poder ajuntar-les

summary(renda15)
summary(renda16)
summary(renda17)
summary(renda18)

names(renda15)[length(names(renda15))]<-"2015"
renda15<-renda15[names(renda15)[2:length(names(renda15))]]; head(renda15)

names(renda16)[length(names(renda16))]<-"2016"
renda16<-subset(renda16, select = c("Codi_Barri","2016")); head(renda16)

names(renda17)[length(names(renda17))]<-"2017"
renda17<-subset(renda17, select = c("Codi_Barri","2017")); head(renda17)

names(renda18)[length(names(renda18))]<-"2018"
renda18<-subset(renda18, select = c("Codi_Barri","2018")); head(renda18)

##### Pas (3): Utilitzar merge per ajuntar les dades amb "Codi_Barri"  com enllaç

renda_unif<-merge(x=renda15, y=renda16, by=c("Codi_Barri"))
renda_unif<-merge(x=renda_unif, y=renda17, by=c("Codi_Barri"))
renda_unif<-merge(x=renda_unif, y=renda18, by=c("Codi_Barri"))

head(renda_unif) # Aquesta es la taula unificada (la demanda)

##### Pas (4): Fer GRÀFIQUES de les dades (també es faran en els següents apartats)

## Abans de graficar, hi ha que entendre que signifiquen les dades d'aquest taula. 
## Per exemple, a l'any 2015 la renda disponible d'un individu del barri 'el Raval' era de 10896€ de mitjana, 
## és a dir, és la raò entre la renda total d'aquest barri en 2015 i la seua població enpadronada. 

## Aleshores, no seria correcte sumar totes les files de l'any 2015 i dividir-la pel nombre de files, 
## i dir que aquesta seria la renda per capita de la ciutat de Barcelona. El que s'hauria de fer seria, 
## ponderar cadascuna d'aquestes rendes per capita de cada barri pel nombre d'habitants del barri, 
## sumar-ho i dividir-ho pel nombre d'habitants totals de Barcelona. Açò sí que ens donaria la renda per capita 
## de Barcelona en eixe any.  

## Doncs, per poder treballar millor amb les dades es manipularan important dades poblacionals i així poder graficar
## i mostrar estadístiaues fiables. En efecte;

url_padro15 = "https://opendata-ajuntament.barcelona.cat/data/dataset/56568d9d-651a-49ff-bbc8-52d3fcee4421/resource/301c14bf-1097-4003-860b-da9ad027eb2b/download/2015_padro_ocupacio_mitjana.csv"
url_padro16 = "https://opendata-ajuntament.barcelona.cat/data/dataset/56568d9d-651a-49ff-bbc8-52d3fcee4421/resource/09026d72-aed9-444d-b0bd-5f92c81ece07/download/2016_padro_ocupacio_mitjana.csv"
url_padro17 = "https://opendata-ajuntament.barcelona.cat/data/dataset/56568d9d-651a-49ff-bbc8-52d3fcee4421/resource/c27464bd-1c3c-4a00-b2f4-2968ad07236e/download/2017_padro_ocupacio_mitjana.csv"
url_padro18 = "https://opendata-ajuntament.barcelona.cat/data/dataset/56568d9d-651a-49ff-bbc8-52d3fcee4421/resource/fb4f3e52-8997-4cc0-80be-bebbd850354d/download/2018_padro_ocupacio_mitjana.csv"

padro15=read.csv(url_padro15,sep=',', header=T, dec="."); head(padro15)
padro16=read.csv(url_padro16,sep=',', header=T, dec="."); head(padro16)
padro17=read.csv(url_padro17,sep=',', header=T, dec="."); head(padro17)
padro18=read.csv(url_padro18,sep=',', header=T, dec="."); head(padro18)

summary(padro15)


padro15<-padro15[-c(ncol(padro15),ncol(padro15)-1)]; tail(padro15)
padro15<-padro15[-nrow(padro15),]; tail(padro15) # s'elinima una valor perdut NA 
names(padro15)[length(names(padro15))]<-"2015"
padro15<-padro15[names(padro15)[2:length(names(padro15))]]; head(padro15)

padro16<-padro16[-c(ncol(padro16),ncol(padro16)-1)]
names(padro16)[length(names(padro16))]<-"2016"
padro16<-subset(padro16,select = c("Codi_Barri","2016")); head(padro16)

padro17<-padro17[-c(ncol(padro17),ncol(padro17)-1)]
names(padro17)[length(names(padro17))]<-"2017"
padro17<-subset(padro17,select = c("Codi_Barri","2017")); head(padro17)

padro18<-padro18[-c(ncol(padro18),ncol(padro18)-1)]
names(padro18)[length(names(padro18))]<-"2018"
padro18<-subset(padro18,select = c("Codi_Barri","2018")); head(padro18)

padro_unif<-merge(x=padro15, y=padro16, by=c("Codi_Barri"))
padro_unif<-merge(x=padro_unif, y=padro17, by=c("Codi_Barri"))
padro_unif<-merge(x=padro_unif, y=padro18, by=c("Codi_Barri"))

head(padro_unif) # Aquesta es la taula unificada de la POBLACIÓ 


renda_total<-renda_unif
renda_total[c("2015","2016","2017","2018")]<-renda_unif[c("2015","2016","2017","2018")]*padro_unif[c("2015","2016","2017","2018")]
head(renda_total)

renda_total_BCN<-sapply(renda_total[c("2015","2016","2017","2018")], sum)
plot(renda_total_BCN, lyt='l', pch=c(15:18), col="blue",type='b',lty=2, xaxt="n", xlab="Anys", ylab="Renda")
title(main="Renda total de la ciutat de BCN \n en el periode 2015-2018")
axis(side=1,c(1,2,3,4),labels=c("2015","2016","2017","2018"))
legend(1,3.5e+10,legend=c("2015","2016","2017","2018"),pch=15:18, col="blue", cex=0.7)

## Ací s'aprecia que hi ha hagut un increment però per a ser més realistes
## la gráfica deuria de començar des de l'origen, seria doncs;

plot(renda_total_BCN, lyt='l', pch=c(15:18), col="green",type='b',lty=2, xaxt="n", xlab="Anys", ylab="Renda",ylim=c(0,max(renda_total_BCN)+2e+10))
title(main="Renda total de la ciutat de BCN \n en el periode 2015-2018")
axis(side=1,c(1,2,3,4),labels=c("2015","2016","2017","2018"))
legend(3.5,2.5e+10,legend=c("2015","2016","2017","2018"),pch=15:18, col="green", cex=0.7)

## On s'aprecia el acreixement peró en menor medida

par(mfrow=c(2,2))
hist(renda_total$"2015", main="Histograma renda total dels barris  \n de BCN a l'any 2015", col="aquamarine1", xlab="Renda totals")
hist(renda_total$"2016", main="Histograma renda total dels barris  \n de BCN a l'any 2016", col="aquamarine1", xlab="Renda totals")
hist(renda_total$"2017", main="Histograma renda total dels barris  \n de BCN a l'any 2017", col="aquamarine1", xlab="Renda totals")
hist(renda_total$"2018", main="Histograma renda total dels barris  \n de BCN a l'any 2018", col="aquamarine1", xlab="Renda totals")
par(mfrow=c(1,1))

## Aquest ultims gràfics ens mostran els histogrames de les rendes totals de cada any.

##### Pas (5): ESTADÍSTIQUES

resum<-function(x){
  tipus<-class(x)
  valors.perduts<-sum(is.na(x))
  quartils<-quantile(x)
  minim<-quartils[1]
  maxim<-quartils[5]
  q1<-quartils[2]
  Md<-quartils[3]
  q3<-quartils[4]
  rang<-max(x)-min(x)
  R.I<- q3-q1
  mitjana<-mean(x)
  desv<-sqrt(mean((x-mean(x))^2))
  desv.med<-mean(abs(x-median(x)))
  CV<-desv/mitjana
  alpha.sim<-((q3-Md)-(Md-q1))/R.I
  mu4<-mean((x-mean(x))^4)
  Kurtosis<-mu4/(desv^4)
  llista<-list(min=minim,Q1=q1,mediana=Md,mitjana=mitjana,
               Q3=q3,max=maxim,rang=rang,R.I=R.I,desv=desv,desv.med=desv.med,
               CV=CV,alpha=alpha.sim,curtosi=Kurtosis,NAs=valors.perduts)
  lapply(llista,round,2)
}

t(sapply(renda_unif[c("2015","2016","2017","2018")],resum)) #es tracten de rentes per capita

#A la vista d'aquestes dades s'observa que de mitja un barri de la ciutat
#de BCN tenia una renda per capita entorn als 18997.74€ a l'any 2015. I els barris 
# presentaven en aquest any una desviació mitjana de 5388 entre barris.

# A més, es pot realitzar els histogrames en aquests casos (de rendes per capita)
par(mfrow=c(2,2))

hist(renda_unif$"2015", main="Histograma renda per capita dels barris  \n de BCN a l'any 2015", freq=FALSE,col="gold",xlab="Renda per capita", ylim=c(0,1e-04))
lines(density(renda_unif$"2015"),col="red",lwd=2) #estimació de la funció de densitat 
curve(dnorm(x,mean=mean(renda_unif$"2015"),sd=sd(renda_unif$"2015")), from=10000,to=35000, 
      add=TRUE, col="blue", lwd=2) # ajust d'una funció de densitat normal amb mitjana i desviació típica igual als estimats 

hist(renda_unif$"2016", main="Histograma renda per capita dels barris  \n de BCN a l'any 2016", freq = F,col="gold", xlab="Renda per capita", ylim=c(0,1e-04))
lines(density(renda_unif$"2016"),col="red",lwd=2)
curve(dnorm(x,mean=mean(renda_unif$"2016"),sd=sd(renda_unif$"2016")), from=10000,to=35000, 
      add=TRUE, col="blue", lwd=2)

hist(renda_unif$"2017", main="Histograma renda per capita dels barris  \n de BCN a l'any 2017",freq = F, col="gold", xlab="Renda per capita", ylim=c(0,1e-04))
lines(density(renda_unif$"2017"),col="red",lwd=2)
curve(dnorm(x,mean=mean(renda_unif$"2017"),sd=sd(renda_unif$"2017")), from=10000,to=35000, 
      add=TRUE, col="blue", lwd=2)

hist(renda_unif$"2018", main="Histograma renda per capita dels barris  \n de BCN a l'any 2018", col="gold", freq = F,xlab="Renda per capita", ylim=c(0,1e-04))
lines(density(renda_unif$"2018"),col="red",lwd=2)
curve(dnorm(x,mean=mean(renda_unif$"2018"),sd=sd(renda_unif$"2018")), from=10000,to=35000, 
      add=TRUE, col="blue", lwd=2)

par(mfrow=c(1,1))


