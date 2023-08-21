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
        bridge::instance().context()->setContextProperty(T::table(), m_list);

        connect(m_list,
                &list<T>::validate,
                this,
                [this] (const QModelIndex& index)
                {
                    QJsonObject obj{};
                    auto& item{m_list->item_at(index.row())};
                    item.write(obj);

                    net_manager::instance().putToKey(T::table(),
                        QJsonDocument{obj}.toJson(),
                        [](const QJsonObject& rep)
                        {},
                        "Validate error");
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

    static list<T>* m_list;
};

template <typename T>
list<T>* controller<T>::m_list{new list<T>{}};

} // namespace crudpp

#include <wobjectimpl.h>
W_OBJECT_IMPL(crudpp::controller<T>, template <typename T>);
