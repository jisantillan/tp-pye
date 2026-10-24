# ===============================================================
# ACTIVIDAD 3: Comparar las estrategias en una sola sesión
# ===============================================================

source("actividad_1.r")
source("actividad_2.r")

# Parámetros del enunciado
n_param <- 100
C_param <- 50
m_param <- 64

# Semilla fija para reproducibilidad
set.seed(123)

# Ejecutar 1 sesión para cada variante
res1     <- estrategia_1(C_param, m_param, n_param)
res2_op1 <- estrategia_2_opcion1(C_param, m_param, n_param)
res2_op2 <- estrategia_2_opcion2(C_param, m_param, n_param)
res3_op1 <- estrategia_3_opcion1(C_param, m_param, n_param)
res3_op2 <- estrategia_3_opcion2(C_param, m_param, n_param)

# Tabla comparativa con nombres simplificados
tabla_comparativa <- data.frame(
  Estrategia = c("Estrategia 1", 
                 "Estrategia 2 - Opcion 1", 
                 "Estrategia 2 - Opcion 2", 
                 "Estrategia 3 - Opcion 1", 
                 "Estrategia 3 - Opcion 2"),
  Capital_Final = c(res1$capital_final, 
                   res2_op1$capital_final, 
                   res2_op2$capital_final, 
                   res3_op1$capital_final, 
                   res3_op2$capital_final),
  Ganancia_Neta = c(res1$ganancia_neta, 
                   res2_op1$ganancia_neta, 
                   res2_op2$ganancia_neta, 
                   res3_op1$ganancia_neta, 
                   res3_op2$ganancia_neta),
  Tiradas = c(length(res1$apuestas), 
                     length(res2_op1$apuestas), 
                     length(res2_op2$apuestas), 
                     length(res3_op1$apuestas), 
                     length(res3_op2$apuestas))
)

cat("=== RESULTADOS ACTIVIDAD 3 ===\n\n")
print(tabla_comparativa)