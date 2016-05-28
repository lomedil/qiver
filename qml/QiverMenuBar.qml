import QtQuick 2.0
import QtQuick.Controls 1.2

MenuBar{
    id: menuBar

    property bool showOutputPanel: false
    property bool fitToRoot: false
    property int portviewOrientation: Qt.Horizontal
    property size portviewSizeSelected: Qt.size(800, 600)

    signal reloadClicked()
    signal openFileClicked()
    signal exitClicked()
    signal viewportClicked(int width, int height)
    signal customSizeClicked()
    onViewportClicked: console.log("%1 %2".arg(width).arg(height))


    readonly property var viewports: [
        {"name" : "SVGA", "width": 800, "height" :  600 },
        {"name" : "WVGA", "width": 800, "height" :  480 },
        {"name" : "WVGA", "width": 854, "height" :  480 },
        {"name" : "WSVGA", "width": 1024, "height" :  600 },
        {"name" : "XGA", "width": 1024, "height" :  768 },
        {"name" : "SXGA", "width": 1280, "height" :  1024 },
        {"name" : "WXGA", "width": 1280, "height" :  768 },
        {"name" : "WXGA", "width": 1200, "height" :  800 },
        {"name" : "HD 720", "width": 1280, "height" :  720 },
        {"name" : "HD 1080", "width": 1920, "height" :  1080 }
        ]



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
        Menu{
            title: qsTr("Viewport size")

            MenuItem{
                text: qsTr("Custom...")
                onTriggered: customSizeClicked()
            }

           Component.onCompleted: {
               var n = viewports.length;
               for(var i = 0; i < n; ++i){
                   var view = viewports[i];
                   var text = "%1 (%2x%3)".arg(view.name).arg(view.width).arg(view.height);
                   var item = this.addItem(text);
                   var callbackClosure = function() {
                       var w = view.width;
                       var h = view.height;
                       return function(){
                         menuBar.portviewSizeSelected = Qt.size(w, h);
                       }
                   }
                   item.triggered.connect(callbackClosure());
               }
           }
        }
        Menu{
            title: qsTr("Orientation")
            MenuItem{
                text: qsTr("Portrait")
                onTriggered: portviewOrientation = Qt.Vertical
                checked: portviewOrientation == Qt.Vertical
                checkable: true
            }
            MenuItem{
                text: qsTr("Landscape")
                onTriggered: portviewOrientation = Qt.Horizontal
                checked: portviewOrientation == Qt.Horizontal
                checkable: true
            }
        }
    }
}
