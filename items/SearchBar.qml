
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ToolBar {

    property bool busyIndicatorRunning : false
    property bool searchBarVisbile: true

    signal doSearch(string searchText)
    signal searchTextChanged(string searchText)
    signal doClear()


    onSearchBarVisbileChanged: {
        searchBar.opacity = searchBarVisbile ? 1 : 0
    }

    function showSearch(text) {
        if (text !== null) {
            searchText.ignoreTextChange = true
            searchText.text = text
            searchText.ignoreTextChange = false
        }
    }

    RowLayout {
        id: searchBar
        width: parent.width
        height: parent.height
        Behavior on opacity { NumberAnimation{} }
        visible: opacity ? true : false

        ToolButton {
            id: backButton
            iconSource:  "left.png"
            onClicked: doClear()
        }
        TextField {
            id: searchText
            Behavior on opacity { NumberAnimation{} }
            visible: opacity ? true : false
            property bool ignoreTextChange: false
            placeholderText: qsTr("Type place...")
            Layout.fillWidth: true
            onTextChanged: {
                if (!ignoreTextChange)
                    searchTextChanged(text)
            }
            onAccepted: doSearch(searchText.text)
        }

        ToolButton {
            id: searchButton
            iconSource:  "search.png"
            onClicked: doSearch(searchText.text)
        }

    }


}

