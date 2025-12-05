 - Importamos la maquina de Nginx 2 para hacer Nginx 3.

## Acceso seguro Nginx 

### Prerequisitos 
 - Tenemos que modificar el archivo sites-available y añadir en el name server esto:
![Añadir www](assets/img/wwwjuanma.png)
 - lo reiniciamos y comprobamos que no tenga ningun error de sintaxis con el comando sudo nginx -t

### Configuración de cortafuegos 
- lo intalamos la aplicacion ufw y comprobamos una vez se intale si está activo y los perfiles que tiene activos.
![Descargamos UFW y miramos status](assets/img/UFWdescargaStatus.png)
- Vemos que esta inactivo, así que vamos a activar los perfiles para permitir el trafico de https
![Descargamos UFW y miramos status](assets/img/ActivamosUFW.png)
comprobamos ahora el status de nuevo y vemos si esta activo.
![Status Activo](assets/img/StatusActivo.png)

### Certificado autofirmado
 - Necesitamos crear una clave ssl y el certificado usamos el comando openssl. como es una sentencia larga para dividierlo en varias linea se utiliza "\"
   - comando utilizado 
        sudo openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 -keyout /etc/ssl/private/juanma-davids.test.key \
        -out /etc/ssl/certs/juanma-davids.test.crt
- y respondemos a las preguntas que nos hacer, como country etc...
![Crear SSL](assets/img/CrearSSL.png)
- Ahora configuramos el ssl, ahora vamos a nuestro sitio, (sites-available) y añadimos lo siguiente
![SSL añadimos a sites-avalilable](assets/img/SSLsites-available.png)
 - comprobamos que esta todo ok y reiniciamos el servicios
 ![Comprobar y reiniciar ssl](assets/img/comprobarssl.png)
 - y por ultimo comprobar su funcionamiento en web.
   -  He cometido un error por lo cual no me funciona, lo que se me ha olvidado es poner en el sites-available el listen 443 ssl;
    ![Añadir listen](assets/img/añadirlisten.png) 
 ![Comprobar WEB](assets/img/pruebaweb.png) 
si le damos a avanzado y continuar con la pagina ya nos dejaria entrar.
 ![Ya sirve](assets/img/yasirve.png) 



## Configuracion Nginx
- En la practica Nginx creamos un archivo nuevo llamado conf, donde creare un bloc de notas donde pondre la ruta y un dominio de pruebas.

![Crear Archivo](assets/img/crear%20www.test.png)
- Luego creo el dominio de pruebas. Para acceder a él necesitamos entrar como administrador a C:\Windows\System32\drivers\etc\hosts y añadimos esas dos ultimas lineas, la ruta y el dominio.
![Dominio de pruebas](assets/img/editarhost.PNG)

## Generar un certificado SSL
- Nos descargamos la imagen que genera certificados.
![Descargar generador certificados](assets/img/DescargarStakate.png)
- Creamos certs en nuestra carpeta.


![Certs](assets/img/certs.png)
- Generamos los certificados dentro de certs.
![Generar Certificados](assets/img/dockerrun.png)

## Configuracion
- Ahora que tengo el certificado, le voy a decir a Nginx que use el certificado que he descargado.
- Nos volvemos al .conf que habia creado, y lo configuro añadiendole las rutas creadas dentro del contenedor.
![Editar .test.conf](assets/img/Editarbloc.png)
- Levantamos el Docker para ver si funciona.
![Levantar Docker](assets/img/levantardocker.png)

- Lo ejecutamos en local para asegurarnos http://juanma-davids.test:8080
![Ver si funciona](assets/img/correcto.png)

## Mapeo de puertos y montaje de volumen de certificados
- Cambiamos los puertos
![Cambio de puertos](assets/img/Mapeo.png)

## Docker Compose
- En vez de iniciar con Docker Run, lo hariamos con Docker Compose. Creamos Docker Compose en bloc de notas y añadimos los puertos y los volumenes.
![crear docker compose](assets/img/creardockercompose.png)
- Levantamos con docker compose
![Compose Up](assets/img/composeup.png)

- Compruebo con HTTP
![HTTP](assets/img/HTTP.png)
- Y compruebo con HTTPS, nos saldra que es privada, asi que e daremos a Avanzado, y luego entraremos, significa que funciona correctamente.

![Privada](assets/img/privada.png)
![HTTPS](assets/img/HTTPS.png)