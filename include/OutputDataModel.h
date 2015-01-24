#ifndef OUTPUTDATAMODEL_H
#define OUTPUTDATAMODEL_H


#include <QtCore>
#include <QAbstractListModel>

class OutputDataModel : public QAbstractListModel
{
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_OBJECT
public:
    OutputDataModel();

    virtual ~OutputDataModel();

    // Inner structures
private:
    struct OutputEntry
    {
        QtMsgType type;
        QString file;
        QString function;
        int line;
        QString msg;
    };

    // Rolenames for model
public:
    enum {
        TypeRole = Qt::UserRole+1,
        MessageRole,
        FileRole,
        FunctionRole,
        LineRole
    };

    // Setters & getters for properties
public:
    int count() const;

    // Signals for properties
signals:
    void countChanged();


    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    // Methods
public:
    void addOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg);

    Q_INVOKABLE void clearAll();

    bool onlyQmlFiles() const;
    void setOnlyQmlFiles(bool value);


    // Variables
private:
    QList<OutputEntry>  m_entries;
    bool m_onlyQmlFiles;

};


#endif // OUTPUTDATAMODEL_H
