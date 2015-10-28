# gameday_amenities

To Start Developing:

1. clone the repository

    git clone github.com/rschaefer2/gameday_amenities && cd gameday_amenities


2. install all the packages listed in the comments at the bottom of requirements.txt


3. Run the following postgres commands to setup database

    CREATE DATABASE testdb;
    
    CREATE USER test WITH PASSWORD 'test';
    
    GRANT ALL PRIVILEGES ON DATABASE testdb to test;
    
    \connect testdb;
    
    CREATE EXTENSION postgis;
    
    CREATE EXTENSION postgis_topology;


4. Enter the developer python environment

    source develop.sh


5. Check that the server is able to run. From within parkingapp/

    python manage.py runserver


