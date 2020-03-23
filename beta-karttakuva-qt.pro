TARGET = beta-karttakuva-qt
TEMPLATE = app

QT += quick qml network positioning location
SOURCES = main.cpp

RESOURCES += \
    beta-karttakuva-qt.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/location/beta-karttakuva-qt
INSTALLS += target

DISTFILES +=

