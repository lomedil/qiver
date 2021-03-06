#******************
# Qiver project file
# Author: Jairo Sansegundo
# Date: 16-9-2014

TEMPLATE = app

TARGET = qiver

QT += qml quick

defineReplace(dirFiles){
  dir = $$1/*
  selected_entries =
  all_entries = $$files($$dir)
  # For every entry: select it if it isn't a folder
  for(entry, all_entries):!exists($$entry/*):selected_entries += $$entry
  return($$selected_entries)
}

# Configuring folders ...
UI_DIR = ./gen
MOC_DIR = ./gen
RCC_DIR = ./gen
DESTDIR = ./bin
OBJECTS_DIR = ./temp

INCLUDEPATH +=  ./include

## Files for project
SOURCES = $$dirFiles(./src)

HEADERS += $$dirFiles(./include)

RESOURCES += ./qml/qml.qrc

OTHER_FILES +=  ./qml/main.qml \
                ./qml/dialogs.qml \
                ./qml/Dialogs.qml \
                ./qml/ContentFrame.qml \
                ./qml/OutputPanel.qml \
                ./qml/shared/AwesomeIcon.qml \
                ./qml/shared/awesome.js \
                ./qml/js/engine.js
