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
<h2>Iniciamos Maquinas</h2>
<p>
    Una vez tengamos la base del Vagrantfile, podemos iniciarlo con "vagrant up", una vez usado este comando, nos podemos meter
    en las respectivas maquinas con "vagrant ssh 'vmname'", en este caso nos interesa sacar las plantillas de los archivos de Configuracion
    de BIND9, como en ambas maquinas esta instalado BIND9, podemos hacerla en cualquier de los dos, solo nos tendriamos que meter en la ruta
    "/etc/bind" y ahi estan todos los archivos de configuracion necesarios, los cuales podemos copiar a nuestro directorio en la maquina host con
    el comando "cp" en la ruta "/vagrant".
</p>
<h2>Archivos de configuracion</h2>
<p>Debemos de editar los archivos de configuracion que hemos copiado anteriormente, para esto debemos editar los siguientes.</p>
    <h3>/etc/default/bind9</h3>
    <p>
        Aqui solo deberemos añadir la linea 'OPTIONS="-4"', la cual hace que use el protocolo IPV4, como es solo una linea, no hace falta que creemos un archivo
        y lo provisionemos con vagrant, podemos simplemente usar en la provision un echo para que cambie el contenido del archivo original por 'OPTIONS="-4"' y 
        asi conseguir la configuracion ahorrandonos un archivo mas, esto podriamos hacerlo para todos los archivos, pero el resto al ser mas largos, es preferible
        por comodidad y por legibilidad, crearlos aparte en una carpeta de configuracion y acto seguido provisionarlo con vagrant.
    </p>
    <h3>named.conf.options</h3>
    <p>
        Primero la configuracion de BIND9, esta se llamara "named.conf.options", aqui deberemos asignar la configuracion de el servidor dns.
        En este caso es importante poner que el forwarder sea la ip 208.67.222.222, que haya Validación DNSSEC y que solo escuche IPv4.
        Este archivo debera estar en ambas maquinas en la direccion "/etc/bind/named.conf.options".
    </p>
    <h3>named.conf.local</h3>
    <p>
        Despues hemos de cambiar named.conf.local, en este caso deberemos de dividirlo en dos, uno para la maquina master y otra para la slave.
        En este archivo, configuramos las zonas que ha de resolver el servidor DNS, como tambien que servidor es su maestro o cual es su esclavo respectivamente,
        Para esto hemos de poner que tipo de servidor es, en caso de ser esclavo poner cual es su maestro, el nombre de la zona y el archivo con la informacion
        de las direcciones ips de esa zona en concreto. Este archivo se debe encontrar en "/etc/bind/named.conf.local"
    </p>
    <h3>zonas directas e inversas</h3>
    <p>
        En este caso nos falta añadir informacion a los archivos a los que hemos llamado en named.conf.local con la informacion con la que tiene que resolver cada zona,
        para esto, debemos de añadir las direcciones correspondientes, tanto para servidores de nombres, como para direcciones de mail, inversas, etc.
        Primero configuramos las directas en un archivo, lo vamos a llamar "sistema.test.zone", y despues las inversas han de ir en otro archivo especifico para ellas,
        el cual deberiamos tambien haber copiado la plantilla, y lo llamamos 57.168.192.in-addr.arpa.zone, se debera llamar asi gracias a que las resoluciones inversas
        se escriben con la ip al reves en la zona addr.arpa. en este caso, al ser resoluciones inversas, no debemos usar los registros A, ya que estos son para direcciones IPV4,
        debemos usar PTR, que es el nombre de registro que se usa para direcciones inversas.
        Estos archivos se deben encontrar en "/etc/bind/zones/sistema.test.zone" y en /etc/bind/zones/57.168.192.in-addr.arpa.zone respectivamente.
    </p>
    <h3>Finalizar configuracion</h3>
    <p>
        Una vez hecho esto, debemos de reiniciar el servicio bind, para que se aplique la configuracion con los archivos que hemos provisionado.
        Esto lo haremos con el comando "systemctl restart bind9".
    </p>