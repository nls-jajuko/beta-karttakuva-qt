

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2


ListView {

    signal flyTo(variant loc)

    id: results
    anchors.fill: parent
    model: searchModel
    delegate: Component {
        Item {
            width: parent.width;
            height: 30
            Marker { height: parent.height }

            Column {
                Text { text: title; font.bold: false }
                //Text { text: place.location.address.text }
            }
            MouseArea {
                anchors.fill: parent
               onClicked: {
                  results.flyTo(place.location);
               }
            }



        }
     }

}
