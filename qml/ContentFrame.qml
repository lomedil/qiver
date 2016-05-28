import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 200
    height: 200

    default property alias content: client.data

    property Component contentComponent
    property Item contentItem

    property string source
    property string error
    property bool fitToComponentSize: true

    property int portviewWidth: 800
    property int portviewHeight: 600
    property int portviewOrientation: Qt.Horizontal

    signal contentCleared()

    function clearContent(){
        if(contentItem) contentItem.destroy()
        if(contentComponent) contentComponent.destroy();
        contentCleared();
    }

    function reload(){
        if(source !== ""){
            loadFile(source);
        }
    }

    function loadFile(file){
        clearContent();
        console.log("Loading " + file);
        root.source = file;

        var newComponent = Qt.createComponent(file);
        if(newComponent.status === Component.Error){
            error = newComponent.errorString();
            console.log("Error loading component: "+ error);
        }else{
            contentComponent = newComponent;
            error = "";

            console.log("QML component loaded successfuly");

            var newObject = contentComponent.createObject(client, {"anchors.centerIn": client});
            contentItem = newObject;

        }
    }

    RectangularGlow {
            id: effect
            anchors.fill: client
            glowRadius: 10
            spread: 0.2
            color: "#ddd"
            cornerRadius: glowRadius
        }

    Rectangle{
        anchors.fill: client
        color: "white"

    }

    Item{
        id: client
        anchors.centerIn: parent
        width: portviewOrientation == Qt.Horizontal ? portviewWidth : portviewHeight
        height: portviewOrientation == Qt.Horizontal ? portviewHeight : portviewWidth
    }
}
