import QtQuick 2.0

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
        console.log("Loading " + file);
        root.source = file;

        var newComponent = Qt.createComponent(file);
        if(newComponent.status === Component.Error){
            error = newComponent.errorString();
            console.log("Error loading component: "+ error);
        }else{
            clearContent();
            contentComponent = newComponent;
            error = "";

            console.log("QML component loaded successfuly");

            var newObject = contentComponent.createObject(client, {"anchors.centerIn": client});
            contentItem = newObject;

        }
    }

    Item{
        id: client
        anchors.fill: parent
    }
}
