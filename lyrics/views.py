from django.http import JsonResponse
from django.shortcuts import get_object_or_404, render
from .models import Song, Data

# Create your views here.
def index(request):
    songs = Song.objects.all().order_by('song_number')
    data = Data.objects.all()
    standby = data.first()

    return render(request, 'index.html', {
        'songs': songs,
        'data': data,
        'standby_text': standby.Verse if standby else '',
    })


def presentation(request):
    """The output page — open this on the projector / second monitor."""
    standby = Data.objects.first()
    return render(request, 'presentation.html', {
        'standby_text': standby.Verse if standby else '',
    })


def song_slides(request, song_id):
    """JSON endpoint the controller fetches when a song is selected."""
    song = get_object_or_404(Song, pk=song_id)
    return JsonResponse({
        'song_id': song.song_id,
        'title': song.title,
        'slides': song.get_slides(),
    })