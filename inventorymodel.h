#pragma once
#include<databasemanager.h>


class inventorymodel
{
public:

   explicit inventorymodel(DatabaseManager *dbManager, QObject *parent);
    // enum InventoryRoles {
    //     IdRole = Qt::UserRole + 1,
    //     NameRole,
    //     QuantityRole,
    //     PriceRole
    // };



    // int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    // QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    // QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addItem(const QString &name, int quantity, double price);
    Q_INVOKABLE void updateItem(int id, const QString &name, int quantity, double price);
    Q_INVOKABLE void deleteItem(int id);

private:
    DatabaseManager *m_dbManager;
    void refresh();
};




