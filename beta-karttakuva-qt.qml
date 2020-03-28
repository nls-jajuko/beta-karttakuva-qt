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
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtPositioning 5.5
import QtLocation 5.6
import QtQuick.Layouts 1.3
import "items"

//! [Imports]

ApplicationWindow {
    id: appWindow
    //anchors.fill: parent
    title: qsTr("Beta Karttakuva")
    width: 360
    height: 640
    visible: true
    toolBar: searchBar

    SearchBar {
        id: searchBar
        width: appWindow.width
        searchBarVisbile: true
        onSearchTextChanged: {
            if (searchText.length >= 2 ) {
                searchModel.searchTerm = searchText;
                searchModel.update();
            }
        }
        onDoSearch: {
            console.log("SEARCH",searchText);
            searchModel.searchForText(searchText);
        }
        onDoClear: {
            showSearch('')
            searchResults.visible=false;
        }
    }

    //! [Initialize Plugin]

    Plugin {
        id: bkPlugin
        name: "betakarttakuva"
        allowExperimental: true
        PluginParameter {
                  name: "betakarttakuva.places.host"
                  value: "https://beta-paikkatieto.maanmittauslaitos.fi"

        }

    }


    Plugin {
        id: mapboxPlugin
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

    PlaceSearchModel {
        id: searchModel

        plugin: bkPlugin

        onStatusChanged: {
            switch (status) {
            case PlaceSearchModel.Ready:
                if (count > 0) {
                    console.log("FOUND",count)
                     searchResults.visible =true;
                } else
                    console.log("FOUND","NONE")
                break;
            case PlaceSearchModel.Error:
                console.log("Search Place Error",errorString())
                break;
            }
        }

        function searchForText(text) {
            console.log("PLACEMODEL",text)
            searchTerm = text;
            categories = null;
            limit = -1;
            console.log("PLACEMODEL","update")
            update();
        }

    }

    PlaceSearchSuggestionModel {
        id: suggestionModel

        onStatusChanged: {

        }
    }

    //! [Places MapItemView]
    Map {
        id: map
        width: appWindow.width
        height: appWindow.height

      //  anchors.fill: parent
        plugin: mapboxPlugin;
        center: locationHelsinki
        zoomLevel: 13

        MapItemView {
            model: searchModel
            delegate: MapQuickItem {
                coordinate: place.location.coordinate

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image { id: image; source: "items/marker.png" }
                    Text { text: title; font.bold: true }
                }
            }
        }
    }
    //! [Places MapItemView]

    SearchResults {
        id: searchResults
        width: appWindow.width
        visible: false

        onFlyTo: {
            console.log("SELECTED",loc);
            searchResults.visible=false;
            var currentPosition = loc.coordinate;
            map.center = currentPosition
        }

    }

}
