#pragma once

#include <QAbstractListModel>
#include "databasemanager.h"

class SalesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum SalesRoles {
        IdRole = Qt::UserRole + 1,
        ItemIdRole,
        QuantityRole,
        TotalPriceRole,
        SaleDateRole
    };

    explicit SalesModel(DatabaseManager *dbManager, QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE bool addSale(int itemId, int quantity, double totalPrice);

private:
    DatabaseManager *m_dbManager;
    void refresh();
};

