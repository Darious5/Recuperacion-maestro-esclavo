<h1>Recuperacion Master/Slave</h1>
<h2>Configuracion inicial</h2>
<p>
    Al principio, creamos el creamos el archivo Vagrantfile en el directorio en el que hagamos la practica usando en la terminal
    "vagrant init", una vez hayamos hecho eso, la plantilla para el Vagrantfile deberia salir en el directorio en el que hemos 
    ejecutado el comando.
</p>
<h2>Configurando el Vagrantfile</h2>
<p>
    Para empezar, tenemos que crear dos maquinas, una sera el servidor DNS maestro y la otra el servidor DNS esclavo.
    Tendremos que asignarle la ip correspondiente a cada una de las maquinas e instalar BIND9, gracias a que son servidores DNS
</p>
