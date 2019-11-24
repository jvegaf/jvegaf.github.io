---
layout: post
title: Entorno minino PHP
---

![php]({{ site.baseurl}}/images/2019-11-24-entorno-minimo-php/img_2.png)

¡¡¡ Por fin !!! El dia que tanto anhelabamos, en el que ibamos a introducirnos en la caja de pandora que es el mundo de PHP ha llegado. Españoles, nuestro periplo por JSP ha muerto. Larga vida a PHP !!!!.


Bueno, ahora despues de hacer las coñas correspondientes, vamos al turrón. Para comenzar a deleitar nuestros paladares con simbolos de dolar y arrays asociativos a cascoporro, necesitamos un entorno de desarrollo mínimo con el que poder empezar. En el anterior artículo os presentaba la [Configuración del entorno de desarrollo con Docker](https://jvegaf.github.io/entorno-desarrollo-con-docker/), pero creo que tiene demasiadas cosas para comenzar a dar un primer vistazo al mundo PHP.

Así que me puse a pensar un poco en el tema este fin de semana, y he llegado a la siguiente conclusión, necesitamos un **servidor web ligero**, el interprete de php y xdebug para depurar. Creo que con eso podemos ir tirando, hasta que lleguemos al maravilloso mundo de los frameworks, en el que, entonces si cobra todo el sentido del mundo realizar la [Configuración del entorno de desarrollo con Docker](https://jvegaf.github.io/entorno-desarrollo-con-docker/).

Mis elecciones para crear este mini entorno de desarrollo con PHP es:

[NGINX](https://www.nginx.com/) como servidor web ligero
[PHP 7.2](https://www.php.net/) como version del interprete de PHP.


## Vale, y ahora como montamos el tinglao.

![docker]({{ site.baseurl}}/images/2019-09-22-entorno-desarrollo-con-docker/image1.png)

Despues de mucho dilucidar, he llegado a la conclusión, de que podriamos darle una nueva oportunidad a docker. A pesar de que con tomcat y JSP no me ha ido todo lo fino que me hubiera gustado, me ha servido para aprender bastante mas sobre como funcionar docker. Tambien he aprendido a usar los volumenes, que no es mas ni menos, que asignarle a tu contenedor una carpeta local en la que tu tienes tu proyecto y enlazarla con una ruta dentro de tu contenedor. Asi de simple. Pues bien, esta vez, tendremos volumenes.

![minions]({{ site.baseurl}}/images/2019-11-24-entorno-minimo-php/minions.gif)

Buceando un poco por Github, he dado con un [proyecto](https://github.com/ionut-botizan/docker-nginx-php-xdebug) que justo tiene lo que necesitamos. Asi que me lo he *forkeado* para terminar de refinarlo un poco. Podeis encontrarlo, clonarlo y/o *forkearlo* en [mi Github](https://github.com/jvegaf/docker-nginx-php-xdebug)

## al ataque !

lo primero que necesitamos es abrir un terminal y posicionarnos en el directorio que hayamos elegido para trabajar. Una vez estemos en el directorio, tenemos que clonarnos el proyecto, con:

´´´shell
  $> git clone https://github.com/jvegaf/docker-nginx-php-xdebug.git
´´´

![clonado]({{ site.baseurl}}/images/2019-11-24-entorno-minimo-php/img_1.png)

Cuando termine de clonarse el proyecto, nos posicionamos dentro de la carpeta **docker-nginx-php-xdebug** y descubrimos que tenemos un fichero Dockerfile en el cual tenemos lo siguiente

´´´
FROM php:7.2-fpm 

RUN pecl install xdebug-2.6.0RC2 && docker-php-ext-enable xdebug

´´

en el FROM le indicamos la imagen base que queremos tener del interprete de PHP. Una vez descargada la imagen del repo de dockerhub, ejecutaremos las instrucciones que vengan en RUN, que es instalar los paquetes necesarios de XDEBUG. Simple y sencillo como el mecanismo de un botijo.

## docker-compose es tu amigo

y vamos a ver que tiene dentro

´´´
version: "2"

services:
    web:
        image: nginx:latest
        ports:
            - "8100:80"
        volumes:
            - ./apps/default:/apps/default
            - ./logs/nginx:/logs/nginx
            - ./config/nginx/xdebug:/etc/nginx/xdebug
            - ./config/nginx/hosts:/etc/nginx/hosts
            - ./config/nginx/init.conf:/etc/nginx/conf.d/default.conf
        networks:
            - php-network
    php:
        build:
            dockerfile: Dockerfile
            context: ./
        volumes:
            - ./apps/default:/apps/default
            - ./logs/xdebug:/logs/xdebug
            - ./config/php/custom.conf:/usr/local/etc/php-fpm.d/zz-custom.conf
            - ./config/php/xdebug.ini:/usr/local/etc/php/conf.d/zz-xdebug.ini
            - ./logs/php-fpm/:/tmp/xdebug_log
        networks:
            - php-network

networks:
    php-network:
        driver: bridge
´´´

Bien, vayamos por partes como dijo *Jack the ripper*. Vemos que queremos levantar dos servicios, uno llamado web que tiene un nginx en el cual he re-mapeado el puerto de salida por el 8100 dado que si tenemos el puerto 80 ocupado por algun apache en nuestra maquina, podemos dejarle que siga escuchando en ese puerto y nuestro nginx puede escuchar perfectamente en otro lado.

Ahora viene la chichita.

## the volumes aka "los volumenes"

Aqui enlazamos directorios nuestros locales con rutas dentro de "este, nuestro contenedor".

Por ejemplo el contenido de nuestro directorio apps/default que esta dentro de nuestro proyecto, estara enlazado a la ruta apps/default, estan sacados tambien tanto los logs de nginx como las rutas de configuracion de nginx.

Lo que ahora parece un paseo militar, me ha llevado unos cuantos quebraderos de cabeza. Pero todo su esfuerzo tiene su recompensa. Y es que ahora sabemos Kung Fu.

## vale que si, pero que es eso de networks

Pues es la manera en la que comunicamos el contenedor de nginx con el de php. En este caso, el proyecto original creaba una network interna llamada php-network con una red tipo puente, y le asignaba dicha network a cada uno de los servicios/contenedores.

Y por esta parte nada mas. Ya solo queda un solo comando de terminal para levantar el tinglao.


## THE FINAL

Tan sencillo como escribir en el terminal

´´´shell
$> docker-compose up -d 
´´´´
si estas en windows o mac, o en caso de estar en GNU Linux, y haber instalado docker con Snappy

´´´shell
$> sudo docker-compose up -d
´´´

en caso de que quisieramos ver los logs quitamos el flag -d y se pondrá que da gusto escupiendo logs. En mi caso, como de momento no le veo mucho sentido, le pongo el flag -d y asi me devuelve rapidamente el control de ese terminal para poder seguir usandolo.

## Parando el tinglao

Tan facil como poner en esa terminal dentro del directorio del proyecto

´´´shell
$> docker-compose down
´´´
o con el sudo delante pa que no se espante en GNU Linux.



