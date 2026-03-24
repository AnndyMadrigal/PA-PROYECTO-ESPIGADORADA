CONFIGURACIÓN DE BASE DE DATOS - ESPIGA DORADA

1. Ejecutar el script principal:
   Espiga_DB.sql

2. Ejecutar los ajustes adicionales del proyecto:
   Database/01_base_adjustments.sql

3. Ejecutar datos semilla mínimos:
   Database/02_seed_data.sql

Notas:
- El archivo 01_base_adjustments.sql agrega la columna unit_price a core.products
  y crea el procedimiento almacenado core.RegisterProduct.
- El archivo 02_seed_data.sql inserta categorías, impuestos y configuración inicial
  en caso de que no existan.
- No se incluye como script obligatorio ningún cambio manual de usuarios para pruebas
  (por ejemplo, cambiar roles directamente en core.users).