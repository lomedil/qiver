function loadLocalFile(file, parent, callback){
    var qmlComponent = Qt.createComponent(file);
    if(qmlComponent.status == Component.Error){
        callback(null, qmlComponent.errorString());
    }else{
        console.log("QML file loaded succesfully");
        var qmlObject = qmlComponent.createObject(client, {});
        callback(qmlObject, "");
    }
}
