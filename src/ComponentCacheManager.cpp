#include <ComponentCacheManager.h>

ComponentCacheManager::ComponentCacheManager(QQmlEngine *engine) :
    QObject(0),
    m_engine(engine)
{
}

const QQmlEngine *ComponentCacheManager::engine() const
{
    return m_engine;
}

void ComponentCacheManager::clearCache()
{
    m_engine->clearComponentCache();
}


