# ===============================================================
# ACTIVIDAD 1: Simular una tirada de ruleta
# ===============================================================

# Función que simula una tirada de ruleta
# Devuelve: "rojo", "negro" o "cero"
tirada_ruleta <- function() {
  # La ruleta tiene 37 resultados: 18 rojos, 18 negros, 1 cero
  # Probabilidades: 18/37 rojo, 18/37 negro, 1/37 cero
  sample(c("rojo", "negro", "cero"), size = 1, prob = c(18/37, 18/37, 1/37))
}

# Prueba de la función
set.seed(123)

# Simulación de 10.000 tiradas para verificar probabilidades
n_rep <- 10000
tiradas_prueba <- replicate(n_rep, tirada_ruleta())

# Frecuencias relativas observadas
proporciones <- table(tiradas_prueba) / n_rep
print(proporciones)

# Probabilidades teóricas: rojo≈0.4865, negro≈0.4865, cero≈0.0270
