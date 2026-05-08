# Requerimientos de Base de Datos - Módulo Avícola (Huevos)

Este documento detalla la estructura exacta que debe tener la colección nueva asociada a la ruta “Avícola → Huevos”. Debe implementarse en Firestore (Cloud Firestore) siguiendo la convención actual del proyecto: colecciones principales por entidad, subcolecciones cuando corresponde, y campos tipados con nombres predecibles. A continuación se describe cada colección/documento junto a ejemplos en formato JSON y recomendaciones de validación (longitudes máximas y tipos).

---

## 1. Colección: `laying_galpons`
- **Descripción:** almacena cada galpón de gallinas ponedoras. Es la entidad raíz que debe mostrarse en la lista de galpones.
- **Reglas generales:** cada documento debe llevar `userId` del dueño (referencia al UID de Firebase Auth), `creationDate` y `updatedDate` (timestamps UTC `firestore.FieldValue.serverTimestamp()`).

### Campos esperados
| Campo | Tipo | Descripción | Ejemplo | Tamaño máximo / validación |
| :--- | :--- | :--- | :--- | :--- |
| `name` | STRING | Nombre del galpón (p.ej. "Galpón 5") | "Galpón Ponedoras" | 80 caracteres | 
| `userId` | STRING | UID del usuario que creó el galpón | "user_abc123" | Igual a Auth UID | 
| `startDate` | TIMESTAMP | Inicio del ciclo | `2026-05-06T00:00:00Z` | No futuro absoluto > hoy | 
| `populationInitial` | INTEGER | Aves iniciales | 2500 | > 0 | 
| `state` | STRING | `activo` o `finalizado` | "activo" | `enum` limitado | 
| `createdAt` | TIMESTAMP | Fecha de creación (server) | `FieldValue.serverTimestamp()` | Automático | 
| `updatedAt` | TIMESTAMP | Fecha de última modificación | `FieldValue.serverTimestamp()` | Automático | 
| `lastMortalityUpdate` | TIMESTAMP | Fecha del último registro de mortalidad | `2026-05-05T00:00:00Z` | Opcional | 
| `closingDocumentId` | STRING | ID del documento de cierre si existe (`documentos_cierre`) | "close_2026_05" | Opcional | 

### Ejemplo JSON de documento
```json
{
  "name": "Galpón de Huevos 01",
  "userId": "user_abc123",
  "startDate": "2026-05-01T00:00:00Z",
  "populationInitial": 2600,
  "state": "activo",
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

---

## 2. Subcolección: `laying_daily_records`
- **Ubicación:** dentro de cada documento en `laying_galpons/{galponId}/laying_daily_records/{recordId}`
- **Descripción:** guarda los registros diarios de operación, producción y mortalidad del galpón.
- **Claves:** `galponId` redundante (por seguridad), `date` como `TIMESTAMP` único por día para evitar duplicados. Mantener índice compuesto `galponId + date` para recuperación rápida.

### Campos por registro
| Campo | Tipo | Descripción | Ejemplo | Observaciones |
| :--- | :--- | :--- | :--- | :--- |
| `galponId` | STRING | ID del galpón padre | "galpon_xyz" | Valida existencia | 
| `date` | TIMESTAMP | Día del registro | `2026-05-06T00:00:00Z` | Normalize a 00:00 UTC | 
| `eggsAAA`, `eggsAA`, `eggsA`, `eggsB`, `eggsC` | INTEGER | Cantidad de huevos por categoría | 25 | >=0 | 
| `brokenEggs` | INTEGER | Huevos rotos (físicos) | 3 | >=0 | 
| `dirtyEggs` | INTEGER | Huevos sucios o descartados | 4 | >=0 | 
| `foodConsumedKg` | DOUBLE | Alimento consumido en el día | 24.5 | >=0, máximo 9999 | 
| `mortality` | INTEGER | Mortalidad del día | 2 | >=0 | 
| `totalProduction` | INTEGER | Campo calculado (sum de grupos) | 120 | Opcional (puede calcularse en backend) | 
| `createdAt`, `updatedAt` | TIMESTAMP | Auditoría | `serverTimestamp` | 

### Ejemplo JSON
```json
{
  "galponId": "galpon_xyz",
  "date": "2026-05-06T00:00:00Z",
  "eggsAAA": 12,
  "eggsAA": 8,
  "eggsA": 15,
  "eggsB": 6,
  "eggsC": 3,
  "brokenEggs": 2,
  "dirtyEggs": 1,
  "foodConsumedKg": 24.5,
  "mortality": 1,
  "createdAt": "serverTimestamp"
}
```

---

## 3. Colección: `laying_closure_documents`
- **Ubicación:** colección separada (por rendimiento/consultas). Se crea solo cuando un galpón pasa a `finalizado`.
- **Descripción:** consolida totales históricos para ese galpón. Se vincula al galpón via `galponId` y se remueve si se reactiva el galpón.

### Campos esperado
| Campo | Tipo | Descripción | Ejemplo | Validaciones |
| :--- | :--- | :--- | :--- | :--- |
| `galponId` | STRING | ID del galpón (FK) | "galpon_xyz" | Referencia a `laying_galpons` | 
| `closingDate` | TIMESTAMP | Fecha de finalización | `2026-05-20T00:00:00Z` | >= último registro diario | 
| `totalProduction` | INTEGER | Suma de todos los `totalProduction` diarios | 1020 | calculado backend | 
| `totalFoodConsumedKg` | DOUBLE | Suma de `foodConsumedKg` | 450.7 | 
| `totalBrokenEggs` | INTEGER | Suma de rotos | 32 | 
| `totalDirtyEggs` | INTEGER | Suma de sucios | 18 | 
| `totalMortality` | INTEGER | Mortalidad acumulada | 90 | 
| `generatedAt` | TIMESTAMP | Momento en que se generó el documento | `serverTimestamp` | 

### Ejemplo JSON
```json
{
  "galponId": "galpon_xyz",
  "closingDate": "2026-05-20T00:00:00Z",
  "totalProduction": 1020,
  "totalFoodConsumedKg": 450.7,
  "totalBrokenEggs": 32,
  "totalDirtyEggs": 18,
  "totalMortality": 90,
  "generatedAt": "serverTimestamp"
}
```

---

## 5. Ejemplo completo de documento con subcolección
Presentamos una estructura completa para que puedas copiar/pegar en Firestore o usar como base en scripts de importación.

```json
// Documento base en `laying_galpons/galpon_xyz`
{
  "name": "Galpón de Huevos 01",
  "userId": "user_abc123",
  "startDate": "2026-05-01T00:00:00Z",
  "populationInitial": 2600,
  "state": "activo",
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp",
  "closingDocumentId": null
}

// Subcolección `laying_daily_records` dentro del documento anterior
{
  "laying_daily_records": [
    {
      "galponId": "galpon_xyz",
      "date": "2026-05-06T00:00:00Z",
      "eggsAAA": 12,
      "eggsAA": 8,
      "eggsA": 15,
      "eggsB": 6,
      "eggsC": 3,
      "brokenEggs": 2,
      "dirtyEggs": 1,
      "foodConsumedKg": 24.5,
      "mortality": 1,
      "totalProduction": 44,
      "createdAt": "serverTimestamp",
      "updatedAt": "serverTimestamp"
    },
    {
      "galponId": "galpon_xyz",
      "date": "2026-05-07T00:00:00Z",
      "eggsAAA": 14,
      "eggsAA": 7,
      "eggsA": 16,
      "eggsB": 5,
      "eggsC": 4,
      "brokenEggs": 1,
      "dirtyEggs": 2,
      "foodConsumedKg": 23.2,
      "mortality": 0,
      "totalProduction": 46,
      "createdAt": "serverTimestamp",
      "updatedAt": "serverTimestamp"
    }
  ]
}

// Documento relacionado en `laying_closure_documents` (cuando el galpón se finalice)
{
  "galponId": "galpon_xyz",
  "closingDate": "2026-05-20T00:00:00Z",
  "totalProduction": 1020,
  "totalFoodConsumedKg": 450.7,
  "totalBrokenEggs": 32,
  "totalDirtyEggs": 18,
  "totalMortality": 90,
  "generatedAt": "serverTimestamp"
}
```

---

## 4. Reglas de sincronización y ejecución
1. **Creación/edición de galpones:** al guardar un galpón en la UI (`LayingGalponListVM`), enviar al repositorio y crear/actualizar el documento en `laying_galpons`. `state` = `activo` por defecto.
2. **Registros diarios:** el formulario de `LayingDailyRecordForm` debe llamar al repositorio para insertar/actualizar registros en `laying_galpons/{id}/laying_daily_records`. Si ya existe un registro con misma `galponId` y `date`, actualizarlo en lugar de duplicar. Mantener `createdAt` y `updatedAt`. Actualizar en dicho momento la fecha y el contador `lastMortalityUpdate`. También recalcular (o almacenar) totales como `totalProduction` para evitar cálculos a cada renderizado. 
3. **Cierre de galpón:** al marcar `state = finalizado` (desde `LayingGalponDetailVM`), llamar a repositorio `finalizeGalpon` que: 
   - Suma todos los registros diarios actuales. 
   - Crea/actualiza el documento en `laying_closure_documents`. 
   - Guarda `closingDocumentId` en el documento principal.
4. **Reversibilidad:** si se reactiva el galpón (`state = activo`), el repositorio debe eliminar el documento relacionado en `laying_closure_documents` y vaciar la referencia `closingDocumentId`. 
5. **Reportes:** un endpoint del backend (o una consulta en la app) puede leer `laying_closure_documents` para comparar `totalProduction`, `totalFoodConsumedKg` y `totalMortality` de galpones finalizados (Sección 4). 

---

## Notas adicionales
- Usa `firestore.FieldValue.serverTimestamp()` para campos `createdAt`, `updatedAt`, `generatedAt`. 
- Cada escritura debe validar que `populationInitial > 0` y que los campos numéricos no sean negativos. 
- Para minimizar costos, evita subcolecciones profundas (solo `laying_daily_records` dentro de `laying_galpons`, el resto es colección plana). 
- Indexa `laying_galpons.state` y `laying_daily_records.date` para filtros rápidos. 
- Implementa reglas de seguridad Firestore para que solo el propietario (`userId`) pueda leer/escribir sus galpones y registros. 

Cuando finalices la implementación, dime para revisar las llamadas a Firestore y avanzar con pruebas de datos reales.
