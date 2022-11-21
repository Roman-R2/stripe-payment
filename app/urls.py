from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('', include('api.urls'), name='api'),
    path('item/', include('web.urls'), name='web'),
    path('admin/', admin.site.urls),
]
