import QtQuick
import QtQuick.Controls.Material

import QSortFilter

Page {
    property alias sourceModel: sortFilter.sourceModel
    property alias delegate: list.delegate

    background: Rectangle { color: "transparent" }

    header: SearchBar {
        width: parent.width
        onTextChanged: (text) => { sortFilter.setFilterFixedString(text) }
    }

    contentItem: ListView {
        id: list
        spacing: 6
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        model : QSortFilter { id: sortFilter }
        reuseItems: true

        ScrollBar.vertical: ScrollBar { }

        footer: RoundButton {
            icon.source: "qrc:/icons/plus.svg"
            onClicked: ctp_typeListModel.appendItem()
            highlighted: true
        }
    }
}
