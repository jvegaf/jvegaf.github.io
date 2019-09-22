---
layout: post
title: Configuración del entorno de desarrollo con Docker
---

![docker]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image1.png)

Este es mi segundo artículo sobre Docker. Si no conoces Docker te recomiendo que te leas mi [anterior artículo](https://jvegaf.github.io/Introduccion-a-Docker/) sobre el tema.

En este curso necesitamos un entorno tipo LAMP para desarrollar en PHP, asi que, que mejor manera de hacerlo lo mas parecido a como se hace en el mundo laboral a dia de hoy.

Este verano, mientras jugaba un poco con Laravel, encontré un entorno de desarrollo llamado [Laradock](https://laradock.io/).

![laradock]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/laradock.jpg)

La verdad es que es genial, te lo dan todo super guisadito. Puedes elegir entre diferentes servidores web (Apache, Nginx..), también puedes elegir entre diferentes gestores de bases de datos (MySQL, MariaDB, Redis, MSSQL....), todos con sus diferentes versiones. Si en determinado proyecto necesitas la version 5.7 de Mysql, pues lo indicas en el fichero de configuración del entorno y al levantar por primera vez, te descarga el contenedor con esa version. Asi de simple.

Hablando de contenedores, la forma en que se despliega el entorno, es en varios contenedores, usando [docker compose](https://docs.docker.com/compose/). Un poco mas adelante veremos los contenedores que nos ha levantado.

## Desplegando que es gerundio

Doy por hecho que tienes docker en tu máquina. Sino, y tienes linux, con Snappy estas de suerte. Solo con poner

```shell
$>snap install docker
```

tendrias docker instalado en tu máquina.

**DISCLAIMER:** La manera en la que vamos a desplegar seguro que no sera la mejor, pero a dia de hoy es la que me ha funcionado. Si encuentro una mejor, te lo compartiré en otro artículo.

Bueno, vamos al turrón. Lo primero, es crear un directorio en donde vayas a hacer el desarrollo. Y desde dentro de el vamos a clonarnos el proyecto de laradock en Github.

```
https://github.com/Laradock/laradock.git
```

![git clone]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image2.png)

Una vez terminado el clonado, nos metemos dentro de la carpeta laradock y copiamos el fichero de ejemplo env-example a nuestro fichero de configuración que es .env

![config1]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image3.png)

Ahora vamos a editar ese fichero .env con nuestro editor favorito.

Lo primero que vamos a indicarle es el directorio donde vamos a hacer el desarrollo, se lo indicamos en **APP_CODE_PATH_HOST=../**
 en mi caso de ejemplo lo voy a llamar WebApp.

Si estás haciendo el despliegue desde windows te recomiendo que cambies el parametro **COMPOSE_PATH_SEPARATOR=:** y cambies los dos puntos por punto y coma.

![config2]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image4.png)


Lo siguiente que vamos a hacer es cambiar la ip host de docker, en el parametro **DOCKER_HOST_IP=** cambiamos la que viene, por 127.0.0.1, así con poner localhost en el navegador, nos sale la aplicación.

![config2]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image5.png)

En el apartado de MYSQL podemos cambiar tanto la versión de MYSQL como el nombre de la base de datos, el nombre y password del usuario de la base de datos como el password de root. En mi caso, para ir mas rápido lo dejare como está, pero es conveniente cambiarlo.

![config3]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image6.png)

Y en ese fichero ya tendríamos todo listo. Guardamos cambios y seguimos.

Ahora vamos a modificar el fichero my.cnf para cambiar el plugin de autenticación a utilizar. Lo podemos encontrar dentro de el directorio mysql.

Tenemos que agregar al final del archivo lo siguiente

```
default_authentication_plugin=mysql_native_password
```

![config4]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image7.png)

Guardamos cambios y tendríamos lo mínimo para poder empezar a jugar con PHP.

## Levantando por primera vez

Nos posicionamos en en directorio laradock y le decimos a docker compose lo que queremos levantar. En mi caso usare Nginx como servidor web dado que es mas ligero que Apache. También levantaré el contenedor de PhpMyAdmin

```shell
$> sudo docker-compose up -d nginx mysql phpmyadmin
```

![config5]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image8.png)

Ahora, dependiendo de tu conexion a internet y de tu máquina, tardará mas o menos en hacer la magia docker compose. *It's coffee time*

Una vez haya terminado de configurar todo docker, podemos comprobar que esta todo levantado con 

```shell
$> docker-compose ps
```
![config6]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image9.png)

Podemos ver como nos ha levantado un contenedor por cada servicio que le hemos pedido, además del contenedor de workspace que es el orquestador.  -- Benditos contenedores XD --

Lo siguiente que vamos a hacer es meternos dentro del contenedor de mysql para hacer unos cambios.

```shell
$>sudo docker-compose exec mysql bash
```
una vez estemos dentro del bash del contenedor, vamos a proceder con el comando

```shell
$> mysql_secure_installation
```
para configurar el gestor Mysql.

![config7]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image10.png)

Una vez tengamos terminado el script, lo siguiente seria meternos en mysql y poner las siguientes sentencias

```
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
```

```
FLUSH PRIVILEGES;
```

![config8]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image11.png)

Y con esto ya no tenemos que configurar nada mas.


Para detener los contenedores solo necesitamos meter la instrucción (estando posicionados dentro del directorio laradock)

```shell
$>sudo docker-compose down
```
Y veríamos como se detienen todos los contenedores.

![composer down]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image12.png)

En el siguiente artículo os explicaré como instalar laravel con composer desde el workspace que hemos creado.