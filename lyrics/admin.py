from django.contrib import admin
from .models import Song

# Register your models here.
admin.site.register(Song)
admin.site.site_header = "Proclaimly v3.1 by S2D Labs"
admin.site.site_title = "Proclaimly Admin Panel"