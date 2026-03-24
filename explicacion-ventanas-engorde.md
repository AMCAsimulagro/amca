# Explicación de Pantallas - Módulo Engorde Avícola

Este documento describe el flujo de navegación y la estructura de las pantallas para el módulo de Pollo de Engorde.

## Flujo de Navegación

1.  **Menú Principal (Ganadería/Pecuario)** -> Opción **Avícola**.
2.  **Pantalla de Opciones Avícola (`OptionLivestockPoultryPage`)**:
    *   Botón "Huevos" (Pendiente).
    *   Botón "Engorde" -> **Redirecciona a `PoultryFatteningPage`**.

## Descripción de Pantallas

### 1. `PoultryFatteningPage` (Listado de Lotes/Galpones)
*   **Objetivo:** Mostrar una lista de todos los lotes de engorde registrados.
*   **Componentes:**
    *   Barra superior con título "Pollo de Engorde".
    *   Lista de tarjetas (`Card`), cada una representando un lote (Muestra `batchName`, `farmName`, `startDate`).
    *   Botón flotante (`FloatingActionButton`) para agregar un nuevo lote -> Lleva a `CreatePoultryFatteningPage`.
    *   Al hacer clic en una tarjeta -> Lleva a `PoultryFatteningDetailPage`.

### 2. `CreatePoultryFatteningPage` (Creación de Lote)
*   **Objetivo:** Formulario para registrar un nuevo lote o galpón.
*   **Campos:**
    *   **Nombre de la Finca:** Texto libre.
    *   **Nombre del Lote/Galpón:** Texto libre (Ej: "Lote 1").
    *   **Cantidad de Aves:** Numérico.
    *   **Fecha de Inicio:** Selector de fecha.
    *   **Raza:** Texto (Opcional).
*   **Acción:** Botón "Guardar". Al guardar, regresa a la lista.

### 3. `PoultryFatteningDetailPage` (Detalle y Seguimiento)
*   **Objetivo:** Ver la información general del lote y su historial de registros semanales.
*   **Componentes:**
    *   **Cabecera:** Resumen (Nombre, Fecha inicio, Aves actuales estimadas).
    *   **Pestañas (Tabs):**
        *   **Seguimiento:** Lista de registros semanales.
        *   **Gráficas (Futuro):** ICA, Peso vs Semanas.
    *   **Botón "Agregar Registro":** Abre `AddPoultryTrackingPage`.

### 4. `AddPoultryTrackingPage` (Registro Semanal)
*   **Objetivo:** Ingresar los datos de control de una semana específica.
*   **Campos:**
    *   **Fecha:** Selector de fecha (Por defecto hoy).
    *   **Peso Promedio (Kg):** Numérico. (Peso general del lote).
    *   **Alimento Consumido (Kg):** Numérico.
    *   **Mortalidad (Cantidad):** Numérico.
*   **Acción:** Botón "Guardar Registro".

---
