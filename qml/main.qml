import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import "."

ApplicationWindow {
    id: app
    visible: true
    width: 1024
    height: 768
    x: (Screen.width-width)/2
    y: (Screen.height-height)/2


    title: "Qiver (%1x%2)".arg(contentframe.portviewWidth).arg(contentframe.portviewHeight)

    Dialogs{
        id: dialogs
        Component.onCompleted: {
            openLocalQmlFileDialog.accepted.connect(
                        function(){
                            contentframe.loadFile(openLocalQmlFileDialog.fileUrl)
                        });
            customSizeDialog.accepted.connect(
                        function(){
                            var size = customSizeDialog.customSize;
                            if(size == Qt.size(0,0)) return;
                            contentframe.portviewHeight = size.height;
                            contentframe.portviewWidth = size.width;
                        });
        }
    }

    // App properties
    property alias fileLoaded: contentframe.source
    property bool showOutputPanel: true

    // Menubar
    menuBar: QiverMenuBar{
        id: menu
        onReloadClicked: contentframe.reload();
        onOpenFileClicked: dialogs.openLocalQmlFileDialog.open()
        onExitClicked: app.close()
        showOutputPanel: true
        onCustomSizeClicked: dialogs.customSizeDialog.open()
    }


    // Simple error text
    Text {
        id: errorMessage
        anchors{
            fill: parent
        }
        text: contentframe.error
        visible: text != ""
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        z: 1

    }

    SplitView{
        id: splitter
        anchors.fill: parent
        orientation: menu.portviewOrientation==Qt.Vertical ? Qt.Horizontal : Qt.Vertical


        // Client item where loaded object will be shown
        ContentFrame{
            id: contentframe

            Layout.fillHeight: true
            Layout.fillWidth: true

            onContentCleared: cacheManager.clearCache() //Flush the whole cache

            portviewHeight: menu.portviewSizeSelected.height
            portviewWidth: menu.portviewSizeSelected.width
            portviewOrientation: menu.portviewOrientation

        }

        Item{
            id: panelsFrame


            Layout.fillWidth: splitter.orientation == Qt.Vertical
            Layout.fillHeight: splitter.orientation == Qt.Horizontal

            implicitHeight: 200
            implicitWidth: 200


            visible: menu.showOutputPanel


            TabView{
                anchors.fill: parent

                Tab{
                    title: qsTr("Ouput")
                    OutputPanel{
                        anchors.fill: parent
                        anchors.margins: 10
                        model: outputModel
                    }
                }
            }
        }
    }


}
