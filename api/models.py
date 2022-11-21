from django.db import models


# Django Модель Item с полями (name, description, price)
class Item(models.Model):
    name = models.CharField(max_length=255, verbose_name='Товар')
    description = models.TextField(verbose_name='Описание товара')
    price = models.DecimalField(max_digits=7, decimal_places=2, verbose_name='Цена')

    class Meta:
        verbose_name = 'Товар'
        verbose_name_plural = 'Товары'

    def __str__(self):
        return f'№{self.pk} - {self.name} - {self.price}'
