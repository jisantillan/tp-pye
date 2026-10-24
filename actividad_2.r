# ===============================================================
# ACTIVIDAD 2: Programar las estrategias
# ===============================================================

source("actividad_1.r")

# ===============================================================
# ESTRATEGIA 1: Apuesta fija
# ===============================================================
estrategia_1 <- function(capital_inicial, apuesta_maxima, n_tiradas_dia) {
  capital <- capital_inicial
  apuestas <- c()
  
  for (i in 1:n_tiradas_dia) {
    if (capital < 1) {
      break # Sin capital suficiente para apostar 1 ficha
    }
    
    apuesta <- 1
    apuestas <- c(apuestas, apuesta)
    resultado <- tirada_ruleta()
    
    if (resultado == "rojo") {
      capital <- capital + apuesta
    } else {
      capital <- capital - apuesta
    }
  }
  
  return(list(
    capital_final = capital,
    ganancia_neta = capital - capital_inicial,
    apuestas = apuestas
  ))
}

# ===============================================================
# ESTRATEGIA 2 - Opción 1: Duplicación con límite (Termina si supera m)
# ===============================================================
estrategia_2_opcion1 <- function(capital_inicial, apuesta_maxima, n_tiradas_dia) {
  capital <- capital_inicial
  apuesta_actual <- 1
  apuestas <- c()
  
  for (i in 1:n_tiradas_dia) {
    # Si la apuesta excede el límite m o el capital disponible, termina el día
    if (apuesta_actual > apuesta_maxima || capital < apuesta_actual) {
      break
    }
    
    apuestas <- c(apuestas, apuesta_actual)
    resultado <- tirada_ruleta()
    
    if (resultado == "rojo") {
      capital <- capital + apuesta_actual
      apuesta_actual <- 1  # Reinicia a 1 al ganar
    } else {
      capital <- capital - apuesta_actual
      apuesta_actual <- apuesta_actual * 2  # Duplica al perder
    }
  }
  
  return(list(
    capital_final = capital,
    ganancia_neta = capital - capital_inicial,
    apuestas = apuestas
  ))
}

# ===============================================================
# ESTRATEGIA 2 - Opción 2: Duplicación con límite (Reinicia a 1 si supera m)
# ===============================================================
estrategia_2_opcion2 <- function(capital_inicial, apuesta_maxima, n_tiradas_dia) {
  capital <- capital_inicial
  apuesta_actual <- 1
  apuestas <- c()
  
  for (i in 1:n_tiradas_dia) {
    # Si la apuesta deseada supera el límite m, vuelve a empezar con 1 ficha
    if (apuesta_actual > apuesta_maxima) {
      apuesta_actual <- 1
    }
    
    # Si el capital no alcanza para la apuesta calculada, termina el día
    if (capital < apuesta_actual) {
      break
    }
    
    apuestas <- c(apuestas, apuesta_actual)
    resultado <- tirada_ruleta()
    
    if (resultado == "rojo") {
      capital <- capital + apuesta_actual
      apuesta_actual <- 1  # Reinicia a 1 al ganar
    } else {
      capital <- capital - apuesta_actual
      apuesta_actual <- apuesta_actual * 2  # Duplica al perder
    }
  }
  
  return(list(
    capital_final = capital,
    ganancia_neta = capital - capital_inicial,
    apuestas = apuestas
  ))
}

# ===============================================================
# ESTRATEGIA 3 - Opción 1: Ciclo dinámico (Termina si tacha la lista)
# ===============================================================
estrategia_3_opcion1 <- function(capital_inicial, apuesta_maxima, n_tiradas_dia) {
  capital <- capital_inicial
  lista <- c(1, 2, 1, 2, 1, 2, 1)
  apuestas <- c()
  tiradas <- 0
  
  while (length(lista) > 0 && tiradas < n_tiradas_dia) {
    # Calcular apuesta según longitud de la lista
    if (length(lista) >= 2) {
      apuesta <- lista[1] + lista[length(lista)]
    } else {
      apuesta <- lista[1]
    }
    
    # Verificar límites de capital y apuesta máxima
    if (apuesta > apuesta_maxima || capital < apuesta) {
      break
    }
    
    apuestas <- c(apuestas, apuesta)
    tiradas <- tiradas + 1
    resultado <- tirada_ruleta()
    
    if (resultado == "rojo") {
      capital <- capital + apuesta
      if (length(lista) >= 2) {
        lista <- lista[2:(length(lista) - 1)] # Eliminar extremos
      } else {
        lista <- c() # Tachó el último elemento, termina el ciclo
      }
    } else {
      capital <- capital - apuesta
      lista <- c(lista, apuesta) # Agregar la pérdida al final
    }
  }
  
  return(list(
    capital_final = capital,
    ganancia_neta = capital - capital_inicial,
    apuestas = apuestas
  ))
}

# ===============================================================
# ESTRATEGIA 3 - Opción 2: Ciclo dinámico (Reinicia lista si la tacha)
# ===============================================================
estrategia_3_opcion2 <- function(capital_inicial, apuesta_maxima, n_tiradas_dia) {
  capital <- capital_inicial
  lista_inicial <- c(1, 2, 1, 2, 1, 2, 1)
  lista <- lista_inicial
  apuestas <- c()
  tiradas <- 0
  
  while (tiradas < n_tiradas_dia) {
    # Si la lista quedó vacía en el giro anterior, reinicia a la lista inicial
    if (length(lista) == 0) {
      lista <- lista_inicial
    }
    
    # Calcular apuesta
    if (length(lista) >= 2) {
      apuesta <- lista[1] + lista[length(lista)]
    } else {
      apuesta <- lista[1]
    }
    
    # Verificar límites de capital y apuesta máxima
    if (apuesta > apuesta_maxima || capital < apuesta) {
      break
    }
    
    apuestas <- c(apuestas, apuesta)
    tiradas <- tiradas + 1
    resultado <- tirada_ruleta()
    
    if (resultado == "rojo") {
      capital <- capital + apuesta
      if (length(lista) >= 2) {
        lista <- lista[2:(length(lista) - 1)]
      } else {
        lista <- c() # Lista completada; se reiniciará al inicio del próximo ciclo
      }
    } else {
      capital <- capital - apuesta
      lista <- c(lista, apuesta)
    }
  }
  
  return(list(
    capital_final = capital,
    ganancia_neta = capital - capital_inicial,
    apuestas = apuestas
  ))
}
# ===============================================================
# PRUEBAS ACTIVIDAD 2
# ===============================================================

set.seed(123)

C_prueba <- 50
m_prueba <- 16
n_prueba <- 20

cat("PRUEBAS ACTIVIDAD 2\n\n")

# Estrategia 1
res1 <- estrategia_1(C_prueba, m_prueba, n_prueba)
cat("Estrategia 1:\n")
cat("Apuestas:", paste(res1$apuestas, collapse = ", "), "\n")
cat("Capital final:", res1$capital_final, "\n\n")

# Estrategia 2 - Opción 1
res2_1 <- estrategia_2_opcion1(C_prueba, m_prueba, n_prueba)
cat("Estrategia 2 - Opcion 1:\n")
cat("Apuestas:", paste(res2_1$apuestas, collapse = ", "), "\n")
cat("Capital final:", res2_1$capital_final, "\n\n")

# Estrategia 2 - Opción 2
res2_2 <- estrategia_2_opcion2(C_prueba, m_prueba, n_prueba)
cat("Estrategia 2 - Opcion 2:\n")
cat("Apuestas:", paste(res2_2$apuestas, collapse = ", "), "\n")
cat("Capital final:", res2_2$capital_final, "\n\n")

# Estrategia 3 - Opción 1
res3_1 <- estrategia_3_opcion1(C_prueba, m_prueba, n_prueba)
cat("Estrategia 3 - Opcion 1:\n")
cat("Apuestas:", paste(res3_1$apuestas, collapse = ", "), "\n")
cat("Capital final:", res3_1$capital_final, "\n\n")

# Estrategia 3 - Opción 2
res3_2 <- estrategia_3_opcion2(C_prueba, m_prueba, n_prueba)
cat("Estrategia 3 - Opcion 2:\n")
cat("Apuestas:", paste(res3_2$apuestas, collapse = ", "), "\n")
cat("Capital final:", res3_2$capital_final, "\n")