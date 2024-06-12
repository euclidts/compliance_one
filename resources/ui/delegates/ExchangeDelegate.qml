import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../utils" as Utils

ItemDelegate {
    id: root
    width: window.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    contentItem: GridLayout {
        columns: portrait ? 1 : 2
        enabled: !root.model.loading

        Utils.LabeledTextField {
            name: qsTr("Code")
            textOf: root.model.code
            onEdit: (txt) => { root.model.code = txt }
            Layout.maximumWidth: 90
        }

        Utils.LabeledTextField {
            name: qsTr("Description")
            textOf: root.model.description
            onEdit: (txt) => { root.model.description = txt }
        }

        Utils.FilterSaveRemove {
            model: root.model
            listModel: exchangeListModel
            listView: root.ListView
            Layout.fillWidth: true
            Layout.columnSpan: portrait ? 1 : 2
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
