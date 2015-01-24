import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: app
    visible: true
    width: 1024
    height: 768
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
    property bool showOutputPanel: true

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
            MenuItem{
                text: checked ? qsTr("Hide ouput") : qsTr("Show Output")
                checked: showOutputPanel
                checkable: true
                onToggled: showOutputPanel = checked

            }
        }
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
        anchors.fill: parent
        orientation: Qt.Vertical


        // Client item where loaded object will be shown
        ContentFrame{
            id: contentframe

            Layout.fillHeight: true
            Layout.fillWidth: true

            onContentCleared: cacheManager.clearCache() //Flush the whole cache

        }

        Item{
            id: panelsFrame


            Layout.fillWidth: true
            Layout.maximumHeight: parent.height/2
            implicitHeight: 200
            height: visible ? implicitHeight : 0

            visible: showOutputPanel


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
