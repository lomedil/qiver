#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <ComponentCacheManager.h>
#include <QtGlobal>
#include <OutputDataModel.h>

static OutputDataModel *outputModel;
static QtMessageHandler originalMessageHandler;

void myMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg);

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    outputModel = new OutputDataModel();
    originalMessageHandler = qInstallMessageHandler(myMessageHandler);

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
