# ===============================================================
# ACTIVIDAD 5: Efecto de la apuesta maxima (m) en la Estrategia 2
# ===============================================================

# Cargamos las estrategias (esto trae tambien actividad_1.r).
source("actividad_2.r")

# Parametros del experimento: mantenemos fijos el capital inicial (C)
# y la cantidad de tiradas por dia (n), y variamos la apuesta maxima m.
C <- 50
n <- 100
nRep <- 10000
valores_m <- c(8, 16, 32, 64)

# Fijamos la semilla DESPUES del source, porque actividad_2.r ejecuta su
# propio bloque de pruebas (que consume numeros aleatorios).
set.seed(123)

# Funcion auxiliar: para una opcion de la Estrategia 2 (1 o 2) y un valor
# de apuesta maxima m, simula nRep dias y devuelve las metricas pedidas.
# La variable aleatoria de interes es la ganancia neta diaria.
# Devolvemos con la ultima expresion (una list).
simular_m <- function(opcion, m) {
  ganancias <- vector(, length = nRep)
  capitales <- vector(, length = nRep)
  apuestas_maximas <- vector(, length = nRep)
  totales_apostados <- vector(, length = nRep)

  for (dia in 1:nRep) {
    # Elegimos la opcion de la estrategia segun el flag.
    if (opcion == 1) {
      sesion <- estrategia_2_opcion1(C, m, n)
    } else {
      sesion <- estrategia_2_opcion2(C, m, n)
    }

    ganancias[dia] <- sesion$ganancia_neta
    capitales[dia] <- sesion$capital_final
    totales_apostados[dia] <- sum(sesion$apuestas)

    # Si no se hizo ninguna apuesta, el maximo de ese dia es cero.
    if (length(sesion$apuestas) == 0) {
      apuestas_maximas[dia] <- 0
    } else {
      apuestas_maximas[dia] <- max(sesion$apuestas)
    }
  }

  list(
    ganancia_promedio = mean(ganancias),
    proporcion_ganadora = sum(ganancias > 0) / nRep,
    proporcion_ruina = sum(capitales == 0) / nRep,
    varianza_ganancia = var(ganancias),
    apuesta_maxima_promedio = mean(apuestas_maximas),
    total_apostado_promedio = mean(totales_apostados)
  )
}

# Funcion que arma la tabla de resultados (matrix + colnames) para una
# opcion de la estrategia, recorriendo los distintos valores de m.
tabla_para_opcion <- function(opcion) {
  ganancia_promedio <- vector(, length = length(valores_m))
  proporcion_ganadora <- vector(, length = length(valores_m))
  proporcion_ruina <- vector(, length = length(valores_m))
  varianza_ganancia <- vector(, length = length(valores_m))
  apuesta_maxima_promedio <- vector(, length = length(valores_m))
  total_apostado_promedio <- vector(, length = length(valores_m))

  for (j in 1:length(valores_m)) {
    res <- simular_m(opcion, valores_m[j])
    ganancia_promedio[j] <- res$ganancia_promedio
    proporcion_ganadora[j] <- res$proporcion_ganadora
    proporcion_ruina[j] <- res$proporcion_ruina
    varianza_ganancia[j] <- res$varianza_ganancia
    apuesta_maxima_promedio[j] <- res$apuesta_maxima_promedio
    total_apostado_promedio[j] <- res$total_apostado_promedio
  }

  # matrix() llena por columnas: cada bloque de length(valores_m) valores
  # arma una columna de la tabla.
  tabla <- matrix(
    c(valores_m, ganancia_promedio, proporcion_ganadora,
      proporcion_ruina, varianza_ganancia, apuesta_maxima_promedio,
      total_apostado_promedio),
    nrow = length(valores_m)
  )
  colnames(tabla) <- c("m", "Ganancia_prom", "Prop_ganadora",
                       "Prop_ruina", "Varianza", "Apuesta_max_prom",
                       "Total_apostado_prom")
  tabla
}

# --- Estrategia 2 - Opcion 1 (termina el dia si la apuesta supera m) ---
print(paste("Actividad 5 - Estrategia 2 Opcion 1 -", nRep, "dias por valor de m:"))
tabla_op1 <- tabla_para_opcion(1)
print(tabla_op1)

# --- Estrategia 2 - Opcion 2 (reinicia a 1 ficha si la apuesta supera m) ---
print(paste("Actividad 5 - Estrategia 2 Opcion 2 -", nRep, "dias por valor de m:"))
tabla_op2 <- tabla_para_opcion(2)
print(tabla_op2)

# --- Graficos: efecto de m sobre la ganancia media y el riesgo de ruina ---
# Azul: Opcion 1. Rojo: Opcion 2.
plot(valores_m, tabla_op1[, "Ganancia_prom"], type = "b", col = "blue",
     main = "Ganancia media vs apuesta maxima m",
     xlab = "Apuesta maxima (m)", ylab = "Ganancia neta media")
points(valores_m, tabla_op2[, "Ganancia_prom"], type = "b", col = "red")

plot(valores_m, tabla_op1[, "Prop_ruina"], type = "b", col = "blue",
     main = "Proporcion de ruina vs apuesta maxima m",
     xlab = "Apuesta maxima (m)", ylab = "Proporcion de dias con ruina")
points(valores_m, tabla_op2[, "Prop_ruina"], type = "b", col = "red")