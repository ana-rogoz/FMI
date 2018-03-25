# Import MASS si dataseturile painters si faithful.
library(MASS)
data(painters)
data(faithful)

# a) Afisez dataset-urile.
painters
faithful

# b) Determin frecventele apoi distributia lor. 
frecventa_School = table(painters$School)
t1 = as.data.frame(frecventa_School)
names(t1)[1] = 'School'
t1
plot(density(t1$Freq), main="Frecventa scolilor de pictura")

frecventa_eruptions = table(faithful$eruptions)
t2 = as.data.frame(frecventa_eruptions)
names(t2)[1] = 'eruptions'
t2
plot(density(t2$Freq), main="Frecventa duratelor de eruptie")

# c) Reprezint grafic prin cate doua metode distince informatiile din cele doua dataseturi.
hist(painters$Composition, main="Histrograma Composition")
hist(painters$Drawing, main="Histrograma Drawing")
pie(t1$Freq, labels=t1$School, main="Pie chart scoli de pictura") # Ilustrez scolile intr-un pie chart cu ajutorul frecventelor deja calculate.

hist(faithful$eruptions, main="Histrograma durata de eruptie")
hist(faithful$waiting, main="Histrograma durata de asteptare")

# d) Determin media, mediana, varianta si cuartilele duratelor de erupţie si realizez diagrama boxplot.
mean(faithful$eruptions)
median(faithful$eruptions)
var(faithful$eruptions)
quantile(faithful$eruptions)
boxplot(faithful$eruptions, horizontal = TRUE)

# e) Determin coeficientul de corelatie pentru cele doua variabile din datasetul faithful.
cor(faithful$eruptions, faithful$waiting)
