# gameday_amenities

### Developing
In order to setup your environment to run the development server and test the application, or to contribute to the project, follow the instructions below.

Open your favorite terminal and do the following:

**Clone the repository:**
```sh
$ git clone https://github.com/rschaefer2/gameday_amenities.git && cd gameday_amenities
```
**Install sytem packages**

Ubunttu:
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
**Run the following postgres commands to setup database**
```sh
# from ubuntu, start psql with the following. Mac - figure it out.
$ sudo -u postgres psql
postgres=# CREATE DATABASE testdb;
postgres=# CREATE USER test WITH PASSWORD 'test';
postgres=# GRANT ALL PRIVILEGES ON DATABASE testdb to test;
postgres=# \connect testdb;
testdb=# CREATE EXTENSION postgis;
testdb=# CREATE EXTENSION postgis_topology;
testdb=#\q
```
**Enter the developer python environment**
```sh
$ source develop.sh
```
**Check that the server is able to run**
```sh
$ cd parkingapp && python manage.py runserver
```
In your webrowser, navigate to *localhost:8000/home* in order to check that the server is running correctly.

***Congratulations!*** You can test out the application, and start developing.



