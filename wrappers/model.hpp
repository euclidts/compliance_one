#pragma once

#include <QJsonObject>
#include "qnamespace.h"

#include <boost/pfr/core.hpp>
#include <concepts/required.hpp>

#include "utils.hpp"
#include "../visitors/json_reader.hpp"

namespace crudpp
{
template <typename T>
struct model final
{
    static const constexpr auto table() { return T::table(); }

    model(const QJsonObject& json) { read(json); }
    model() = default;

    static QHash<int, QByteArray> roleNames()
    {
        static QHash<int, QByteArray> rn{};

        if (!rn.empty())
            return rn;

        boost::pfr::for_each_field(T{},
                                   [](const r_c_name auto& f, size_t i)
                                   { rn[i + Qt::UserRole] = f.c_name(); });
        return rn;
    }

    // FIXME
    // very ineficiant !! replace with avendish introspection lib
    // --
    QVariant data(int role) const
    {
        QVariant v{};

        boost::pfr::for_each_field(aggregate,
                                   [&v, role](const auto& f, size_t i)
                                   {
                                       if (role - Qt::UserRole == i)
                                           v = to_qt(f.value);
                                   });
        return v;
    }

    void setData(const QVariant& v, int role)
    {
        boost::pfr::for_each_field(aggregate,
                                   [&v, role, this](auto& f, size_t i)
                                   {
                                       if (role - Qt::UserRole == i)
                                       {
                                           f.value = from_qt<decltype(f.value)>(v);
                                           dirtyFlag_[i] = true;
                                       }
                                   });
    }
    // --

    void read(const QJsonObject& obj)
    {
        boost::pfr::for_each_field(aggregate, crudpp::visitor::json_reader{.json = obj});
    }

    void write(QJsonObject& obj)
    {
        boost::pfr::for_each_field(aggregate,
                                   [&obj, this](const r_c_name auto& f, size_t i)
                                   {
                                       // skip values that have not been updated, unless it is a primary key
                                       if constexpr (!is_primary_key<decltype(f), T>)
                                           if (!dirtyFlag_[i]) return;

                                       obj[f.c_name()] = f.value;
                                   });
    }

    T& get_aggregate() { return aggregate; };

private:
    bool dirtyFlag_[boost::pfr::tuple_size<T>::value] = { false };
    T aggregate{};
};

} // namespace crudpp
