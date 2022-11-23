# Django + Stripe API

## О проекте

Проект выполненн на django 4.1.3

## Требования

* Система linux или WSL
* Docker
* Утилита make

## Dev запуск без docker

1. Создать виртуальное окружение:

```
python3 -m venv venv
```
2. Активировать виртуальное окружение

3. Установить зависимости проекта из файла requirements.txt:
```
pip install -r requirements.txt
```
4. Создать в корневом каталоге проекта файл со значениями переменных окружения .env по шаблону файла .env.example

5. Создать и применить миграции:

```
make migrate
```
6. Создать суперпользователя (параметры суперпользователя задаются в файле .env):

```
make superuser
```

7. Применить тестовые фикстуры:

```
make load-fake-data
```

8. Запустить dev сервер:
```
make start-simple-dev-server
```

## Dev запуск с docker

1. Запустить команду:
```
make start-docker-dev-server
```
после этого сервер доступен на http://localhost:8000/
чтобы остановить dev сервер выполните команду:
```
make docker-dev-down
```

## Автор

**Roman Slyusar**

## License

Этот проект находится под лицензией MIT License - подробнее [LICENSE](LICENSE.md)