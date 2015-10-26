#script in order to create a virutalenv and install scripts

virtualenv --no-site-packages --distribute .env && source .env/bin/activate && pip install -r requirements.txt

