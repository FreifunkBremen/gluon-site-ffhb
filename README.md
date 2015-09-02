## Anleitung

Um die Bremer Firmware zu bauen sind folgende Vorbereitungen notwendig:
```sh
# Build-Dependencies installieren (Debian)
sudo apt-get install coreutils build-essential subversion git libncurses5-dev zlib1g-dev unzip gawk
# Dieses und das Gluon-Repository clonen
git clone --recursive https://github.com/FreifunkBremen/gluon-site-ffhb.git
```

Um eine neue Testing-Version der Bremer Firmware zu bauen sind folgende Befehle nötig:
```sh
# In das Verzeichnis wechseln
cd gluon-site-ffhb/
# Gluon auf die gewünschte Version bringen ($tag ist z.B. v2015.1.1)
git -C gluon checkout $tag
# Build-Prozess anstoßen
./build.sh testing
```
Das Script `build.sh` versucht die richtige Versionsnummer automatisch aus dem gewählten Gluon-Tag und der letzten veröffentlichten Testing-Version zu bestimmen, sie kann aber auch manuell eingegeben werden. Will man stattdessen eine Stable bauen, ändert man einfach nur das `testing` in der letzten Zeile zu `stable`.

Lief der Build-Prozess erfolgreich durch, liegen in `gluon/images/` die fertigen Images inklusive eines Manifests für den Autoupdater, das schon mit dem eigenen ECDSA-Key signiert wurde falls dieser unter `~/.ecdsakey` liegt.

Will man ohne `build.sh` manuell `make` im Verzeichnis gluon aufrufen, wie in der [offiziellen Gluon-Doku](https://gluon.readthedocs.org/en/v2015.1.1/user/getting_started.html#building-the-images), muss man *jedem* Aufruf von `make` den Parameter `GLUON_SITEDIR=$PWD/../` nachstellen (oder wie in `build.sh` einmal per `export GLUON_SITEDIR=$PWD/../` setzen).
