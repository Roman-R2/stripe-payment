# ----- Docker section -----
docker-up:
	docker-compose up -d

docker-build-up:
	docker-compose up -d --build

docker-down:
	docker-compose down --remove-orphans

docker-build:
	docker-compose build

# ----- Code section -----
check-code:
	isort api/ app/
	flake8 --extend-ignore E501 api/ app/ web/

# ----- Django section -----
prepare-server: flush migrate superuser load-fake-data

start-dev-server: docker-up
	python manage.py runserver

flush:
	python manage.py flush --no-input

migrate:
	python manage.py makemigrations
	python manage.py migrate

superuser:
	python manage.py createsuperuser --noinput

load-fake-data:
	python manage.py loaddata item

