# Python flask app CI/CD con Jenkins

Proceso de CI/CD utilizando jenkins en un contenedor de docker para una aplicacion de python utilizando el framework Flask, el resultado esperado es crear una pequeña pagina web que depliegue "Proyecto CI/CD" en pantalla.


## Pasos del pipeline

*Verificar si docker esta instalado en el contenedor*

Se utiliza el comando "docker ps" para verificar que docker este instalado dentro del contenedor y que despliegue en pantalla los contenedores activos

**checkear la estructura del codigo**

Utilizando el modulo pylint se checkea el codigo para ver los errores de estructura y syntax

**Hacer pruebas de unidad**

Utilizando el modulo Unittest incluido con python y el archivo test.py del repositorio, se corren pruebas de unidad.

**Compilar la aplicacion e instalar dependencias**

Utilizando el Dockerfile del repositorio como agente de jenkins, se instalan las dependencias del archivo requirements.txt y se compila el codigo para crear el ejecutable de la aplicacion

**Remover y parar contenedores**

Este paso es para remover el contenedor de la aplicacion si esta siendo utilizado para construir la imagen nueva y hacer el deployment.

**Crear la imagen de docker de la aplicacion**

Con el ejecutable de la aplicacion creado en el paso anterior, usamos el CloudBees Docker Build and Publish plugin para crear la imagen de docker de la aplicacion con mayor facilidad.

**Pushear la aplicacion a dockerhub**

Con la imagen de docker construida en el paso anterior, el CloudBees Docker Build and Publish plugin y las variables definidas al inicio del pipeline, pusheamos la imagen a dockerhub para poder hacer el deployment en el siguiente paso.

**Deployment**

En este paso se despliega la aplicacion al http://localhost:8096/ mapeado a la ip publica de ngrok http://d900-181-194-203-26.ngrok.io para que la aplicacion este disponible al publico


## Jenkins plugins utilizados aparte de la instalacion basica
- Docker pipeline
- CloudBees Docker Build and Publish plugin

## Jenkins credentials necesarios para la integracion
- jenkins-github: credential necesario para la comunicacion entre jenkins y github
- dockerhub: credential necesario para pushear la imagen de la aplicacion a dockerhub para deployment

## Information de puertos
- Instancia de jenkins: http://a0ea-181-194-203-26.ngrok.io -> http://localhost:8080
- Aplicacion desplegada: http://d900-181-194-203-26.ngrok.io -> http://localhost:8096





