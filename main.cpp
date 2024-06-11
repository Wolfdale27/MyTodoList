#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("Bridges Company&");
    app.setOrganizationDomain("somedomain.com");
    app.setApplicationName("TODO app");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/todo_manager/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
