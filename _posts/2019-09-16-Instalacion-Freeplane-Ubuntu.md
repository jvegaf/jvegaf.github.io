---
layout: post
title: Instalacion Freeplane en Ubuntu y derivados
---

![Freeplane splashscreen]({{ site.baseurl}}/images/2019-09-16-Instalacion-Freeplane-Ubuntu/image1.jpg)

"Freeplane es una aplicación libre, de código abierto para la creación de mapas mentales o conceptuales (diagramas de conexiones entre ideas), y para definir outlines y esquemas de organización de textos (un outliner es un instrumento digital de organización jerárquica de secciones de un texto). Está programado en Java, y funciona en Windows, Mac OS X y GNU/Linux. Se publica bajo licencia GNU GPL." [enlace a Wikipedia](https://es.wikipedia.org/wiki/Freeplane)

![Freeplane screenshot]({{ site.baseurl}}/images/2019-09-16-Instalacion-Freeplane-Ubuntu/image2.png)

La manera mas sencilla de instalacion de Freeplane es mediante el gestor de paquetes Snappy.

Antiguamente, la principal manera de instalación de aplicaciones y paquetes en Debian y derivadas era a traves del repositorio APT. Pero en 2016 Canonical liberó un nuevo gestor de paquetes llamado Snappy, cuya "mejora" es que te incluye las dependencias de la aplicacion dentro del mismo paquete. A mi modo de ver, tiene los pros de que si estas trabajando con una libreria antigua, no vas a tener problemas de compatibilidad con sistemas nuevos, pero, como contra le veo que puedes llegar a tener N veces la misma libreria en tu disco.

## Instalacion Snappy

En Ubuntu desde la version 18.04 viene instalado de serie, puedes comprobarlo con la siguiente instruccion

```shell
$> snap --version
```

![snap version]({{ site.baseurl}}/images/2019-09-16-Instalacion-Freeplane-Ubuntu/image3.png)

En caso de que no lo tengas instalado de serie, en Debian y derivados puedes instalarlo con el comando

```shell
$> sudo apt install snapd
```

## Comandos utiles para Snappy

### Ayuda
```shell
$> snap help -all
```

### Busqueda
```shell
$> snap search [nombre]
```

### Instalación de paquetes
```shell
$> snap install [nombre_paquete]
```

### Borrado de paquetes
```shell
$> snap remove [nombre_paquete]
```


## Instalacion de Freeplane

Ahora que ya tenemos Snappy en nuestra maquina solamente tenemos que poner el siguiente comando

```shell
$> snap install freeplane-mindmappping
```

Y dejamos a Snappy hacer toda la magia por debajo.

Si queremos instalar nuestra propia configuracion e iconos, tenemos que hacerlo en la ruta

```shell
/home/[tu_usuario]/snap/freeplane-mindmapping/14/.config/
```

