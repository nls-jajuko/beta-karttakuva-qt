

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


ListView {

    signal flyTo(variant loc)

    id: root
    anchors.fill: parent
    model: searchModel
    delegate: Component {

        Item {
            id: placeRoot
            width: root.width
            height: Math.max(icon.height, 3 * placeName.height)

            Rectangle {
                anchors.fill: parent
                color: "#a0f0f0f0"
                visible: true
            }

            GridLayout {
                rows: 2
                columns: 2
                anchors.fill: parent
                anchors.leftMargin: 30
                flow: GridLayout.TopToBottom

                Image {
                    // anchors.verticalCenter: parent.verticalCenter
                    id:icon
                    source: "marker.png"
                    Layout.rowSpan: 2
                }

                Label {
                    id: placeName
                    text: title
                    Layout.fillWidth: true
                }

            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 15
                height: 1
                color: "#46a2da"
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked: {

                       root.flyTo(place.location);

                }
            }

        }

    }

}
