# Script helper para apuntar temporalmente a un JDK 21 y ejecutar gradle wrapper
param(
    [string]$JdkPath = 'C:\\Program Files\\Eclipse Adoptium\\jdk-21'
)

if (-Not (Test-Path $JdkPath)) {
    Write-Error "No se encontró JDK en la ruta: $JdkPath. Por favor instala JDK 21 o pasa la ruta correcta al script."
    exit 1
}

Write-Host "Usando JDK: $JdkPath"
$env:JAVA_HOME = $JdkPath
$env:PATH = "$JdkPath\\bin;${env:PATH}"

Write-Host "JAVA_HOME=$env:JAVA_HOME"

# Ejecutar gradle wrapper con la JDK 21
Write-Host "Ejecutando: .\\gradlew.bat clean assembleDebug"
& .\gradlew.bat clean assembleDebug

if ($LASTEXITCODE -ne 0) {
    Write-Error "Gradle build falló con código $LASTEXITCODE"
    exit $LASTEXITCODE
}

Write-Host "Build finalizado correctamente."
