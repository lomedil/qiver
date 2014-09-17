import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1
import "engine.js" as QiverEngine

ApplicationWindow {
    id: app
    visible: true
    width: 360
    height: 360
    x: (Screen.width-width)/2
    y: (Screen.height-height)/2


    title: "Qiver"

    FileDialog{
        id: openLocalFileDialog
        title: qsTr("Open QML file")
        onAccepted: loadFile(fileUrl)
    }

    // App properties
    property string fileLoaded: ""
    property bool fitToComponentSize: true

    // Menubar
    menuBar: MenuBar{
        id: menuBar
        Menu{
            title: qsTr("File")

            MenuItem{
                text: qsTr("&Open...")
                onTriggered: openLocalFileDialog.open();
                shortcut: "Alt+O"

            }
            MenuItem{
                text: qsTr("Reload")
                shortcut: "F5"
                onTriggered: reload()

            }

            MenuSeparator{} // -----

            MenuItem{
                text: qsTr("Exit")
            }
        }

        Menu{
            title: qsTr("View")
            MenuItem{
                text: qsTr("Fix to size")
                checkable: true
                checked: app.fitToComponentSize
                onCheckedChanged: app.fitToComponentSize = checked
            }
        }
    }

    // Menu callbacks
    function loadFile(file){
        console.log("Loading " + file);
        app.fileLoaded = file;
        clearLoaded();
        QiverEngine.loadLocalFile(file, client, function(obj, errorString){
            if(!obj){
                errorMessage.text = errorString;
                errorMessage.visible = true;
            }else{
                errorMessage.visible = false;
                if(fitToComponentSize){
                    app.width = obj.width;
                    app.height = obj.height+50; // WORKAROUND: Height of loaded item is not show completed
                }
            }
        });
    }

    function reload(){
        if(app.fileLoaded !== ""){
            loadFile(fileLoaded);
        }
    }

    function clearLoaded(){
        var n = client.children.length;
        for(var i = n-1; i >= 0; --i){
            client.children[i].destroy();
        }
        cacheManager.clearCache();
    }

    // Simple error text
    Text {
        id: errorMessage
        anchors{
            fill: parent
        }
        visible: false
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

    }

    // Client item where loaded object will be shown
    Item{
        id: client
        anchors{
            fill: parent
        }

    }


}
