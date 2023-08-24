#pragma once

#include <QJsonObject>
#include "qnamespace.h"

#include <boost/pfr/core.hpp>

#include <crudpp/required.hpp>
#include <crudpp/utils.hpp>

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
                                       // prevent from manually setting primary key
                                       if constexpr (is_primary_key<decltype(f), T>)
                                           return;

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
                                           const auto new_val{from_qt<decltype(f.value)>(v)};

                                           if (f.value != new_val)
                                           {
                                               f.value = new_val;
                                               dirtyFlag_[i] = true;
                                           }
                                       }
                                   });
    }
    // --

    void read(const QJsonObject& obj)
    {
        boost::pfr::for_each_field(aggregate, crudpp::visitor::json_reader{.json = obj});
        reset_flags();
    }

    void write(QJsonObject& obj)
    {
        boost::pfr::for_each_field(aggregate,
                                   [&obj, this](const r_c_name auto& f, size_t i)
                                   {
                                       if constexpr (is_primary_key<decltype(f), T>)
                                       {
                                           // skip primary key for insert
                                           // ie. when it's flag is true (default)
                                           if (dirtyFlag_[i]) return;
                                       }
                                       else
                                       {
                                           // skip non primary key values that have not been updated
                                           if (!dirtyFlag_[i]) return;
                                       }

                                       obj[f.c_name()] = to_qt(f.value);
                                   });
    }

    // set all flags to false
    void reset_flags()
    {
        for (bool& v : dirtyFlag_)
            if (v) v = false;

    }

    // check if the item was inserted in the database
    // ie. if it's primary key is not flagged
    bool inserted()
    {
        return !dirtyFlag_[primary_key_index];
    }

    T& get_aggregate() { return aggregate; };

private:

    // all true by default to set all fields upon insert
    bool dirtyFlag_[boost::pfr::tuple_size<T>::value] = { true };
    T aggregate{};

    static const size_t primary_key_index;
};

template <typename T>
const size_t model<T>::primary_key_index{get_primary_key_index<T>()};

} // namespace crudpp
