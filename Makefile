SHELL=/bin/bash

PROJECT_NAME=my_project_name

CD=cd ./${PROJECT_NAME} &&


export DB_HOST=127.0.0.1
export DB_DATABASE=${PROJECT_NAME}
export DB_USERNAME=${PROJECT_NAME}-user
export DB_PASSWORD=top-secret


main: run


setup:
	sudo mysql -e "DROP DATABASE IF EXISTS ${DB_DATABASE};"
	sudo mysql -e "CREATE DATABASE ${DB_DATABASE};"
	sudo mysql -e "DROP   USER IF EXISTS '${DB_USERNAME}'@'localhost';"
	sudo mysql -e "CREATE USER '${DB_USERNAME}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
	sudo mysql -e "GRANT ALL PRIVILEGES ON * . * TO '${DB_USERNAME}'@'localhost';"
	sudo mysql -e "FLUSH PRIVILEGES;"
	composer create-project --prefer-dist laravel/laravel ${PROJECT_NAME};


install:
	${CD} php artisan migrate


# make new model=my_model
new:
	${CD} php artisan make:model ${model} -mcf;


seed:
	${CD} php artisan db:seed 


run:
	${CD} php artisan serve --host=localhost --port=8000
