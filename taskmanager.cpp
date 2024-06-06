#include "taskmanager.h"

TaskManager::TaskManager(QObject *parent)
    : QObject{parent}
{}

Task TaskManager::data() const
{

}

void TaskManager::setData(const QString& f_name, const QString& f_description, const QDateTime& f_datetime, const bool& f_isCompleted)
{
    currentTask = new Task();// тут мог бы быть segfault :)
    currentTask->m_name = f_name;
    currentTask->m_description = f_description;
    currentTask->m_datetime = f_datetime;
    currentTask->m_isCompleted = f_isCompleted;
    m_data.emplace_back(*currentTask);
    for (auto& i : m_data){
        qDebug() << i.m_name;
        qDebug() << i.m_description;
        qDebug() << i.m_datetime;
        qDebug() << i.m_isCompleted;
    }//проверка корректности данных
    delete currentTask;
    emit dataChanged();
}


