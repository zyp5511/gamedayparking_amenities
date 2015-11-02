# gameday_amenities

### Developing
In order to setup your environment to run the development server and test the application, or to contribute to the project, follow the instructions below.

Open your favorite terminal and do the following:

**Clone the repository:**
```sh
$ git clone https://github.com/rschaefer2/gameday_amenities.git && cd gameday_amenities
```
**Install sytem packages**

Ubuntu:
```sh
$ sudo apt-get install postgresql postgis postgresql-9.3-postgis-2.1 libpq-dev python-dev
```

Mac:
```sh
# install homebrew package manager
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install postgresql postgis python-dev geoip
$ xcode-select --install
```

Links to the above packages and dependencies can be found here:

- postgres   (http://www.postgresql.org/download/linux/)
- geos       (http://trac.osgeo.org/geos/)
- gdal       (https://trac.osgeo.org/gdal/wiki/DownloadingGdalBinaries)
- libpq-dev  (https://packages.debian.org/sid/libpq-dev)
- python-dev (http://packages.ubuntu.com/precise/python-dev)

**Run the following postgres commands to setup database**
```sh
# from ubuntu, start psql with the following. Mac - first command is "psql" only
$ sudo -u postgres psql
postgres=# CREATE DATABASE testdb;
postgres=# CREATE USER test WITH PASSWORD 'test';
postgres=# GRANT ALL PRIVILEGES ON DATABASE testdb to test;
postgres=# \connect testdb;
testdb=# CREATE EXTENSION postgis;
testdb=# CREATE EXTENSION postgis_topology;
testdb=#\q
```

These commands can be ran from the command line with the following file:
```sh
$ sudo -u postgres psql -f database_setup.sql
```

**Enter the developer python environment**
```sh
$ source develop.sh
```
**Check that the server is able to run**
```sh
$ cd parkingapp && python manage.py runserver
```
In your webrowser, navigate to *localhost:8000/home* to access the home page.

***Congratulations!*** You can test out the application, and start developing.



