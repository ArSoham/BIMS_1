QT += quick sql core
CONFIG += c++17
SOURCES += main.cpp \
    databasemanager.cpp \
    inventorymodel.cpp \
    salesmodel.cpp

HEADERS += databasemanager.h \
    inventorymodel.h \
    salesmodel.h

#RESOURCES += resources.qrc

# Additional configurations
# CONFIG += qmltypes
# QML_IMPORT_NAME = com.bims
# QML_IMPORT_MAJOR_VERSION = 1

DISTFILES += \
    main.qml \
    AddItemDialog.qml \
    AddSaleDialog.qml \
    InventoryView.qml \
    SalesView.qml \

