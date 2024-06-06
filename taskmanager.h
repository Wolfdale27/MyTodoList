#ifndef TASKMANAGER_H
#define TASKMANAGER_H


#include <QtQml>
#include <QObject>
#include "task.h"


class TaskManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    //Q_PROPERTY(Task data READ data WRITE setData NOTIFY dataChanged FINAL)
public:
    explicit TaskManager(QObject *parent = nullptr);

    Task data() const;
    Q_INVOKABLE void setData(const QString& f_name, const QString& f_description, const QDateTime& f_datetime, const bool& f_isCompleted);
    //void deleteData(const int& index);

signals:
    void dataChanged();
private:
    Task* currentTask;
    QVector<Task> m_data;
};



#endif // TASKMANAGER_H
