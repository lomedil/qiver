import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2

Dialog{
    id: dialog

    property size customSize

    standardButtons: StandardButton.Ok|StandardButton.Cancel

    onAccepted: {
        if(widthText.acceptableInput && heightText.acceptableInput){
            customSize = Qt.size(widthText.text, heightText.text);
        }else{
            customSize = Qt.size(0,0);
        }

    }

    onVisibleChanged: if(visible) widthText.focus()

    IntValidator{
        id: numberValidator
        bottom: 300
        top: 1080
    }


    Grid{
        rows: 2
        columns: 2
        columnSpacing: 16
        rowSpacing: 32

        Label{
            text: qsTr("Width")
            width: parent.width*0.33
        }

        TextField{
            id: widthText
            text: numberValidator.bottom
            validator: numberValidator
            onFocusChanged: if(focus) selectAll()
        }

        Label{
            text: qsTr("Height")
        }

        TextField{
            id: heightText
            text: numberValidator.bottom
            validator: numberValidator
            onFocusChanged: if(focus) selectAll()
        }
    }




}
