#include <QDebug>
#include <QFAppDispatcher>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QuickFlux>

int main(int argc, char *argv[])
{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    registerQuickFluxQmlTypes();

    engine.addImportPath("qrc:/");
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if(!obj && url == objUrl)
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    auto dispatcher = QFAppDispatcher::instance(&engine);

    QObject::connect(
        dispatcher, &QFAppDispatcher::dispatched, &app, [](QString type, QJSValue message) {
            qInfo() << "type: " << type << " content: " << message.toString();
        });

    dispatcher->dispatch("startApp");

    engine.load(url);
    return app.exec();
}
