 - Importamos la maquina de Nginx 2 para hacer Nginx 3.

## Configuracion Nginx
- En la practica Nginx creamos un archivo nuevo llamado conf, donde creare un bloc de notas donde pondre la ruta y un dominio de pruebas.
![Crear Archivo](img/crear%20www.test.png)
- Luego creo el dominio de pruebas. Para acceder a él necesitamos entrar como administrador a C:\Windows\System32\drivers\etc\hosts y añadimos esas dos ultimas lineas, la ruta y el dominio.
![Dominio de pruebas](img/editarhost.PNG)

## Generar un certificado SSL
- Nos descargamos la imagen que genera certificados.
![Descargar generador certificados](img/DescargarStakate.png)
- Creamos certs en nuestra carpeta.
![Certs](img/certs.png)
- Generamos los certificados dentro de certs.
![Generar Certificados](img/dockerrun.png)

## Configuracion
- Ahora que tengo el certificado, le voy a decir a Nginx que use el certificado que he descargado.
- Nos volvemos al .conf que habia creado, y lo configuro añadiendole las rutas creadas dentro del contenedor.
![](img/Editarbloc.png)
- Levantamos el Docker para ver si funciona.
![](img/levantardocker.png)
- Lo ejecutamos en local para asegurarnos http://juanma-davids.test:8080
![](img/correcto.png)
