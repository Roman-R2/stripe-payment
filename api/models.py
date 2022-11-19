
import os

from django.db import models


# Django Модель Item с полями (name, description, price)
class Item(models.Model):
    name = models.CharField(max_length=255, verbose_name='Товар')
    description = models.TextField(verbose_name='Описание товара')
    price = models.DecimalField(max_digits=7, decimal_places=2, verbose_name='Цена')
