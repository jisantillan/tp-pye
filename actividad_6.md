# Actividad 6: Conclusiones

Respuestas basadas en las métricas de la Actividad 4 (comparación de las 5
estrategias con $nRep = 10000$ días) y de la Actividad 5 (efecto de la apuesta
máxima $m$ en la Estrategia 2). El marco teórico de referencia es que **toda
apuesta al rojo tiene esperanza negativa**: por cada ficha apostada,
$E = \frac{18}{37} - \frac{19}{37} = -\frac{1}{37} \approx -0.027$. De aquí se
desprende la relación clave $E[\text{ganancia}] \approx -\frac{1}{37} \cdot E[\text{total apostado}]$.

# a) ¿Qué estrategia presenta la mayor ganancia promedio por día?

La *Estrategia 1 (apuesta fija)*. Es la que menos apuesta en total (una ficha
por tirada), y como la ganancia esperada es proporcional al total apostado con
signo negativo, es la que tiene la pérdida media más chica (ganancia promedio
menos negativa). Ninguna estrategia logra ganancia promedio positiva: todas son
negativas, pero la Estrategia 1 es la que queda más cerca de cero.

# b) ¿Qué estrategia presenta la mayor proporción de días en los que se gana?

La *Estrategia 2 (duplicación con límite / martingala)*. Al duplicar la
apuesta tras cada pérdida, recupera lo perdido apenas sale un rojo y suele
cerrar el día con una ganancia neta positiva (del orden de $+1$ ficha). Por eso
*gana seguido*: la mayoría de los días terminan en positivo.

# c) ¿Qué estrategia presenta mayor variabilidad en las ganancias o pérdidas?

La *Estrategia 2 (martingala)*. Su alta varianza proviene de las pérdidas
*catastróficas pero raras*: cuando se encadenan varios negros/cero, la apuesta
crece exponencialmente y se supera la apuesta máxima $m$ o se agota el capital,
produciendo una pérdida grande que dispara la varianza de la ganancia neta
diaria.

# d) ¿La estrategia que gana en una mayor proporción de sesiones es necesariamente la que obtiene la mayor ganancia promedio? Justifique.

*No.* La estrategia que gana en mayor proporción de días es la martingala
(Estrategia 2, ítem b), pero la de mayor ganancia promedio es la apuesta fija
(Estrategia 1, ítem a). La razón es que la martingala acumula muchas ganancias
chicas (+1 ficha) pero, de vez en cuando, sufre una pérdida enorme que arrastra
la *media* hacia abajo. En términos estadísticos: una alta proporción de días
ganados no implica una esperanza mayor, porque la esperanza pondera también la
magnitud de las pérdidas, no solo su frecuencia. **Ganar más seguido no es lo
mismo que ganar más en promedio.**

# e) ¿Los resultados permiten afirmar que una estrategia es siempre mejor que las demás? Explique.

*No.* Todas las estrategias tienen esperanza negativa ($-\frac{1}{37}$ por
ficha apostada), así que *ninguna le gana a la casa a largo plazo*. Lo que
cambia entre ellas es el perfil de riesgo: la Estrategia 1 pierde poco y de
forma estable; la Estrategia 2 gana seguido pero con riesgo de pérdidas
grandes; la Estrategia 3 tiene un comportamiento intermedio. No existe una
estrategia que domine a las demás en todos los criterios simultáneamente
(ganancia media, frecuencia de ganar, variabilidad y riesgo de ruina). La
"mejor" depende de qué se priorice, pero ninguna convierte un juego de
esperanza negativa en uno favorable.

# f) ¿Se observa alguna relación entre la media del total apostado diario y la media de la ganancia neta diaria? ¿Qué relación esperaríamos que se observe?

Sí: una *relación negativa*. Como $E[\text{ganancia}] \approx -\frac{1}{37} \cdot E[\text{total apostado}]$,
cuanto mayor es el total apostado promedio, *más negativa* es la ganancia neta
promedio. Esto es justamente lo que se observa: las estrategias que apuestan más
en total (martingala y ciclo dinámico) muestran ganancias medias más negativas
que la apuesta fija. La Actividad 5 lo confirma dentro de la propia Estrategia 2:
al aumentar la apuesta máxima $m$, se habilita apostar más por día, el total
apostado medio crece, la ganancia media se vuelve más negativa y el riesgo de
ruina aumenta.

# Conclusión general

Las estrategias de duplicación y de ciclo dinámico parecen "infalibles" porque,
sin límites de dinero, de tiradas ni de apuesta máxima, terminarían ganando con
probabilidad 1. Pero en condiciones reales —capital inicial $C=50$, apuesta
máxima $m=64$ y $n=100$ tiradas— esos límites son exactamente los que producen
las pérdidas catastróficas que hunden la ganancia promedio. La simulación de
Montecarlo confirma el resultado teórico: **no hay estrategia que venza la
esperanza negativa de la ruleta.** La mejor estrategia para ganar en el casino
sigue siendo ser el dueño del casino.