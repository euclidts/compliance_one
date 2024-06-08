import QtQuick
import QtQuick.Controls.Material

import "../utils" as Utils

import QSortFilter

Page {
    property alias sourceModel: sortFilter.sourceModel
    property alias delegate: list.delegate

    background: Rectangle { color: "transparent" }

    header: Utils.SearchBar {
        width: parent.width
        onTextChanged: (text) => { sortFilter.filter_by_string(text) }
    }

    contentItem: ListView {
        id: list
        spacing: 6
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        model : QSortFilter { id: sortFilter }
        reuseItems: true

        ScrollBar.vertical: ScrollBar {}

        footer: RoundButton {
            icon.source: "qrc:/icons/plus.svg"
            onClicked: sourceModel.appendItem()
            highlighted: true
        }
    }
}
