library(ISLR)
data(Auto)

# Construim un vector pentru fiecare coloana din Auto.
mpg<-c(Auto$mpg)
cylinders<-c(Auto$cylinders)
displacement<-c(Auto$displacement)
horsepower<-c(Auto$horsepower)
weight<-c(Auto$weight)
acceleration<-c(Auto$acceleration)
year<-c(Auto$year)
origin<-c(Auto$origin)

# Observam corelatia dintre fiecare pereche de doua coloane din Auto.
cor(mpg, cylinders)
cor(mpg, displacement)
cor(mpg, horsepower)
cor(mpg, weight)
cor(mpg, acceleration)
cor(mpg, year)
cor(mpg, origin)

cor(cylinders, displacement) # 0.95 corelatie din maximul posibil 1 - Cea mai buna corelatie
cor(cylinders, horsepower)
cor(cylinders, weight)
cor(cylinders, acceleration)
cor(cylinders, year)
cor(cylinders, origin)

cor(displacement, horsepower)
cor(displacement, weight)
cor(displacement, acceleration)
cor(displacement, year)
cor(displacement, origin)

cor(horsepower, weight)
cor(horsepower, acceleration)
cor(horsepower, year)
cor(horsepower, origin)

cor(weight, acceleration)
cor(weight, year)
cor(weight, origin)

cor(acceleration, year)
cor(acceleration, origin)

cor(year, origin)

# Cea mai mare corelatie am obtinut-o pentru cylinders-displacement - aprox. 0.95
plot(cylinders, displacement)

# Aflam parametrii dreptei de regresie liniara simpla. 
mean_cylinders<-mean(cylinders)
mean_displacement<-mean(displacement)

sum_cylinders<-sum((cylinders - mean_cylinders)^2)
sum_produs<-sum((cylinders - mean_cylinders)*(displacement - mean_displacement))

beta<-sum_produs/sum_cylinders
alfa<-mean_displacement-beta*mean_cylinders

plot(cylinders, displacement)
abline(alfa, beta)

# Calculam intr-un vector valorile prezise de model pentru toate valorile din cylinders.
displacement_prezis<-0
nr_cylinders <-length(cylinders)
for(i in 1:nr_cylinders) 
  displacement_prezis[i] = alfa + beta*cylinders[i];
  
# Observam cat de bine se potriveste regresia liniara pentru datele date
# calculand coeficientul de determinare sau R^2 
# R^2 = raportul dintre dispersia valorilor prezise si dispersia valorilor propriu-zise
dispersie_valori_prezise = sum((displacement_prezis - mean_displacement)^2)
dispersie_valori_date = sum((displacement - mean_displacement)^2)
r<-dispersie_valori_prezise/dispersie_valori_date

# Valoarea lui r este 0.90 deci valorile prezise sunt foarte apropiate de valorilor date.
# r puteam lua valori intre 0 si 1, 0 indicand ca modelul de regresie nu potriveste deloc
# datele prezise cu cele date, iar 1 indicand o potrivire perfecta. 


