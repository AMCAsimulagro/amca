# Requerimientos de Base de Datos - Módulo Avícola (Engorde)

Este documento detalla el esquema de base de datos propuesto para el módulo de Gestión de Pollo de Engorde, basado en los requerimientos funcionales.
Se plantea para Firebase (Cloud Firestore), usando **colecciones** y listas embebidas en el documento (sin subcolecciones),
siguiendo el patrón actual del proyecto.

## Colecciones Propuestas

### 1. `poultry_fattening_batches` (Lotes de Engorde / Galpones)
Almacena la información general de un lote de pollos o galpón.

| Campo | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `id` | STRING (UUID) | Identificador único del lote. |
| `uidOwner` | STRING | UID del usuario propietario. |
| `farmName` | STRING | Nombre de la finca o granja. |
| `batchName` | STRING | Nombre o identificador del lote/galpón (Ej: "Lote Enero", "Galpón 1"). |
| `initialQuantity` | INTEGER | Cantidad inicial de aves en el lote. |
| `averageWeight` | DOUBLE | Peso promedio inicial del lote (Kg). |
| `productionStage` | STRING | Etapa de producción (Arranque, Crecimiento, Engorde, Finalización). |
| `breed` | STRING | Raza seleccionada. |
| `customBreed` | STRING | Raza personalizada si `breed` = "Otro" (Opcional). |
| `startDate` | TIMESTAMP | Fecha de inicio del lote (ingreso de los pollitos). |
| `expectedSaleDate` | TIMESTAMP | Fecha estimada de sacrificio/venta (Opcional). |
| `creationDate` | TIMESTAMP | Fecha de creación del registro en el sistema. |
| `tracking` | ARRAY | Lista embebida de registros de seguimiento (ver tabla Tracking). |
| `costsAndExpenses` | ARRAY | Lista embebida de costos y gastos (ver tabla Costos y Gastos). |

### 2. `Tracking` (Seguimiento Semanal - embebido)
Registros periódicos (semanales) embebidos en el documento del lote.

| Campo | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `id` | STRING (UUID) | Identificador único del registro de seguimiento. |
| `recordDate` | TIMESTAMP | Fecha del registro. |
| `weekNumber` | INTEGER | Número de semana del ciclo (1, 2, 3...). |
| `recordType` | STRING | Tipo de registro: `Seguimiento` o `Finalización`. |
| `feedConsumed` | DOUBLE | Cantidad de alimento consumido en el periodo (Kg). |
| `mortality` | INTEGER | Cantidad de aves muertas en el periodo. |
| `finalAverageWeight` | DOUBLE | Peso promedio final (solo si `recordType` = "Finalización"). |
| `notes` | STRING | Observaciones (Opcional). |

### 3. `Costos y Gastos` (embebido)
Registros de costos y gastos embebidos en el documento del lote.

| Campo | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `id` | STRING (UUID) | Identificador único del costo/gasto. |
| `recordDate` | TIMESTAMP | Fecha del registro. |
| `productOrService` | STRING | Producto o servicio. |
| `description` | STRING | Descripción seleccionada. |
| `costOrExpense` | STRING | Indica si es Costo o Gasto. |
| `type` | STRING | Tipo (Variable/Permanente). |
| `quantity` | STRING | Cantidad. |
| `price` | STRING | Valor del registro. |
| `comment` | STRING | Comentario (Opcional). |

### Notas sobre Cálculos (No persistidos necesariamente, calculados en Runtime)
*   **ICA (Índice de Conversión Alimenticia):** `Total Alimento Consumido / Peso Total Vivo`.
*   **Mortalidad Acumulada:** Suma de `mortality` de todos los registros del lote.
*   **Cantidad Actual:** `initialQuantity - Mortalidad Acumulada`.

---
