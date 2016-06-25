#ifndef _MODULEMANAGER_H_
#define _MODULEMANAGER_H_

#include <QtCore>

class ModuleManager : public QObject
{
    Q_OBJECT

public:
    ModuleManager(QObject *parent = 0);

public slots:
    void addImportPath(const QString &path);
};

#endif //_MODULEMANAGER_H_
