#include "salesmodel.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QDateTime>

SalesModel::SalesModel(DatabaseManager *dbManager, QObject *parent)
    : QAbstractListModel(parent), m_dbManager(dbManager)
{
    refresh();
}

int SalesModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    QSqlQuery query(m_dbManager->database());
    query.exec("SELECT COUNT(*) FROM Sales");
    if (query.next())
        return query.value(0).toInt();
    return 0;
}

QVariant SalesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    QSqlQuery query(m_dbManager->database());
    query.prepare("SELECT * FROM Sales ORDER BY sale_date DESC LIMIT 1 OFFSET :offset");
    query.bindValue(":offset", index.row());

    if (!query.exec() || !query.next())
        return QVariant();

    switch (role) {
    case IdRole:
        return query.value("id");
    case ItemIdRole:
        return query.value("item_id");
    case QuantityRole:
        return query.value("quantity");
    case TotalPriceRole:
        return query.value("total_price");
    case SaleDateRole:
        return query.value("sale_date");
    }

    return QVariant();
}

QHash<int, QByteArray> SalesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[ItemIdRole] = "itemId";
    roles[QuantityRole] = "quantity";
    roles[TotalPriceRole] = "totalPrice";
    roles[SaleDateRole] = "saleDate";
    return roles;
}

bool SalesModel::addSale(int itemId, int quantity, double totalPrice)
{
    QSqlQuery query(m_dbManager->database());
    query.prepare("INSERT INTO Sales (item_id, quantity, total_price, sale_date) "
                  "VALUES (:itemId, :quantity, :totalPrice, :saleDate)");
    query.bindValue(":itemId", itemId);
    query.bindValue(":quantity", quantity);
    query.bindValue(":totalPrice", totalPrice);
    query.bindValue(":saleDate", QDateTime::currentDateTime());

    if (!query.exec()) {
        qWarning() << "Failed to add sale:" << query.lastError().text();
        return false;
    }

    // Update inventory quantity
    query.prepare("UPDATE Inventory SET quantity = quantity - :soldQuantity WHERE id = :itemId");
    query.bindValue(":soldQuantity", quantity);
    query.bindValue(":itemId", itemId);

    if (!query.exec()) {
        qWarning() << "Failed to update inventory quantity:" << query.lastError().text();
        return false;
    }

    refresh();
    return true;
}

void SalesModel::refresh()
{
    beginResetModel();
    endResetModel();
}
