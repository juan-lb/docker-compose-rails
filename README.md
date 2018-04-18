# docker-compose-rails

Utilidad para dockerizar en forma básica aplicaciones Rails y MySQL.

## Instalación

Ejecutar el script: `instal.sh`

Esto va a crear los Directorios

* `/opt/docker-compose-files`
* `/var/mysql-docker`

En `/opt/docker-compose-files` se van copiar los archivos:

* `Dockerfile`
* `docker-compose.yml`

Y por último se va copiar `docker-compose-init` a:

* `/usr/local/bin/docker-compose-init`

## Dockerizacion

Parado sobre el root de la aplicación Rails que se quiera dockerizar, ejecutar:

```bash
$ docker-compose-init
```

### Configuración

#### Docker MySQL

Se debe modificar el archivo `docker-compose.yml` en esta parte:

```yml
volumes:
  - /var/mysql-docker/PROYECTO:/var/lib/mysql
``` 
Y reemplazar `PROYECTO` por el nombre de la app (es el directorio donde el docker de MySQL guardará los archivos físicos de la base de datos)

#### database.yml
Se debe modificar el archivo `database.yml` en dos partes.

Por un lado se debe reemplzar esto:
```yml
socket: /var/run/mysqld/mysqld.sock
```
por esto:
```yml
host: db
```
Y la configuración del pass de la base de datos:
```yml
password: <%= ENV['DATABASE_PASSWORD'] %>
```

## Uso

### Primera ejecución

```bash
docker-compose up
```
Frenar CTRL+C y volver a ejecutar, la primera vez tiene que crear los archivos de base de datos.

### Migraciones

Ejecutar migraciones:
```
docerk-compose run app bundle exec rake db:create db:migrate
```

### Container o Codigo vivo
La configuración de este docker-compose permite modificar el código de la aplicación mientras el docker está corriendo, eso se logra montando como volumen interno de la imagen el directorio que tiene el codigo:

```yml
volumes:
  - .:/app
```

Para usarlo como container, primero crear la imagen:

```bash
docker build -t app_name .
```

y luego cambiar en el `docker-compose.yml` esto:
  
```yml
build: .
```
por esto:
```yml
image: app_name:latest
```

### Troubleshoting
Si en algún momento aparece este error al ejecutar `docker-compose up`:

```bash
app_1  | A server is already running. Check /app/tmp/pids/server.pid.
```

Se tiene que borrar el archivo en el directorio en el que estamos trabajando: `/tmp/pids/server.pid`
El problema es que un cierre forzado de la aplcación no se llegó a borrar el archivo que indica el pid.
