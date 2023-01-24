SHELL=/bin/bash

PROJECT_NAME=my_project_name

CD=cd ./${PROJECT_NAME} &&


export DB_HOST=127.0.0.1
export DB_DATABASE=${PROJECT_NAME}
export DB_USERNAME=${PROJECT_NAME}-user
export DB_PASSWORD=Top-secret@123


main: run


init:
	./setup/set-new-laravel-project.bash


install:
	${CD} php artisan migrate


# make new model=my_model
new:
	${CD} php artisan make:model ${model} -mcf;


seed:
	${CD} php artisan db:seed 


run:
	${CD} php artisan serve --host=localhost --port=8000
