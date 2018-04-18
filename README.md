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

## Uso

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
  
