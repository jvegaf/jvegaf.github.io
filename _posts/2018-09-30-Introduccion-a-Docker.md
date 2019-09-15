---
layout: post
title: Introducción a Docker
---

Docker es un sistema de virtualización de entornos, que está en auge desde hace unos años. Viene a complementar los antiguos sistemas de virtualización como Virtualbox o VMWare. Se utiliza mucho en la industria del desarrollo web. Aunque tiene muchas ventajas sobre los sistemas tradicionales, yo solo te voy a enumerar las principales ventajas.

Es más ligero que cualquier otra máquina virtual que te puedas montar. Por lo que si vas corto de recursos lo agradecerás.

Tienes más de 100.000 imágenes de sistemas, tecnologías o herramientas que puedes utilizar a tiro de un comando. Desde sistemas operativos Linux (ubuntu, debian, fedora….) a imágenes de php, mysql, apache, Tomcat…. Prácticamente todo lo que necesites para poder recrear una máquina virtual para desarrollar lo tienes en el Docker Hub sin tener que pasar por el aburrido pasó de tener que instalarlo tu descargando la iso de Linux, creando la máquina virtual, instalando el SO, despues instalando los paquetes necesarios y configurandolo todo…. Horas y horas perdidas…

Aqui es tan sencillo como buscar en [http://hub.docker.com](http://hub.docker.com) la tecnologia que necesitas, abrir un terminal, poner un sencillo comando y en cuestión de segundos (depende de tu conexión de internet y del tamaño de la imagen) tienes un contenedor corriendo en tu máquina.

Solo hay para mi una pequeña pega, que para poder usar el docker hub tienes que estar registrado en la web de docker [http://docker.com](http://docker.com) , pero seamos realistas, merece muy mucho la pena perder un par de minutos en registrarse, en comparación de tiempo que te ahorras.

Ahora que ya estamos registrados, vamos al tajo.

 
## INSTALACIÓN DE DOCKER


Para Windows o Mac te descargas el instalador que tienes en el apartado

Products - Docker Desktop

![Docker Web]({{ site.baseurl}}/images/2018-09-30-Introduccion-a-Docker/image5.png)

Para Ubuntu 16.04 o Linux mint sigue estos pasos:

primero, vamos a actualizar la base de datos de paquetes:

``` 
sudo apt-get update
```

Ahora vamos a instalar Docker. Agrega la clave GPG para el repositorio oficial de Docker al sistema:

```
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

Agregamos el repositorio Docker a fuentes APT:

```
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
```

 

Actualizamos la base de datos de paquetes, con los paquetes Docker desde el repositorio recién agregado:

```
sudo apt-get update
```
 
Por último, instalamos Docker:

```
sudo apt-get install -y docker-engine
```


(no intentes aprenderte, con que hagas copy paste en un terminal tienes suficiente ;) )





## MANEJO BASICO DE DOCKER

Para el ejemplo vamos a montar un contenedor que tenga MySQL y PhpMyadmin, que es lo que necesitamos para la asignatura de Bases de Datos.

Primero vamos a docker hub [http://hub.docker.com](http://hub.docker.com) para encontrar una imagen con la que podamos crear el contenedor en nuestra máquina.

Escribimos en el buscador del Hub “mysql phpmyadmin” y ya en el primer resultado encontramos una imagen que nos viene como anillo al dedo.

![Docker hub]({{ site.baseurl}}/images/2018-09-30-Introduccion-a-Docker/image1.png)

Tiene más de 10K pulls, eso significa que lo han descargado más de 10000 veces. Además tiene 45 estrellas, que son similares a las estrellas de github o los likes de cualquier red social.

Hacemos click en Details para leer más acerca de esa imagen.

![Docker hub]({{ site.baseurl}}/images/2018-09-30-Introduccion-a-Docker/image2.png)

Aquí tienes toda la información relevante acerca de la imagen, comprobamos que es justo lo que necesitamos. Un mysql y un phpmyadmin, nada más, aunque esto no es del todo cierto, porque he podido comprobar previamente que también tiene un pequeño linux por debajo, ya que si le atacas por SSH al contenedor, descubres que está ahí, sin hacer ruido. Aunque ese linux nos va a venir bien para descargarnos el script de creación de la base de datos.

Una vez elegida la imagen de la cual vamos a crearnos nuestro contenedor sigamos desde el terminal de nuestra máquina.

Primero de todo tenemos que tener docker arrancado. En windows lo sabemos porque nos lo indica el icono de la barra de tareas. Sino con poner docker en un terminal sabemos si esta corriendo en nuestra máquina, o por el contrario tenemos que arrancarlo.

Lo siguiente es que desde la terminal necesitamos hacer login en docker con nuestro usuario previamente creado. Eso lo logramos con:

 
```Bash
$> docker login
```
 
Nos pedirá usuario y contraseña. Se lo ponemos y nos dira que que se logueado exitosamente.

```
Login success.
```
 
Como lo que necesitamos es arrancar directamente el contenedor con la imagen que hemos seleccionado, sin más, con este simple comando ejecutamos por primera vez el contenedor, obligando a docker a que automáticamente descargue la imagen y arranque el contenedor.

```
docker run -d -p 49160:22 -p 49161:80 -p 49162:3306 wnameless/mysql-phpmyadmin
```

Vemos que tenemos tres puertos el 49160 que está enlazado al puerto 22 que es el de SSH, el 49161 que está enlazado al 80 que es el de HTTP y el 49162 que está enlazado al 3306 que es el de Mysql. Simple sencillo y para toda la familia ! 

Ahora con el contenedor arrancado, podemos atacar por SSH como indica en la información del contenedor
 
```
ssh root@localhost -p 49160

password: admin
```
 
Y tendremos un bonito terminal de SSH a la máquina

![Docker shell]({{ site.baseurl}}/images/2018-09-30-Introduccion-a-Docker/image4.png)

Para listar los contenedores que tienes arrancados en tu maquina, tienes el comando

```
$> docker ps
```

![Docker shell#2]({{ site.baseurl}}/images/2018-09-30-Introduccion-a-Docker/image7.png)

Puedes pararlo con

```
$> docker stop [container ID]
```

Si solo quieres salirte del contenedor sin pararlo puedes hacerlo con la combinación de teclas **CONTROL + P + Q**

Para listar todos los contenedores que tengas en tu maquina aunque estén parados lo hacemos con

```
$> docker ps -a
```

![Docker shell#3]({{ site.baseurl}}/images/2018-09-30-Introduccion-a-Docker/image3.png)

Para volver a arrancar un contenedor que tengamos parado usamos:

```
$> docker start [container id]
``` 

Esto es lo minimo que tienes que conocer de docker para poder empezar a usarlo. Tienes muchas cosas mas, asi que si quieres puedes bucear por internet o usar la ayuda de docker, que la invocas con:

```
$> docker [nombre del comando] --help
``` 

Para cualquier cosa, no tienes más que acercarte a mi sitio, y si puedo ayudarte lo haré encantado.