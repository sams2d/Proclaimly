from django.db import models
from html.parser import HTMLParser


class LyricsHTMLParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.lines = []
        self.current_line = []

    def handle_data(self, data):
        self.current_line.append(data)

    def handle_starttag(self, tag, attrs):
        if tag == 'br':
            self._flush_line()

    def handle_startendtag(self, tag, attrs):
        # Self-closing tags like <br/> come through here, not handle_starttag.
        if tag == 'br':
            self._flush_line()

    def handle_endtag(self, tag):
        if tag == 'p':
            self._flush_line()

    def _flush_line(self):
        if self.current_line:
            self.lines.append(''.join(self.current_line).strip())
            self.current_line = []

    def close(self):
        # Flush any trailing text that wasn't followed by </p> or <br>.
        self._flush_line()
        super().close()


class Song(models.Model):
    song_id = models.AutoField(primary_key=True)
    song_number = models.IntegerField(null=True, blank=True)
    title = models.CharField(max_length=100)
    Lyrics = models.TextField()

    def __str__(self):
        return self.title

    def get_slides(self):
        """Split lyrics into slides and remove HTML tags."""

        normalized = self.Lyrics.replace('\r\n', '\n')

        blocks = normalized.split('\n\n')

        slides = []

        for block in blocks:
            block = block.strip()

            if not block:
                continue

            parser = LyricsHTMLParser()
            parser.feed(block)
            parser.close()

            lines = [line for line in parser.lines if line]

            if lines:
                slides.append('\n'.join(lines))

        return slides if slides else [normalized.strip()]


class Data(models.Model):
    church_name = models.CharField(max_length=100)
    Verse = models.TextField()

    def __str__(self):
        return self.Verse