import QtQuick 2.0
import QtQuick.Dialogs 1.0


Item{

    property alias openLocalQmlFileDialog: openLocalFileDialog_
    property alias customSizeDialog: customSizeDialog_
    property alias importPathDialog: importPathDialog_

    FileDialog{
        id: openLocalFileDialog_
        title: qsTr("Open QML file")
        onAccepted: console.log("Accepting file " + fileUrl)
        nameFilters: [ "QML files (*.qml)" ]
    }

    CustomSizeDialog{
        id: customSizeDialog_
    }

    FileDialog{
        id: importPathDialog_
        title: qsTr("Add import path");
        selectFolder: true
    }
}
