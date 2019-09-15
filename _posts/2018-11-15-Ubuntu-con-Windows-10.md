---
layout: post
title: Ubuntu con Windows 10
---

![Satya Nadella]({{ site.baseurl}}/images/Ubuntu-con-Windows-10/image2.png)

Desde que el hombre de la imagen (Satya Nadella) se hizo cargo de la dirección de Microsoft, han cambiado muchas cosas en el mundo de la informática, pero en la que hoy nos vamos a centrar, es en como Microsoft esta apostando fuertemente por Linux a base de diferentes gestos. Uno de ellos es incorporar un subsistema Linux en Windows 10 en el cual, los usuarios de Windows 10 podemos tener acceso a un shell de Linux integrado en el sistema, sin emulaciones y sin maquinas virtuales. La primera distribución de Linux que apareció en la Microsoft Store (tienda de aplicaciones de Windows 10) fue Ubuntu. Pero a dia de hoy tenemos mas distros si somos mas exquisitos (debian, fedora….).

Para tener el tan ansiado shell por los usuarios de linux que por circunstancias de la vida hemos tenido que volver a Windows, solo tenemos que hacer tres pasos fundamentales.

Primer paso: activar el subsistema Linux para windows.

Para hacerlo, tenemos que acceder a la ventana Programas y características.Una vez dentro tenemos que ir a características de Windows, y de ahi, buscar el subsistema linux para windows y activarlo.

![Caracteristicas de Windows]({{ site.baseurl}}/images/Ubuntu-con-Windows-10/image3.png)

Paso dos: ir al Microsoft Store y obtener tu distro preferida, en este caso obtendremos Ubuntu.

![Ubuntu Microsoft Store]({{ site.baseurl}}/images/Ubuntu-con-Windows-10/image4.png)

Una vez descargado pasamos al paso tres. Que es la primera ejecución del sistema haciendo click sobre el icono de Ubuntu en tu menu de Inicio. El primer arranque de la aplicación tardará un poco porque tiene que hacer unos pasos intermedios automáticamente. Una vez tenemos ya el sistema completado, nos va a pedir que el escribamos un nombre de usuario, y una contraseña.

![Ubuntu config]({{ site.baseurl}}/images/Ubuntu-con-Windows-10/image1.png)

Y con eso ya tendríamos Ubuntu. Con el tenemos acceso a todo el contenido del disco del PC. La ruta de acceso a la raíz del disco C es  

```bash
/mnt/c
```

También comentaros que aunque no tiene entorno gráfico, hay gente que ha conseguido levantar aplicaciones sobre X11, aunque yo no he investigado nada del tema.
