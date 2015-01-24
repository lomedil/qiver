import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import "shared"

Item{
    id: panel
    width: 300
    height: 200

    property alias model: theList.model

    Connections{
        target: model
        onCountChanged: theList.positionViewAtEnd();
    }

    ColumnLayout{
        anchors.fill: parent

        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: childrenRect.height

            Button{
                anchors.right: parent.right
                text: qsTr("Clear")
                onClicked: model.clearAll()
            }
        }

        ScrollView{
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView{
                id: theList
                anchors.fill: parent

                clip: true
                delegate: entryDelegate
            }
        }

    }



    Component{
        id: entryDelegate

        Rectangle{
            id: rootDelegate
            color: (index % 2 == 0) ? "white" : Qt.darker("white", 1.12)
            width: theList.width
            height:  28

            RowLayout{
                anchors.fill: parent

                // Icon for type of message
                Item{
                    Layout.preferredWidth: 40
                    Layout.fillHeight: true
                    AwesomeIcon{
                        id: awesomeicon
                        anchors.centerIn: parent

                        property var typeStyles: [
                            {"iconName": "bug",         "color": "black"  },
                            {"iconName": "warning_sign","color": "yellow" },
                            {"iconName": "rocket",      "color": "blue"   },
                            {"iconName": "circle",      "color": "red"    },
                            {"iconName": "rocket",      "color": "blue"   }
                        ]

                        name: typeStyles[type].iconName
                        color: typeStyles[type].color
                        size: 20
                    }


                }

                // Message
                Item{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text{
                        anchors.fill: parent
                        text: message
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }

                }

                // File
                Item{
                    Layout.preferredWidth: 300
                    Layout.fillHeight: true
                    Text{
                        anchors.fill: parent
                        text: file
                        elide: Text.ElideLeft
                        verticalAlignment: Text.AlignVCenter
                    }


                }

                // Line of file
                Item{
                    Layout.preferredWidth: 40
                    Layout.fillHeight: true
                    Text{
                        anchors.fill: parent
                        text: line
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }


                }
            }

        }

    }
}
