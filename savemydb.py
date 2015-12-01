import os




string = "sudo -u postgres psql -f database.sql"
os.system(string)
path = os.getcwd()
path = path + '/parkingapp'
os.chdir(path)
os.system("python manage.py makemigrations parkingspot")
os.system("python manage.py migrate parkingspot")
os.system("python manage.py makemigrations userprof")
os.system("python manage.py migrate userprof")
os.system("python manage.py makemigrations message")
os.system("python manage.py migrate message")
os.system("python manage.py makemigrations review")
os.system("python manage.py migrate review")
os.system("python manage.py migrate")
