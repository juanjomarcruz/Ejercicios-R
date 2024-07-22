install.packages('nycflights13')
library(lubridate)

#Fecha de hoy
today()

#Fecha y hora actuales
now()

#Convertir diferentes formatos de fecha en un formato AAAA-MM-DD

ymd('2023-01-31')
ymd(20220102)
mdy('January 31st, 2023')
dmy('31-May-2025')

#crear fechas y horas desde integers
ymd_hms(20201102150524, tz='Europe/Madrid')
dmy_h(2107202320)

#Para saber todas las zonas horarias válidas
OlsonNames()

#Manipulación de zonas horarias
my_date <- now()
my_date
with_tz(my_date, tz= 'Europe/Berlin')
with_tz(my_date, tz= 'US/Hawaii')
with_tz(my_date, tz= 'Asia/Tokyo')

my_date2 <- force_tz(my_date, tz='Singapore')
my_date2
my_date - my_date2

#Crear fechas y horas desde objetos
library(nycflights13)
head(flights)

subset <- flights %>% select(year,month,day,hour,minute) %>% mutate(departure=make_datetime(year,month,day,hour,minute))
subset

#Cambiar de formato
as_datetime(today())
today()
now()
as_date(now())

#Obtener componentes de una fecha-hora
my_date <- ymd_hms('2020-02-11 20:21:01')
my_date
year(my_date)
month(my_date)
day(my_date)
hour(my_date)
minute(my_date)
second(my_date)
tz(my_date)

wday(my_date)
wday(my_date,label=TRUE)
wday(my_date,label=TRUE, abbr=FALSE )
wday(my_date,label=TRUE, abbr=FALSE, week_start = 1)
wday(my_date, week_start = 1)

#Redondear fechas
my_date
round_date(my_date, unit='hour')
round_date(my_date, unit='day')
round_date(my_date, unit='month')
round_date(my_date, unit='year')
ceiling_date(my_date, unit='month') #fuerza el redondeo hacia arriba, hacia el techo (ceiling)
floor_date(my_date, unit='month') #fuerza el redondeo hacia abajo, hacia el suelo (floor)

#Fijar fechas
my_date
year(my_date) <- 2022
my_date
month(my_date) <- 11
my_date
day(my_date) <- 2
my_date

#actualizar fechas
my_date <- update(my_date,year=2023,month=02,mday=1)
my_date

#En R se manejan tres conceptos diferentes cuando hablamos de operaciones con fechas y horas: duraciones, periodos e intervalos.
#Los periodos no tienen en cuenta las posibles irregularidades dentro de un rango de fechas, es decir, no tienen en cuenta
#los años bisiestos, horarios de verano, etc. Por otro lado, las duraciones sí que tienen en cuenta estas irregularidades. Por
#último, los intervalos marcan inicio y fin y sirven para saber si una fecha en concreto cae dentro de un intervalo, etc.

#Duraciones (sí tienen en cuenta irregularidades). Las duraciones siempre van a estar en segundos.

as.duration(today()-ymd(19890211))
dseconds(15)
dminutes(30)
dhours(2)
ddays(1:24)

#Manipular duraciones
today() + ddays(2)
today() + dmonths(2)
today() + dyears(34)

#Periodos (No tienen en cuenta las irregularidades. Digamos que hacen los cálculos como los humanos.)
seconds(7)
minutes(63)
hours(30)

#Manipular periodos
seconds(7)+hours(20)*6

#Duraciones vs periodos
ymd(20200101) + dyears(1)
ymd(20200101) + years(1)

#Intervalos
interval1 <- interval(start = ymd(20230101), end= today())
int_start(interval1)
int_end(interval1)
int_length(interval1) #en segundos
ymd(20220211) %within% interval1
ymd(20230211) %within% interval1
