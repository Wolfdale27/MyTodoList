#ifndef TASKMANAGER_H
#define TASKMANAGER_H


#include <QtQml>
#include <QObject>
#include <memory>
#include "task.h"


class TaskManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit TaskManager(QObject *parent = nullptr);

    Q_INVOKABLE void setData(const QString& f_name, const QString& f_description, const QDateTime& f_datetime, const bool& f_isCompleted);
    Q_INVOKABLE QVector<Task>::iterator dataBegin();
    Q_INVOKABLE QVector<Task>::iterator dataEnd();
    Q_INVOKABLE void saveData();
    //void deleteData(const int& index);

private:
    std::unique_ptr<Task> currentTask;
    QVector<Task> m_data;
};

#endif // TASKMANAGER_H
