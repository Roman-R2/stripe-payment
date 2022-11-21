# Django + Stripe API

## О проекте

Проект выполненн на django 4.1.3

## Требования

* Система linux или WSL
* Docker
* Утилита make

## Установка

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

7. Запустить dev сервер:
```
python manage.py runserver
```

## Автор

**Roman Slyusar**

## License

Этот проект находится под лицензией MIT License - подробнее [LICENSE](LICENSE.md)