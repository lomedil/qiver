#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QtQml>
#include <ComponentCacheManager.h>
#include <QtGlobal>
#include <OutputDataModel.h>
#include <ModuleManager.h>

static OutputDataModel *outputModel;
static QtMessageHandler originalMessageHandler;

void myMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);
void registerQmlTypes();

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    outputModel = new OutputDataModel();
    originalMessageHandler = qInstallMessageHandler(myMessageHandler);

    registerQmlTypes();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    engine.rootContext()->setContextProperty("cacheManager", new ComponentCacheManager(&engine));
    engine.rootContext()->setContextProperty("outputModel", outputModel);

    return app.exec();

    delete outputModel;
}

void myMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    outputModel->addOutput(type, context, msg);
    originalMessageHandler(type, context, msg);
}

void registerQmlTypes()
{
    qmlRegisterType<ModuleManager>("Qiver", 1, 0, "ModuleManager");
}
