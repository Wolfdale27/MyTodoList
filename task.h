#ifndef TASK_H
#define TASK_H

#include "qdatetime.h"


struct Task
{
    Task() = default;
    ~Task() = default;
    QString m_name;
    QString m_description;
    QDateTime m_datetime;
    bool m_isCompleted;

    Task& operator=(const Task& other);

    bool operator==(const Task& other) const;

};

#endif // TASK_H
