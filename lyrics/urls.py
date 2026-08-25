from django.urls import path
from . import views
urlpatterns = [
    path('', views.index, name='index'),
    path('presentation/', views.presentation, name='presentation'),
    path('api/song/<int:song_id>/', views.song_slides, name='song_slides'),
]