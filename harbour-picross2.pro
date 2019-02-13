# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-picross2

CONFIG += sailfishapp_qml

QT += sql core

DISTFILES += \
    qml/components/Case.qml \
    qml/components/Cursor.qml \
    qml/components/Grille.qml \
    qml/components/Key.qml \
    qml/components/KeyPad.qml \
    qml/components/SolvedGrid.qml \
    qml/components/UnZoomButton.qml \
    qml/components/WholeGrid.qml \
    qml/pages/About.qml \
    qml/pages/MainPage.qml \
    qml/pages/NewGame.qml \
    qml/pages/ScorePage.qml \
    qml/pages/Settings.qml \
    qml/pages/Translations.qml\
    qml/pages/WhatsNew.qml \
    qml/DB.js \
    qml/Levels.js \
    qml/Source.js \
    qml/harbour-picross2.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-picross2.yaml \
    rpm/harbour-picross2.spec \
    rpm/harbour-picross2.changes \
    scripts/genPicross.sh \
    harbour-picross2.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

OTHER_FILES += translations/*.ts

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += \
    translations/*.ts
