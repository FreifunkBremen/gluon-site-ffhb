## Anleitung

Um die Bremer Firmware zu bauen sind folgende Vorbereitungen notwendig:
```sh
# Build-Dependencies installieren (Debian/Ubuntu)
sudo apt-get install coreutils schedtool build-essential subversion git libncurses5-dev zlib1g-dev unzip gawk libssl-dev
# Dieses und das Gluon-Repository clonen
git clone --recursive https://github.com/FreifunkBremen/gluon-site-ffhb.git
```

Um eine bestimmte Version der Bremer Firmware zu bauen sind folgende Befehle nötig:
```sh
# In das Verzeichnis wechseln
cd gluon-site-ffhb/
# Die gewünschte Version auschecken ($tag ist z.B. v2016.2.3+bremen2)
git checkout $tag
# Gluon auf die passende Version bringen
git submodule update
# Build-Prozess anstoßen
./build.sh
```
Lief der Build-Prozess erfolgreich durch, liegen in `gluon/output/images/` die fertigen Images inklusive eines Manifests für den Autoupdater, das schon mit dem eigenen ECDSA-Key signiert wurde falls dieser unter `~/.ecdsakey` liegt. In `gluon/output/packages/` liegen außerdem per `opkg` auf dem Knoten nachinstallierbare Kernel-Module.

Will man ohne `build.sh` manuell `make` im Verzeichnis gluon aufrufen, wie in der [offiziellen Gluon-Doku](https://gluon.readthedocs.org/en/stable/user/getting_started.html#building-the-images), muss man *jedem* Aufruf von `make` den Parameter `GLUON_SITEDIR=$PWD/../` nachstellen (oder wie in `build.sh` einmal per `export GLUON_SITEDIR=$PWD/../` setzen), damit Gluon das site-Repository findet. Alternativ kann man einen Symlink anlegen, indem man während man im site-Repository ist den Befehl `ln -s $PWD gluon/site` ausführt.

In jedem Fall wird der Gluon-Release-Name automatisch aus dem ausgecheckten Tag generiert - auch falls kein Tag, sondern z.B. der master-Branch ausgecheckt wurde! Falls das nicht gewünscht ist lässt sich durch folgenden Aufruf *vor* dem entsprechenden Build-Befehl (`./build.sh` oder `make`) ein eigener Release-Name festlegen:
```
export GLUON_RELEASE="v2016.2.3+bremen3+my_cool_extension"
```
Analog lassen sich alle anderen `GLUON_*`-Variablen überschreiben, außerdem die folgenden `build.sh`-spezifischen Variablen:

* `GLUON_TARGETS`: Welche Architekturen werden von `build.sh` gebaut
* `KEYFILE`: Der Ort des Schlüssels, mit dem das testing/nightly-Manifest automatisch unterschrieben werden soll
