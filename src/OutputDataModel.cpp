#include <OutputDataModel.h>


OutputDataModel::OutputDataModel() :
    m_onlyQmlFiles(true)
{

}

OutputDataModel::~OutputDataModel()
{

}

int OutputDataModel::count() const
{
    return m_entries.count();
}

int OutputDataModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return count();
}

QVariant OutputDataModel::data(const QModelIndex &index, int role) const
{
    if(index.isValid() == false) return QVariant();

    int row = index.row();
    if(row < 0 || row >= count()) return QVariant();

    const OutputEntry &entry = m_entries[row];

    switch (role) {
    case MessageRole:
        return QString(entry.msg);

    case TypeRole:
        return (int) entry.type;

    case FileRole:
        return entry.file;

    case LineRole:
        return entry.line;


    default:
        break;
    }

    return QVariant();
}

QHash<int, QByteArray> OutputDataModel::roleNames() const
{
    QHash<int, QByteArray> temp;

    temp[TypeRole] =        "type";
    temp[MessageRole] =     "message";
    temp[FileRole] =        "file";
    temp[FunctionRole] =    "function";
    temp[LineRole] =        "line";

    return temp;
}

void OutputDataModel::addOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    int newIndex = m_entries.count();

    QString file = context.file;

    // Ignore resources files
    if(file.startsWith("qrc:///", Qt::CaseInsensitive)) return;

    // Only QML files console output
    if(m_onlyQmlFiles)
    {
        if(!file.endsWith(".qml", Qt::CaseInsensitive)) return;
    }

    OutputEntry newEntry;
    newEntry.type = type;
    newEntry.file = context.file;
    newEntry.function = context.function;
    newEntry.line = context.line;
    newEntry.msg = msg;

    beginInsertRows(QModelIndex(), newIndex, newIndex);
    m_entries << newEntry;
    endInsertRows();

    emit countChanged();

}

void OutputDataModel::clearAll()
{
    beginResetModel();
    m_entries.clear();
    endResetModel();
}

bool OutputDataModel::onlyQmlFiles() const
{
    return m_onlyQmlFiles;
}

void OutputDataModel::setOnlyQmlFiles(bool value)
{
    if(m_onlyQmlFiles == value) return;

    m_onlyQmlFiles = value;
}
