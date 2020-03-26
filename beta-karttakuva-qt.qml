/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

//! [Imports]
import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.6
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

//! [Imports]

// Rectangle
ColumnLayout {
    anchors.fill: parent

    TextField {
            id: singleline
            text: ""
            Layout.alignment: Qt.AlignLeft| Qt.AlignTop
            Layout.margins: 5
            Layout.fillWidth: true
            background: Rectangle {
               implicitWidth: 200
               implicitHeight: 40
               border.color: singleline.focus ? "#21be2b" : "lightgray"
               color: singleline.focus ? "lightgray" : "transparent"
            }
        }

    ListView {
        width: 100; height: 100
        Layout.fillWidth: true
        delegate: Rectangle {
            height: 25
            width: 100
            color: model.modelData.color
            Text { text: name }
        }
    }

    //! [Initialize Plugin]
    Plugin {
        id: myPlugin
        name: "mapboxgl" 
        PluginParameter {
                  name: "mapboxgl.mapping.additional_style_urls"
                   value: "https://raw.githubusercontent.com/nls-jajuko/beta-karttakuva.maanmittauslaitos.fi/master/vectortiles/hobby/hobby-3857.json"

        }
        PluginParameter {
                  name: "mapboxgl.access_token"
                  value: "pk.eyJ1IjoiamFuc2t1IiwiYSI6ImNqMzJvNXRibzAwMDcyeG9jaHhwMnc2d2YifQ.mN0O1o-WgG6wvb9B06ChXw"
        }
    }
    //! [Initialize Plugin]

    //! [Current Location]
    PositionSource {
        id: positionSource
        property variant lastSearchPosition: locationHelsinki
        active: true
        updateInterval: 120000 // 2 mins
        onPositionChanged:  {
            var currentPosition = positionSource.position.coordinate
            map.center = currentPosition
        }
    }
    //! [Current Location]

    property variant locationHelsinki: QtPositioning.coordinate( 63.101, 21.645 )


    //! [Places MapItemView]
    Map {
        id: map
        //anchors.fill: parent
        Layout.alignment: Qt.AlignLeft
        Layout.margins: 5
        Layout.fillWidth: true
        Layout.fillHeight: true
        plugin: myPlugin;
        center: locationHelsinki
        zoomLevel: 13

        MapItemView {
            model: searchModel
            delegate: MapQuickItem {
                coordinate: place.location.coordinate

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image { id: image; source: "marker.png" }
                    Text { text: title; font.bold: true }
                }
            }
        }
    }
    //! [Places MapItemView]


}
