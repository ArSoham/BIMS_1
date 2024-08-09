#pragma once

#include <QObject>
#include <QSqlDatabase>

class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(QObject *parent = nullptr);
    bool initialize();
    QSqlDatabase database() const;

private:
    QSqlDatabase m_db;
    bool createTables();
};

