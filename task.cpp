#include "task.h"



Task &Task::operator=(const Task& other)
{
    if (this == &other)
        return *this;

    m_name = other.m_name;
    m_description = other.m_description;
    m_datetime = other.m_datetime;
    m_isCompleted = other.m_isCompleted;

    return *this;
}

bool Task::operator==(const Task& other) const
{
    return m_name == other.m_name &&
           m_description == other.m_description &&
           m_datetime == other.m_datetime;
}
