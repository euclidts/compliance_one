#pragma once

#include <QObject>

#include <wobjectdefs.h>

#include "../interface/bridge.hpp"
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
    {
        const auto uri{make_uri<T>()};

        qmlRegisterUncreatableType<T>(uri.c_str(), 1, 0, uri.c_str(), "");
        bridge::instance().context()->setContextProperty(T::table(), &m_list);
    }

    void get()
    {
        net_manager::instance().getFromKey(T::table(),
                                           [this](const QByteArray& bytes)
                                           { m_list.read(bytes); });
    }

    static list<T> m_list;
};

template <typename T>
list<T> controller<T>::m_list{};

} // namespace crudpp

#include <wobjectimpl.h>
W_OBJECT_IMPL(crudpp::controller<T>, template <typename T>);
