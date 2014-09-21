#ifndef _COMPONENTCACHEMANAGER_H_
#define _COMPONENTCACHEMANAGER_H_

#include <QtCore>
#include <QtQml/QQmlEngine>


class ComponentCacheManager : public QObject
{
    Q_OBJECT
public:
    ComponentCacheManager(QQmlEngine *engine);

private:
    QQmlEngine *m_engine;

public:
    const QQmlEngine *engine() const;

public:
    Q_INVOKABLE void clearCache();
};

#endif //_COMPONENTCACHEMANAGER_H_
