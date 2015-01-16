import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1

ApplicationWindow {
    id: app
    visible: true
    width: 800
    height: 600
    x: (Screen.width-width)/2
    y: (Screen.height-height)/2


    title: "Qiver"

    Dialogs{
        id: dialogs
        Component.onCompleted: {
            openLocalQmlFileDialog.accepted.connect(
                        function(){
                            contentframe.loadFile(openLocalQmlFileDialog.fileUrl)
                        });
        }
    }

    // App properties
    property alias fileLoaded: contentframe.source
    property bool fitToComponentSize: true

    // Menubar
    menuBar: MenuBar{
        id: menuBar
        Menu{
            title: qsTr("File")

            MenuItem{
                text: qsTr("&Open...")
                onTriggered: {
                    dialogs.openLocalQmlFileDialog.open();
                }
                shortcut: "Alt+O"

            }
            MenuItem{
                text: qsTr("Reload")
                shortcut: "F5"
                onTriggered: contentframe.reload()

            }

            MenuSeparator{} // -----

            MenuItem{
                text: qsTr("Exit")
            }
        }

        Menu{
            title: qsTr("View")
        }
    }

    // Menu callbacks




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

    // Client item where loaded object will be shown
    ContentFrame{
        id: contentframe
        anchors{
            fill: parent
        }

        onContentCleared: cacheManager.clearCache() //Flush the whole cache

    }


}
