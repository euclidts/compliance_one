#pragma once

#include <QObject>
#include <QQmlApplicationEngine>

#include <wobjectdefs.h>
#include "../wrappers/controller.hpp"

#include "net_manager.hpp"

class QQmlContext;

namespace crudpp
{
class bridge final : public QObject
{
    W_OBJECT(bridge)

public:
    static bridge& instance();
    void init() { engine = new QQmlApplicationEngine{}; }

    template <typename ...Types>
    void registerQml()
    {
        (qmlRegisterType<Types>(Types::table(), 1, 0, Types::table()), ...);
    }

    bridge(bridge const&) = delete;
    void operator = (bridge const&) = delete;

    QQmlContext* context() { return engine->rootContext(); }

    void onLogin(bool success, const QString& errorString) const
    {
        QMetaObject::invokeMethod(qmlObject,
                                  "onLogin",
                                  Q_ARG(bool, success),
                                  Q_ARG(QString, errorString));
    }

    void onException(const QString& prefix,
                     const QString& errorString) const
    {
        QMetaObject::invokeMethod(qmlObject,
                                  "onException",
                                  Q_ARG(QString, prefix),
                                  Q_ARG(QString, errorString));
    }

    void authenticate(const QString& username, const QString& password) const
    {
        net_manager::instance().authenticate(username, password);
    }
    W_INVOKABLE(authenticate, (const QString&, const QString&))

    void updatePwd(const QString& newPwd) const
    {
        QJsonObject json;
        json["password"] = newPwd;

        changePwd("changePassword", json);
    }
    W_INVOKABLE(updatePwd)

    void resetPwd(int id) const
    {
        QJsonObject json;
        json["id"] = id;

        changePwd("resetPassword", json);
    }
    W_INVOKABLE(resetPwd)

    void setQmlObject(QObject* obj) noexcept { qmlObject = obj; };

    bool hasFlag(int value, int flag) const noexcept
    {
        return value & flag;
    }
    W_INVOKABLE(hasFlag, (int, int))

    void logout() const
    W_SIGNAL(logout)

    float getDownloadProgress() const;
    void setDownloadProgress(float newDownloadProgress);
    void downloadProgressChanged()
    W_SIGNAL(downloadProgressChanged);

    W_PROPERTY(float, downloadProgress READ getDownloadProgress WRITE setDownloadProgress NOTIFY downloadProgressChanged)

private:
    bridge() {};

    QObject* qmlObject;
    QQmlApplicationEngine* engine;

    void changePwd(const char* key, const QJsonObject& json) const;
};

} // namespace crudpp

#include <wobjectimpl.h>
W_OBJECT_IMPL(crudpp::bridge);
