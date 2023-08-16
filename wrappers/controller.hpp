#pragma once

#include <QObject>

#include <wobjectdefs.h>
#include <wobjectimpl.h>

#include "model.hpp"
#include "list.hpp"

namespace crudpp
{
template <typename T>
struct controller final : QObject
{
    W_OBJECT(controller)

    static list<model<T>> list{new list<model<T>>{}}
}

W_OBJECT_IMPL(controller<T>, template <typename T>);

} // namespace crudpp
