#include <ModuleManager.h>
#include <QtQml>


ModuleManager::ModuleManager(QObject *parent) :
    QObject(parent)
{

}

void ModuleManager::addImportPath(const QString &path)
{
    QQmlEngine *engine = qmlEngine(this);

    engine->addImportPath(path);
    engine->clearComponentCache();
    engine->trimComponentCache();
    engine->collectGarbage();
    qDebug() << engine->importPathList();
}
