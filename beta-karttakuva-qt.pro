TARGET = beta-karttakuva-qt
TEMPLATE = app

QT += quick qml network positioning location sql svg widgets
SOURCES = main.cpp

RESOURCES += \
    beta-karttakuva-qt.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/location/beta-karttakuva-qt
INSTALLS += target

DISTFILES +=

ANDROID_EXTRA_LIBS = /Users/jkorhonen/GitHub/beta-karttakuva-qt/../../ssh/openssl-1.1.1f-x86/libssl_1_1.so $$PWD/../../ssh/openssl-1.1.1f-x86/libcrypto_1_1.so
ANDROID_EXTRA_PLUGINS = /Users/jkorhonen/GitHub/beta-karttakuva-qt/x86/plugins/geoservices
