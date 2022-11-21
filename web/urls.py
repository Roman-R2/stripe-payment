from django.urls import path

from web import views

app_name = 'web'
urlpatterns = [

    path('<pk>/', views.ItemGetHtmlForm.as_view(), name='item_card'),
]
