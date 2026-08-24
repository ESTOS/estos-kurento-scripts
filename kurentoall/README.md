# kurentoall — ESTOS Kurento Media Server (Windows)

Dieses Verzeichnis ist das **aktuelle Build-Projekt** für den ESTOS UC Media Server unter Windows.
Die Shell-Skripte im übergeordneten Verzeichnis `estos-kurento-scripts/` (z. B. `buildlast64-log.sh`, `initsystem64.sh`) gehören zum **veralteten Fedora-24-Cross-Compile-Workflow** und werden hier nicht mehr verwendet.

`kurentoall` baut alle Abhängigkeiten nativ mit **MSYS2 CLANG64** (Clang-Toolchain), erzeugt eine portable Laufzeitumgebung unter `kmswindows/` und verpackt sie als `emswindows64_<timestamp>.zip`.

> **Hinweis:** Es werden ausschließlich die **`-clang`-Skripte** verwendet. Die älteren GCC/MINGW64-Skripte ohne `-clang`-Suffix (`0-buildinitsystem.sh`, `1-buildmain.sh`, …) sind **veraltet** und nicht mehr im Einsatz.

---

## Inhaltsverzeichnis

1. [Überblick](#überblick)
2. [Verzeichnisstruktur](#verzeichnisstruktur)
3. [Komponenten und Abhängigkeiten](#komponenten-und-abhängigkeiten)
4. [Build-Workflow](#build-workflow)
5. [Skript-Referenz](#skript-referenz)
6. [Das `kurento/`-Monorepo](#das-kurentomonorepo)
7. [Laufzeitumgebung `kmswindows/`](#laufzeitumgebung-kmswindows)
8. [ESTOS-Anpassungen](#estos-anpassungen)
9. [Veraltete GCC-Skripte](#veraltete-gcc-skripte)
10. [Konfiguration und Debugging](#konfiguration-und-debugging)
11. [Bekannte Einschränkungen](#bekannte-einschränkungen)

---

## Überblick

```
┌──────────────────────────────────────────────────────────────┐
│  Anwendung / Tutorial (Java oder JavaScript Client)          │
└──────────────────────────┬───────────────────────────────────┘
                           │ WebSocket JSON-RPC, Port 8888
                           ▼
┌──────────────────────────────────────────────────────────────┐
│  uc-media-server.exe  (in kmswindows/bin/)                   │
│  (umbenannt von kurento-media-server.exe beim Deploy)        │
│  ┌──────────┐  ┌─────────────┐  ┌────────────────────────┐  │
│  │ jsonrpc  │  │ module-core │  │ module-elements/filters│  │
│  └──────────┘  └─────────────┘  └────────────────────────┘  │
└──────────────────────────┬───────────────────────────────────┘
                           │ lädt
                           ▼
┌──────────────────────────────────────────────────────────────┐
│  GStreamer-Plugins, libnice, Boost, GLib, OpenSSL, OpenCV …  │
└──────────────────────────────────────────────────────────────┘
```

| Aspekt | Details |
|--------|---------|
| Zielplattform | Windows x64 (nativer MSYS2-Build) |
| Toolchain | **Clang / CLANG64** (`msys64/clang64.exe`) |
| Server-Binary | `uc-media-server.exe` |
| Standard-Port | 8888 (WebSocket), 8433 (WSS) |
| Paketname | `emswindows64_<timestamp>.zip` (+ `emswindows64sym_*.zip` mit PDBs) |
| Erwarteter Pfad | `x:\dev\estos-kurento-scripts\kurentoall` (oder `/c/lwx/dev/...`) |

---

## Verzeichnisstruktur

```
kurentoall/
├── 0-buildinitsystem-clang.sh        # Einmalige MSYS2-Paketinstallation (CLANG64)
├── 1-buildmain-clang.sh              # Haupt-Build-Orchestrator (Clang)
├── 2.0-buildcopykmswindows-clang.sh  # Build-Artefakte → kmswindows/ (Deploy + PDBs)
├── 2.0-lastcommits.sh                # Git-HEAD aller Repos protokollieren
├── 2.1-builddist.sh                  # kmswindows/ → dist64/ + ZIP
├── 3-kurento-start.cmd               # Server unter Windows starten
├── 4-run-clang.cmd                   # Bash-Skripte aus Windows CMD aufrufen
├── 5-build-release-clang.cmd         # Vollständiger Release-Build (automatisiert)
│
├── msys64/                           # Gebündelte MSYS2-Umgebung (aus msys64-clang.zip)
├── msys64-clang.zip                  # Vorkonfigurierte MSYS2/CLANG64-Umgebung (~1,2 GB)
├── install-clang64/                  # Separates OpenSSL-Install (Clang, nicht /clang64)
├── jdk-11/                           # Temurin JDK 11 (für Maven/module-creator)
├── maven/                            # Apache Maven 3.9.x
│
├── glib/                             # ESTOS-Fork, Meson
├── gstreamer/                        # ESTOS-Fork (GStreamer-Monorepo)
├── libnice/                          # ESTOS-Fork, Meson (WebRTC ICE)
├── opencv/                           # ESTOS-Fork, CMake
├── opencv-build-Release/             # Out-of-tree OpenCV-Build
├── openssl/                          # ESTOS-Fork
├── websocketpp/                      # ESTOS-Fork (Header-only)
├── websocketpp-build-Release/
│
├── kurento/                          # ESTOS-Fork des Kurento-Monorepos
│   ├── server/                       # C++ Media Server (CMake)
│   │   ├── build-RelWithDebInfo-clang/
│   │   └── build-Debug-clang/
│   ├── clients/                      # Java- und JavaScript-Clients
│   ├── browser/                      # Browser-Utilities
│   ├── docker/                       # Upstream-Docker-Images (Linux)
│   ├── tutorials/                    # Beispielanwendungen
│   └── test/                         # Integrationstests
│
├── kmswindows/                       # Portable Laufzeitumgebung (Deploy-Ziel)
│   ├── bin/                          # uc-media-server.exe + Runtime-DLLs
│   ├── lib/gstreamer-1.0/            # GStreamer-Plugins
│   ├── lib/kurento/modules/          # Kurento-Modul-DLLs
│   └── etc/kurento/                  # Konfiguration
│
├── kmswindows-symbols/               # PDB-Dateien (Clang-Deploy)
├── dist64/                           # Letztes Distributionspaket
├── emswindows64_*.zip                # Release-ZIP
├── emswindows64sym_*.zip             # Debug-Symbole (PDB)
└── lastcommits_actual.txt            # Reproduzierbarkeitsprotokoll
```

---

## Komponenten und Abhängigkeiten

Alle Quell-Repositories stammen von **ESTOS-Forks** auf GitHub und werden in `1-buildmain-clang.sh` mit festen Commits/Tags referenziert:

| Verzeichnis | Repository | Build-System | Zweck |
|-------------|------------|--------------|-------|
| `glib/` | [ESTOS/glib](https://github.com/ESTOS/glib) | Meson | GLib-Basisbibliothek |
| `gstreamer/` | [ESTOS/gstreamer](https://github.com/ESTOS/gstreamer) | Meson | Multimedia-Pipeline |
| `libnice/` | [ESTOS/libnice](https://github.com/ESTOS/libnice) | Meson | ICE/STUN/TURN (WebRTC) |
| `opencv/` | [ESTOS/opencv](https://github.com/ESTOS/opencv) | CMake | Computer-Vision-Filter |
| `openssl/` | [ESTOS/openssl](https://github.com/ESTOS/openssl) | configure/make | TLS (nach `install-clang64/`) |
| `websocketpp/` | [ESTOS/websocketpp](https://github.com/ESTOS/websocketpp) | CMake | WebSocket-Unterstützung |
| `kurento/` | [ESTOS/kurento](https://github.com/ESTOS/kurento) | CMake + Maven | Media Server + Clients |

**Build-Reihenfolge** (in `1-buildmain-clang.sh` → `build()`):

1. glib
2. gstreamer
3. libnice (neuere ESTOS-Version nach GStreamer)
4. opencv
5. openssl
6. websocketpp
7. kurento

Installation erfolgt nach `$MINGW_PREFIX` (`/clang64`). OpenSSL wird separat nach `install-clang64/` installiert, um das pacman-Python nicht zu überschreiben.

---

## Build-Workflow

### Voraussetzungen

- Windows-Host mit MSYS2 **CLANG64** (vorkonfiguriert als `msys64-clang.zip` oder manuell eingerichtet)
- Checkout unter `x:\dev\estos-kurento-scripts\kurentoall`
- Alle Build-Skripte müssen aus **`msys64\clang64.exe`** gestartet werden (`MSYSTEM=CLANG64`)
- Für `setup`: Maven-ZIP und JDK-ZIP unter `/x/dev/tools/mingw/tools/` (siehe `build_tools()` in `1-buildmain-clang.sh`)

### Ersteinrichtung (einmalig)

```bash
# In MSYS2 CLANG64-Shell (msys64\clang64.exe):
./0-buildinitsystem-clang.sh
```

Installiert per `pacman` alle Build-Abhängigkeiten (`mingw-w64-clang-x86_64-*`: meson, clang, cmake, boost, ninja, …).

Details zur MSYS2-Vorbereitung stehen als Kommentar in `0-buildinitsystem-clang.sh` (inkl. Packen von `msys64-clang.zip`).

### Repositories klonen und bauen

```bash
./1-buildmain-clang.sh setup          # Klont alle ESTOS-Repos, extrahiert JDK/Maven
./1-buildmain-clang.sh build          # Vollständiger Build aller Komponenten
```

Alternativ mit Logdatei:

```bash
./1-buildmain-clang.sh buildalllog    # setup + build → logbuildmain.txt
```

Einzelne Komponenten:

```bash
./1-buildmain-clang.sh build_glib
./1-buildmain-clang.sh build_kurento
# usw. — jedes build_*-Target aus 1-buildmain-clang.sh
```

### Laufzeitumgebung erstellen

```bash
./2.0-buildcopykmswindows-clang.sh minimal          # Kern + Filter, ohne OpenCV-Plugins
./2.0-buildcopykmswindows-clang.sh minimal-opencv   # zusätzlich OpenCV-Filter-Plugins
```

Dabei wird `kurento-media-server.exe` nach `kmswindows/bin/uc-media-server.exe` kopiert, alle benötigten DLLs aufgelöst und PDB-Dateien nach `kmswindows-symbols/` gesammelt.

### Distribution verpacken

```bash
./2.1-builddist.sh
```

Erzeugt `dist64/` und `emswindows64_<timestamp>.zip` (+ `emswindows64sym_<timestamp>.zip` mit PDBs). Vorher werden die Git-Commits aller Repos in `lastcommits_actual.txt` archiviert.

### Vollautomatischer Release-Build (Windows CMD)

```cmd
5-build-release-clang.cmd
```

Führt aus: `msys64-clang.zip` entpacken → `buildalllog` → `minimal` deploy → `2.1-builddist.sh` (Log: `build-release.log`).

### Skripte aus Windows CMD aufrufen

```cmd
4-run-clang.cmd 1-buildmain-clang.sh build
```

Setzt `MSYSTEM=CLANG64` und ruft das Bash-Skript über die gebündelte MSYS2-Umgebung auf.

### Server starten

```cmd
3-kurento-start.cmd
```

Oder aus MSYS2 CLANG64:

```bash
./1-buildmain-clang.sh run
```

---

## Skript-Referenz

| Skript | Beschreibung |
|--------|--------------|
| `0-buildinitsystem-clang.sh` | `pacman`-Abhängigkeiten für CLANG64 installieren |
| `1-buildmain-clang.sh` | Orchestriert Klonen, Bauen und Starten (Clang) |
| `1-buildmain-clang.sh setup` | Repos klonen/checkout, JDK/Maven bereitstellen |
| `1-buildmain-clang.sh build` | Alle Komponenten bauen |
| `1-buildmain-clang.sh buildalllog` | setup + build mit Log |
| `1-buildmain-clang.sh buildkurentolog` | Nur Kurento bauen (mit Log) |
| `1-buildmain-clang.sh build_*` | Einzelne `build_<name>`-Funktion ausführen |
| `1-buildmain-clang.sh run` | `uc-media-server.exe` mit Debug-Umgebung starten |
| `2.0-buildcopykmswindows-clang.sh` | Deploy nach `kmswindows/` inkl. PDB-Sammlung |
| `2.0-lastcommits.sh` | Git-Log aller 7 Repos schreiben |
| `2.1-builddist.sh` | ZIP-Paket erstellen, optional Upload |
| `3-kurento-start.cmd` | Windows-Starter mit PATH/GST_PLUGIN_PATH |
| `4-run-clang.cmd` | Beliebiges Bash-Skript via gebündeltem MSYS2 (CLANG64) aufrufen |
| `5-build-release-clang.cmd` | Kompletter Release-Pipeline-Lauf |

### Targets von `2.0-buildcopykmswindows-clang.sh`

| Target | Inhalt |
|--------|--------|
| `minimal` | Kernmodule (core, elements, filters), keine OpenCV-GST-Plugins |
| `minimal-opencv` | `minimal` + OpenCV-Filter-Plugins und Laufzeit-DLLs |

---

## Das `kurento/`-Monorepo

Das Verzeichnis `kurento/` enthält den vollständigen Kurento-Quellcode (Upstream-Layout, ESTOS-Fork).

### `kurento/server/` — Media Server (C++)

| Verzeichnis | Zweck |
|-------------|-------|
| `bin/build-run.sh` | Upstream-Build-Einstiegspunkt, erweitert um `--msys` und `--clang` |
| `bin/generate-js-clients.sh` | Generiert JS-Clients aus `.kmd.json`-Definitionen |
| `cmake-utils/` | CMake-Hilfsmodule (inkl. `KurentoGitHelpers.cmake`) |
| `jsonrpc/` | JSON-RPC-Bibliothek |
| `media-server/` | Hauptprozess `kurento-media-server` |
| `module-core/` | Kern-GStreamer-Plugins und Basisklassen |
| `module-elements/` | Medienelemente (WebRtcEndpoint, PlayerEndpoint, …) |
| `module-filters/` | Filter (z. B. FaceDetector, ZBar) |
| `module-creator/` | Java/Maven-Tool zur Code-Generierung aus `.kmd.json` |
| `module-examples/` | Beispielmodule |
| `module-extras/` | Zusatzmodule (z. B. video-sampler) |
| `gst-plugins-rs/` | Rust-GStreamer-Plugins (Upstream) |

**Build-Einstiegspunkt** (aufgerufen von `1-buildmain-clang.sh`):

```bash
cd kurento/server
bin/build-run.sh --msys --clang --release --build-only \
  --addcmakeargs "-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
                  -DOpenCV_DIR=$MINGW_PREFIX/x64/mingw/lib \
                  -DCMAKE_INSTALL_PREFIX=$MINGW_PREFIX \
                  -DOPENSSL_ROOT_DIR=$ROOT_DIRECTORY/install-clang64"
```

Build-Verzeichnisse: `build-RelWithDebInfo-clang/` (Release) bzw. `build-Debug-clang/` (Debug).

Der Clang-Build erzeugt duale Debug-Infos: **DWARF** (GDB) und **CodeView/PDB** (WinDbg).

### Versionsnummer beim Build setzen

Die Version kann beim Build überschrieben werden, ohne Quellcode zu ändern:

```bash
# Direkt über build-run.sh:
bin/build-run.sh --msys --clang --release --build-only \
  --version 7.4.0-dev \
  --build-datetime 20250824-134500

# Über 1-buildmain-clang.sh (Umgebungsvariablen):
KURENTO_PROJECT_VERSION=7.4.0-dev KURENTO_VERSION_WITH_DATETIME=1 \
  ./1-buildmain-clang.sh build_kurento
```

Ergebnis z. B.: `7.4.0~estosw.gabc1234.20250824-134500`

CMake-Cache-Variablen (alternativ via `--addcmakeargs`):

- `KURENTO_PROJECT_VERSION` — Basisversion (ersetzt Wert aus CMakeLists / `.kmd.json`)
- `KURENTO_BUILD_DATETIME` — optionaler Zeitstempel-Suffix
- `CALCULATE_VERSION_WITH_GIT=FALSE` — Git-Suffix deaktivieren

### `kurento/clients/` — Client-Bibliotheken

| Pfad | Technologie | Zweck |
|------|-------------|-------|
| `clients/java/` | Maven | Java-Client für Kurento Protocol |
| `clients/javascript/` | npm | JavaScript-Client |

Die Clients werden beim Server-Build über `generate-js-clients.sh` generiert, sind aber **nicht** Teil des `kmswindows/`-Deployments. Sie werden für Tutorials und Anwendungsentwicklung separat gebaut.

### Weitere Verzeichnisse

| Pfad | Zweck |
|------|-------|
| `browser/` | Browser-seitige Utilities (`kurento-utils-js`) |
| `docker/` | Upstream-Docker-Images für Linux-Deployment |
| `tutorials/` | Java- und JavaScript-Beispielanwendungen |
| `test/integration/` | Integrationstests |
| `doc-kurento/` | Dokumentation |
| `.github/workflows/` | Upstream-CI (Linux, nicht an `kurentoall`-Skripte gekoppelt) |

---

## Laufzeitumgebung `kmswindows/`

Das Deploy-Verzeichnis enthält alles, was auf einem Zielrechner zum Betrieb benötigt wird:

```
kmswindows/
├── bin/
│   ├── uc-media-server.exe       # ESTOS Media Server
│   └── *.dll                     # Runtime-Abhängigkeiten
├── lib/
│   ├── gstreamer-1.0/            # GStreamer-Plugins
│   │   └── kurento/              # Kurento-GStreamer-Plugins
│   └── kurento/modules/          # Kurento-Modul-DLLs
├── etc/kurento/
│   ├── kurento.conf.json         # Server-Konfiguration (Port, Ressourcen)
│   ├── defaultCertificate.pem    # Standard-TLS-Zertifikat
│   └── modules/kurento/          # Modul-Defaults (*.conf.ini, *.conf.json)
├── liblicenses/                  # Lizenzen Dritter
└── log/                          # Laufzeit-Logs
```

**Wichtige Umgebungsvariablen** (gesetzt in `3-kurento-start.cmd`):

- `PATH` — `kmswindows/bin` voranstellen
- `GST_PLUGIN_PATH` — `lib/gstreamer-1.0/kurento` und `lib/gstreamer-1.0`
- GStreamer-Registry-Cache wird beim Start gelöscht (verhindert veraltete Plugin-Scans)

---

## ESTOS-Anpassungen

Gegenüber dem Upstream-Kurento-Projekt gibt es folgende ESTOS-spezifische Änderungen:

### Branding und Versionierung

- `kurento-media-server.exe` wird beim Deploy zu **`uc-media-server.exe`** umbenannt
- Versionsstrings in `kurento/server/cmake-utils/cmake/Kurento/KurentoGitHelpers.cmake`:
  - Windows: `7.3.1~estosw.g<git-hash>`
  - Linux: `7.3.1~estosu.g<git-hash>`

### MSYS/Windows-Build-Unterstützung

- `--msys` und `--clang` in `build-run.sh` (MSYS-Makefiles, Clang-Compiler, `.exe`-Suffix)
- GStreamer `d3d12` deaktiviert (MinGW/WRL-Inkompatibilität)
- libnice: Tests und Beispiele deaktiviert
- OpenCV: ohne `videoio`
- OpenSSL: separates Prefix `install-clang64/` (schützt pacman-Python)
- JavaScript-Clients verweisen auf ESTOS-Git-Repositories

### Distribution

- Paketname: `emswindows64_<timestamp>.zip` + `emswindows64sym_<timestamp>.zip` (PDBs)
- Optionaler Upload nach `build.estos.de/kurento` (wenn Datei `localupload` existiert)

---

## Veraltete GCC-Skripte

Die folgenden Skripte ohne `-clang`-Suffix gehören zum **alten GCC/MINGW64-Build** und werden **nicht mehr verwendet**:

| Veraltet (GCC/MINGW64) | Aktuell (Clang/CLANG64) |
|----------------------|-------------------------|
| `0-buildinitsystem.sh` | `0-buildinitsystem-clang.sh` |
| `1-buildmain.sh` | `1-buildmain-clang.sh` |
| `2.0-buildcopykmswindows.sh` | `2.0-buildcopykmswindows-clang.sh` |
| `4-run.cmd` | `4-run-clang.cmd` |
| `5-build-release.cmd` | `5-build-release-clang.cmd` |

Die GCC-Variante nutzte `msys64\mingw64.exe` und installierte nach `/mingw64`. Der Clang-Build verwendet `msys64\clang64.exe`, installiert nach `/clang64` und erzeugt PDB-Symbole.

---

## Konfiguration und Debugging

### Server-Konfiguration

Hauptdatei: `kmswindows/etc/kurento/kurento.conf.json`

- WebSocket-Port: 8888
- WSS-Port: 8433
- Ressourcenlimits (Pipelines, Endpoints)

Modul-Defaults: `kmswindows/etc/kurento/modules/kurento/*.conf.{ini,json}`

### VS Code

- `.vscode/launch.json` — GDB-Launch-Konfiguration für `uc-media-server.exe`
- `kurentonew.code-workspace` — Workspace-Datei (Pfade auf `x:/dev/...`)

### Debug-Logging

In `3-kurento-start.cmd` und `1-buildmain-clang.sh run`:

```
GSTDEBUGLEVEL=3
GSTDEBUG=kms*:6,Kurento*:5
```

### Kurento-Tutorials testen

Nach dem Start ist der Server unter `localhost:8888` erreichbar.
Anleitungen: [Kurento Tutorials](http://doc-kurento.readthedocs.io/en/stable/tutorials.html)

---

## Bekannte Einschränkungen

1. **Hardcodierte Pfade** — Skripte erwarten `x:\dev\estos-kurento-scripts\kurentoall` (alternativ `/c/lwx/dev/...`). Andere Pfade erfordern Anpassungen in den Skripten und `.cmd`-Dateien.

2. **Kein CI für `kurentoall`** — `.github/` enthält nur Cursor-Modernize-Hooks. Der Release-Build läuft über `5-build-release-clang.cmd`.

3. **Upstream-CI/Docker nicht aktiv genutzt** — `kurento/docker/` und `kurento/.github/workflows/` sind Linux-orientiert und nicht in den `kurentoall`-Skripten verdrahtet.

4. **Client-Bibliotheken nicht im Deploy** — Java/JS-Clients müssen für Tutorial-Tests separat gebaut werden.

5. **Vendored Toolchain** — `msys64/`, `msys64-clang.zip`, `jdk-11/`, `maven/` machen das Workspace sehr groß.

6. **TLS-Standardzertifikat** — `defaultCertificate.pem` ist ein Entwicklungszertifikat, nicht für Produktion geeignet.

7. **Pinned Commits vs. Working Copy** — Die in `1-buildmain-clang.sh` hinterlegten Git-Tags können von den tatsächlich ausgecheckten Commits abweichen, wenn lokal manuell aktualisiert wurde. `lastcommits_actual.txt` dokumentiert den Stand beim letzten Dist-Build.

---

## Lizenz

Der ESTOS UC Media Server basiert auf dem Kurento Media Server (Apache License 2.0).

Siehe `kmswindows/etc/NOTICE.txt`, `kmswindows/etc/LICENSE-2.0.txt` und `kmswindows/liblicenses/` für Details und Lizenzen der verwendeten Bibliotheken.
