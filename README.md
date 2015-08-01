## Anleitung

Um die Bremer Firmware zu bauen sind folgende Vorbereitungen notwendig:
```sh
# Dieses Repository clonen
git clone https://github.com/FreifunkBremen/gluon-site-ffhb.git
# In das Verzeichnis wechseln
cd gluon-site-ffhb/
# Gluon selbst clonen
git submodule update --init
```

Um eine neue Testing-Version der Bremer Firmware zu bauen sind folgende Befehle nötig:
```sh
# Gluon auf die gewünschte Version bringen ($tag ist z.B. v2015.1.1)
git -C gluon checkout $tag
# Build-Prozess anstoßen
./build.sh testing
```
Das Script `build.sh` versucht die richtige Versionsnummer automatisch aus dem gewählten Gluon-Tag und der letzten veröffentlichten Testing-Version zu bestimmen, sie kann aber auch manuell eingegeben werden. Will man stattdessen eine Stable bauen, ändert man einfach nur das `testing` in der letzten Zeile zu `stable`.

Lief der Build-Prozess erfolgreich durch, liegen in `gluon/images/` die fertigen Images inklusive eines Manifests für den Autoupdater, das schon mit dem eigenen ECDSA-Key signiert wurde falls dieser unter `~/.ecdsakey` liegt.
