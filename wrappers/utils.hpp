#pragma once

#include <QVariant>

namespace crudpp
{
template <typename T>
QVariant to_qt(T v)
    requires std::is_integral_v<T>
{ return QVariant{v}; }

template <typename T>
QVariant to_qt(T v)
    requires std::is_enum_v<T>
{ return QVariant{v}; }

QString to_qt(const std::string& s)
{ return QString::fromStdString(s); }

template <typename T>
T from_qt(const QVariant& v)
    requires std::is_integral_v<T>
{ return v.toInt(); }

template <typename T>
T from_qt(const QVariant& v)
    requires std::is_enum_v<T>
{ return v.toInt(); }

template <typename T>
T from_qt(const QVariant& v)
    requires std::is_same_v<T, std::string>
{ return v.toString().toStdString(); }

}; // namespace crudpp
