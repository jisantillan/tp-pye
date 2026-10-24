# ===============================================================
# ACTIVIDAD 4: Repetir el experimento
# ===============================================================

# Cargamos las funciones de las cinco estrategias.
source("actividad_2.r")

# Parámetros del experimento
n <- 100
C <- 50
m <- 64
nRep <- 10000

# Fijamos una semilla para poder repetir los mismos resultados.
set.seed(123)

# Guardamos las funciones de las estrategias en una lista.
estrategias <- list(
  estrategia_1,
  estrategia_2_opcion1,
  estrategia_2_opcion2,
  estrategia_3_opcion1,
  estrategia_3_opcion2
)

nombres <- c(
  "Estrategia 1",
  "Estrategia 2 - Opcion 1",
  "Estrategia 2 - Opcion 2",
  "Estrategia 3 - Opcion 1",
  "Estrategia 3 - Opcion 2"
)

# Creamos una lista vacía donde guardaremos los resultados.
resultados <- list()

# Repetimos 10.000 días para cada estrategia.
for (i in 1:length(estrategias)) {
  resultados[[i]] <- list()

  for (dia in 1:nRep) {
    resultados[[i]][[dia]] <- estrategias[[i]](C, m, n)
  }
}

# Creamos vectores para guardar las métricas de cada estrategia.
ganancia_promedio <- numeric(length(estrategias))
proporcion_ganadora <- numeric(length(estrategias))
proporcion_perdedora <- numeric(length(estrategias))
proporcion_capital_cero <- numeric(length(estrategias))
apuesta_maxima_promedio <- numeric(length(estrategias))
total_apostado_promedio <- numeric(length(estrategias))
varianza_ganancia <- numeric(length(estrategias))

# Calculamos las métricas recorriendo los días simulados.
for (i in 1:length(estrategias)) {
  ganancias <- numeric(nRep)
  capitales_finales <- numeric(nRep)
  apuestas_maximas <- numeric(nRep)
  totales_apostados <- numeric(nRep)

  for (dia in 1:nRep) {
    sesion <- resultados[[i]][[dia]]

    ganancias[dia] <- sesion$ganancia_neta
    capitales_finales[dia] <- sesion$capital_final

    # Sumamos las apuestas para obtener el total apostado en ese día.
    totales_apostados[dia] <- sum(sesion$apuestas)

    # Si no se hizo ninguna apuesta, el máximo de ese día es cero.
    if (length(sesion$apuestas) == 0) {
      apuestas_maximas[dia] <- 0
    } else {
      apuestas_maximas[dia] <- max(sesion$apuestas)
    }
  }

  ganancia_promedio[i] <- mean(ganancias)
  proporcion_ganadora[i] <- sum(ganancias > 0) / nRep
  proporcion_perdedora[i] <- sum(ganancias < 0) / nRep

  # Consideramos que se perdió todo el capital si el capital final es cero.
  proporcion_capital_cero[i] <- sum(capitales_finales == 0) / nRep

  apuesta_maxima_promedio[i] <- mean(apuestas_maximas)
  total_apostado_promedio[i] <- mean(totales_apostados)
  varianza_ganancia[i] <- var(ganancias)
}

# Armamos una tabla con los resultados.
tabla_resultados <- data.frame(
  Estrategia = nombres,
  Ganancia_promedio = ganancia_promedio,
  Proporcion_dias_ganadores = proporcion_ganadora,
  Proporcion_dias_perdedores = proporcion_perdedora,
  Proporcion_capital_cero = proporcion_capital_cero,
  Apuesta_maxima_promedio = apuesta_maxima_promedio,
  Total_apostado_promedio = total_apostado_promedio,
  Varianza_ganancia = varianza_ganancia
)

cat("Resultados de la Actividad 4, con", nRep, "dias por estrategia:\n")
print(tabla_resultados)

# Dibujamos los histogramas de ganancia neta diaria.
par(mfrow = c(2, 3))
for (i in 1:length(estrategias)) {
  ganancias <- numeric(nRep)

  for (dia in 1:nRep) {
    ganancias[dia] <- resultados[[i]][[dia]]$ganancia_neta
  }

  hist(
    ganancias,
    main = nombres[i],
    xlab = "Ganancia neta diaria (fichas)",
    ylab = "Frecuencia",
    col = "lightblue"
  )
}

# Dibujamos los histogramas del total apostado por día.
par(mfrow = c(2, 3))
for (i in 1:length(estrategias)) {
  totales_apostados <- numeric(nRep)

  for (dia in 1:nRep) {
    totales_apostados[dia] <- sum(resultados[[i]][[dia]]$apuestas)
  }

  hist(
    totales_apostados,
    main = nombres[i],
    xlab = "Total apostado por dia (fichas)",
    ylab = "Frecuencia",
    col = "wheat"
  )
}

# Dejamos la ventana de gráficos en su distribución normal.
par(mfrow = c(1, 1))
