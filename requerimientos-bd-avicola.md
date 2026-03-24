# Requerimientos de Base de Datos - Módulo Avícola (Engorde)

Este documento detalla el esquema de base de datos propuesto para el módulo de Gestión de Pollo de Engorde, basado en los requerimientos funcionales.

## Tablas Propuestas

### 1. `PoultryFatteningBatch` (Lotes de Engorde / Galpones)
Almacena la información general de un lote de pollos o galpón.

| Campo | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `id` | STRING (UUID) | Identificador único del lote. |
| `farmName` | STRING | Nombre de la finca o granja. |
| `batchName` | STRING | Nombre o identificador del lote/galpón (Ej: "Lote Enero", "Galpón 1"). |
| `initialQuantity` | INTEGER | Cantidad inicial de aves en el lote. |
| `breed` | STRING | Raza de los pollos (Opcional). |
| `startDate` | TIMESTAMP | Fecha de inicio del lote (ingreso de los pollitos). |
| `expectedSaleDate` | TIMESTAMP | Fecha estimada de sacrificio/venta (Opcional). |
| `creationDate` | TIMESTAMP | Fecha de creación del registro en el sistema. |

### 2. `PoultryFatteningTracking` (Seguimiento Semanal)
Almacena los registros periódicos (semanales) de las "particularidades biológicas" y costos.

| Campo | Tipo de Dato | Descripción |
| :--- | :--- | :--- |
| `id` | STRING (UUID) | Identificador único del registro de seguimiento. |
| `batchId` | STRING (FK) | Relación con la tabla `PoultryFatteningBatch`. |
| `recordDate` | TIMESTAMP | Fecha del registro. |
| `weekNumber` | INTEGER | Número de semana del ciclo (1, 2, 3...). |
| `averageWeight` | DOUBLE | Peso promedio de los pollos en esa semana (Kg/Lb). (Peso general ingresado por el usuario). |
| `feedConsumed` | DOUBLE | Cantidad de alimento consumido en el periodo (Kg/Sacos). |
| `mortality` | INTEGER | Cantidad de aves muertas en el periodo. |
| `waterConsumed` | DOUBLE | Consumo de agua (Opcional). |
| `medicationCost` | DOUBLE | Costo de medicamentos aplicados en el periodo (Opcional). |
| `otherExpenses` | DOUBLE | Otros gastos asociados. |

### Notas sobre Cálculos (No persistidos necesariamente, calculados en Runtime)
*   **ICA (Índice de Conversión Alimenticia):** Se calculará en la aplicación usando: `Total Alimento Consumido / Peso Total Vivo`.
*   **Mortalidad Acumulada:** Suma de `mortality` de todos los registros del lote.
*   **Cantidad Actual:** `initialQuantity - Mortalidad Acumulada`.

---
