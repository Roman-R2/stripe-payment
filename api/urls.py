from django.urls import path

from api import views
from web.views import Index

app_name = 'api'
urlpatterns = [
    path('', Index.as_view(), name='index'),
    path('buy/<pk>/', views.ItemGetSession.as_view(), name='get_stripe_session_id'),
]
