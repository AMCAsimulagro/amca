# Guía de actualización a Java 21 (JDK 21)

Este proyecto usa Gradle y Android Gradle Plugin. La herramienta automática de Copilot para generar un plan no está disponible en tu plan actual, así que aquí están los pasos manuales recomendados para actualizar el proyecto a Java 21.

Requisitos
- JDK 21 (Eclipse Temurin / Adoptium, Azul, Oracle, etc.) instalado en tu máquina.
- Gradle wrapper actualizado (la versión actual es 8.10.2, que soporta Java 21 internamente).

Pasos sugeridos
1. Instala JDK 21 y apunta JAVA_HOME a ese JDK:

   En PowerShell (ejemplo):

   $env:JAVA_HOME = 'C:\\Program Files\\Eclipse Adoptium\\jdk-21'
   $env:PATH = "$env:JAVA_HOME\\bin;${env:PATH}"

2. Alternativamente, configura `android/gradle.properties` añadiendo:

   org.gradle.java.home=C:\\Program Files\\Eclipse Adoptium\\jdk-21

3. Ejecuta el build con Gradle wrapper:

   ./gradlew.bat clean assembleDebug

4. Si aparecen errores relacionados con el Android Gradle Plugin (AGP), revisa la versión en `android/build.gradle`.
   - AGP 8.3.2 debería ser compatible con Java 21, pero si logras errores, considera actualizar AGP y Gradle a versiones compatibles.

5. Ejecuta tests y corrige problemas de compilación.

Notas
- Si necesitas asistencia para instalar JDK 21 automáticamente, puedo generar un script de instalación, pero la descarga e instalación requieren permisos de administrador en Windows.
- Después de que el build funcione con JDK 21, crea una rama y un PR con los cambios: actualización de documentación, `gradle.properties` si añadiste `org.gradle.java.home`, y pruebas.

Checklist mínimo
- [ ] JDK 21 instalado y accesible
- [ ] Build exitoso con Gradle wrapper usando JDK 21
- [ ] Tests ejecutados
- [ ] PR creado con instrucciones y cambios
