#include <QGuiApplication>
#include <QQmlApplicationEngine>

//#include <netManager.hpp>
//#include <bridge.hpp>

//#include <bindigs/qt/list.hpp>
#include "wrappers/list.hpp"
#include "sovereignty.hpp"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    using namespace crudpp;

    list<sovereignty> l{};

//    qDebug() << "Device supports OpenSSL: " << QSslSocket::supportsSsl();

    QString host{"http://127.0.0.0:8080"};

    for (int i = 0; i < argc; i++)
        if (QString::compare(argv[i], "--host") == 0)
        {
            host = argv[i + 1];
            break;
        }

    qDebug() << "Host :" << host;

//    using namespace Interface;

//    bridge::instance().init();

//    netManager::instance().init(host,
//                                "auth",
//                                "format=json&jsconfig=TreatEnumAsInteger");

//    client::instance().init();

//    // qml engine
//    const QUrl url(QStringLiteral("qrc:/ui/main.qml"));
//    QObject::connect(bridge::instance().engine,
//        &QQmlApplicationEngine::objectCreated,
//        &app,
//        [url]
//        (QObject* obj, const QUrl &objUrl)
//        {
//            if (!obj && url == objUrl)
//                QCoreApplication::exit(-1);
//            else
//                bridge::instance().setQmlObject(obj);
//        }, Qt::QueuedConnection);

//    bridge::instance().engine->load(url);

    return app.exec();
}
