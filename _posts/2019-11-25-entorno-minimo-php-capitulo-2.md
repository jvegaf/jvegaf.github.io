---
layout: post
title: Entorno minimo php II (recogiendo cable)
---

![phpstorm]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_1.png)

En el [anterior articulo]() me vine demasiado arriba con docker y realmente me he dado
cuenta al leer [un articulo de JetBrains](https://blog.jetbrains.com/phpstorm/2018/08/quickstart-with-docker-in-phpstorm/) de que no es necesaria tanta parafernalia para empezar a jugar con php.

Asi que para los que no querais leeros en ingles el [articulo original](https://blog.jetbrains.com/phpstorm/2018/08/quickstart-with-docker-in-phpstorm/), os voy a indicar la mas simple manera
de abordar el tema.

Lo primero es que no es necesario descargarse nada. Así. Como lo lees.

Dentro de la carpeta de nuestro proyecto, que en mi caso he empezado por llamarla 
pruebas, tenemos que crear un nuevo fichero con nombre

```
docker-compose.yml
```

En el vamos a escribir lo siguiente en caso de Windows o Mac

```YAML
version: '2'
services:
  webserver:
    image: phpstorm/php-73-apache-xdebug-27
    ports:
      - "80:80"
    volumes:
      - ./:/var/www/html
    environment:
      XDEBUG_CONFIG: remote_host=host.docker.internal
```

o en caso de usar GNU Linux cambiamos un pelín, dado que no tenemos disponble el puerto host.docker.internal

```YAMl
version: '2'
services:
  webserver:
    image: phpstorm/php-73-apache-xdebug-27
    ports:
      - "80:80"
    volumes:
      - ./:/var/www/html
    environment:
      XDEBUG_CONFIG: remote_host=<hostname>
```

poniendo como hostname el nombre que le tienes puesto en tu máquina. Por ejemplo en mi caso,
seria *fsociety* . Para averiguar el nombre de tu máquina solo tienes que poner en el terminal hostname y te escupira el nombre
de tu máquina.

## vale, ya lo tengo, y ahora que

ahora tenemos que crear la configuración de ejecución y depuración. Para ello primero tenemos que posicionarnos con el puntero sobre el fichero docker-compose.yml y sacar el menu contextual con el boton derecho del raton. De todas las opciones elegiremos la de Create 'docker-compose.yml:...'

![phpstorm]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_2.png)

Esto nos abrira una ventana de dialogo en el que tenemos que ponerle un nombre, por ejemplo yo le pongo Start application, aplicamos cambios y guardamos.

![phpstorm]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_3.png)

y ya tendriamos la configuracion lista para darle caña.
ahora lo que tenemos que hacer es pulsar sobre el icono del play que tenemos al lado de la configuracion de ejecucion en la pantalla principal.

![phpstorm]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_4.png)

Veremos como se nos abre la pestaña de docker en el cual tenemos un log en el que vemos los avances en la descarga de la imagen, creación del contenedor y como arranca.

![phpstorm]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_5.png)

Y con eso ya tendriamos el "tinglao terminao".

ahora podemos crear nuestro hello world particular para comprobar que todo va como debe de ir.

![phpstorm]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_6.png)

![hello monger 1]({{ site.baseurl}}/images/2019-11-25-entorno-minimo-php-capitulo-2/img_7.jpg)

En el siguiente articulo os escribiré como depurar con XDEBUG.
