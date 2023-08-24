#pragma once

#include <QObject>

#include <wobjectdefs.h>

#include <crudpp/utils.hpp>
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
        bridge::instance().context()->setContextProperty(T::table(), m_list);

        connect(m_list,
                &list<T>::validate,
                this,
                [this] (int row)
                {
                    QJsonObject obj{};
                    auto& item{m_list->item_at(row)};
                    item.write(obj);

                    // update if primary key is written
                    if (obj.contains(to_qt(get_primary_key_name<T>())))
                    {
                        // skip if nothing needs updating
                        if (obj.size() == 1) return;

                        net_manager::instance().putToKey(make_key(item).c_str(),
                            QJsonDocument{obj}.toJson(),
                            [&item](const QJsonObject& rep)
                            { item.reset_flags(); },
                            "Validate error");
                    }
                    else // insert otherwise
                    {
                        net_manager::instance().postToKey(T::table(),
                            QJsonDocument{obj}.toJson(),
                            [&item](const QJsonObject& rep)
                            { item.read(rep); },
                            "Add error");

                    }
                });

        connect(m_list,
                &list<T>::remove,
                this,
                [this] (int row)
                {
                    net_manager::instance().deleteToKey(make_key(m_list->item_at(row)).c_str(),
                        [this, row](const QJsonValue& rep)
                        { m_list->removeItems(row, row); },
                        "Remove Error");
                });

//        this->connect(m_list,
//                      &list<T>::add,
//                      this,
//                      [this] ()
//                      {
//                          net_manager::instance().postToKey(this->inner->key,
//                              QByteArray{},
//                              [this](const Json::Value& rep)
//                              { this->inner->appendWith(rep); },
//                              "Add error");
//                      });

//        this->connect(this->inner,
//                      &Inner::addWith,
//                      this,
//                      [this] (const QJsonObject& obj)
//                      {
//                          QJsonDocument doc{obj};
//                          QByteArray data{doc.toJson()};

//                          Json::Value val;
//                          Json::Reader reader;
//                          reader.parse(data.toStdString(), val);

//                          Interface::netManager::instance().postToKey(this->inner->key,
//                              data,
//                              [this, val](const Json::Value& res)
//                              {
//                                  Json::Value concat{val};
//                                  concatenate(concat, res);
//                                  this->inner->appendWith(concat);
//                              },
//                              "addWith error");
//                      });
    }

    void get()
    {
        net_manager::instance().getFromKey(T::table(),
                                           [this](const QByteArray& bytes)
                                           { m_list->read(bytes); });
    }

    const std::string make_key(model<T>&& item) const
    {
        return make_key(std::move(item));
    }

    const std::string make_key(model<T>& item) const
    {
        std::string key{T::table()};
        key += '/';
        key += std::to_string((item.get_aggregate().*T::primary_key()).value);
        return key;
    }

    static list<T>* m_list;
};

template <typename T>
list<T>* controller<T>::m_list{new list<T>{}};

} // namespace crudpp

#include <wobjectimpl.h>
W_OBJECT_IMPL(crudpp::controller<T>, template <typename T>);
