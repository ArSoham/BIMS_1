#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "databasemanager.h"
#include "inventorymodel.h"
#include "salesmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<inventorymodel>("com.bims", 1, 0, "InventoryModel");
    qmlRegisterType<SalesModel>("com.bims", 1, 0, "SalesModel");

    DatabaseManager dbManager;
    if (!dbManager.initialize()) {
        qCritical() << "Failed to initialize database";
        return -1;
    }

    inventorymodel inventorymodel(&dbManager, nullptr);
    SalesModel salesModel(&dbManager);

    QQmlApplicationEngine engine;
     // engine.rootContext()->setContextProperty("inventorymodel", &inventorymodel);
     engine.rootContext()->setContextProperty("salesModel", &salesModel);

    const QUrl url(QStringLiteral("../../main.qml"));
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
