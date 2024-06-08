import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ItemDelegate {
    id: root
    width: window.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    contentItem: GridLayout {
        columns: portrait ? 2 : 4
        enabled: !root.model.loading

        LabeledTextField {
            name: qsTr("Code")
            textOf: root.model.code
            onEdit: (txt) => { root.model.code = txt }
            Layout.columnSpan: 2
            Layout.maximumWidth: 90
        }

        LabeledTextField {
            name: qsTr("Description")
            textOf: root.model.description
            onEdit: (txt) => { root.model.description = txt }
            Layout.columnSpan: 2
        }

        FilterSaveRemove {
            model: root.model
            listModel: exchangeListModel
            listView: root.ListView
            Layout.fillWidth: true
            Layout.columnSpan: 2
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
