puffinbill <- read.csv("/Users/Kornel/Desktop/puffinbill.csv")
view(puffinbill)

# Poniewa? regresja logistyczna polega na tym
# ?e dopasowujemy modele w kt?rych mamy jedynki i zera,
# przekodujemy sexcode, jak 1 to female, jak 0 to male, 
# do tego s?u?y funkcja ifelse ?eby wyprodukowa? ten sexcode

sex<- puffinbill$sex
curlen<- puffinbill$curlen
sexcode<- ifelse(sex == "F", 1, 0)

# przedstawiamy wykres z podpisanymi osiami oraz warto?ciami 0-male i 1-female

plot(curlen, jitter(sexcode, 0.15), pch = 19,
     xlab = "Bill length (mm)", ylab = "Sex (0 - male, 1 - female)")
 

# Dopasowujemy generalized linear model (Og?lny model liniowy),
# kt?ry jest modelem regresji liniowej sexcode jest binarn? odpowiedzi? 0 lub 1,
# predyktor jest tutaj ciaglym pojedynczym predyktorem to curlen.
# Mamy do czynienia z dwumianow? zmienn?
# lines() rysuje sigmoidaln? krzyw?, kt?ra zosta?a wpasowana do naszych danych, 
# te dane mog? powsta? tylko jako binarne wyniki (0 albo 1)
# Krzywa jest modelem propabilistycznym, kt?ry jest najbardziej sk?onny do generowania
# estymator?w kt?re zgenerowa?y obserwacje kobiet i m??czyzn/

model <- glm(sexcode~curlen, binomial)     
summary(model)

## Odrzucamy null hypothesis (hipoteze zerow?), poniewa? bill length nie ma wp?ywu na p?e?(sex)
## oraz na 1 i 0, poniewa? prawdopobienstwo uzyskania tej statystyki, je?li hipoteza zerowa
## jest prawdziwa jest naprawd? bardzo ma?a wiec odrzucamy hipotez? zerow?.

xv<- seq(min(curlen), max(curlen), 0.01)
yv<-predict(model,list(curlen=xv),type="response")
lines(xv, yv, col ="red")

# Mo?emy stworzy? bardziej wyrafinowany wykres, kt?ry
# pokazuje cz?sto?? rozmieszczenia obserwacji

install.packages("popbio")
library(popbio)
logi.hist.plot(curlen,sexcode,boxp=FALSE,type="count",col="gray", xlabel ="size")
