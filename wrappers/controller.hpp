#pragma once

#include <QObject>

#include <wobjectdefs.h>

#include "list.hpp"

namespace crudpp
{
template <typename T>
class controller final : QObject
{
    W_OBJECT(controller)

public:
    explicit controller()
        : QObject{}
    {}

    static list<T> m_list;
};

template <typename T>
list<T> controller<T>::m_list{new list<T>};

} // namespace crudpp

#include <wobjectimpl.h>
W_OBJECT_IMPL(crudpp::controller<T>, template <typename T>);
