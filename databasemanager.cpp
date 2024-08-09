#include "databasemanager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject(parent)
{
}

bool DatabaseManager::initialize()
{
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("bims.db");

    if (!m_db.open()) {
        qCritical() << "Failed to open database:" << m_db.lastError().text();
        return false;
    }

    return createTables();
}

QSqlDatabase DatabaseManager::database() const
{
    return m_db;
}

bool DatabaseManager::createTables()
{
    QSqlQuery query;

    // Create Inventory table
    if (!query.exec("CREATE TABLE IF NOT EXISTS Inventory "
                    "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "name TEXT, "
                    "quantity INTEGER, "
                    "price REAL)")) {
        qCritical() << "Failed to create Inventory table:" << query.lastError().text();
        return false;
    }

    // Create Sales table
    if (!query.exec("CREATE TABLE IF NOT EXISTS Sales "
                    "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "item_id INTEGER, "
                    "quantity INTEGER, "
                    "total_price REAL, "
                    "sale_date DATETIME, "
                    "FOREIGN KEY(item_id) REFERENCES Inventory(id))")) {
        qCritical() << "Failed to create Sales table:" << query.lastError().text();
        return false;
    }

    return true;
}
