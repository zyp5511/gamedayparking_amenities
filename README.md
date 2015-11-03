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
$ sudo apt-get update
$ sudo apt-get install postgresql postgis postgresql-9.3-postgis-2.1 libpq-dev python-dev pip
$ sudo pip install virtualenv
```

Mac:
```sh
# install homebrew package manager
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install postgresql postgis python-dev geoip pip
$ xcode-select --install
```

Links to the above packages and dependencies can be found here:

- postgres   (http://www.postgresql.org/download/linux/)
- postgis    (http://postgis.net/install)
- geos       (http://trac.osgeo.org/geos/)
- gdal       (https://trac.osgeo.org/gdal/wiki/DownloadingGdalBinaries)
- libpq-dev  (https://packages.debian.org/sid/libpq-dev)
- python-dev (http://packages.ubuntu.com/precise/python-dev)

**Run the following postgres commands to setup database**

This command will run a script of sql commands
```sh
$ sudo -u postgres psql -f database.sql
```

The commands the script runs are listed below
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

Import the test database
```sh
$ sudo -u postgres psql -U postgres testdb < dbexport.pgsql
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


**Testing**
From the top parkingapp direcotry (which contains manage.py), tests can be run using the following
```sh
$ python manage.py test
```

The code for testing can be found in parkingapp/parkingspot/tests.py
