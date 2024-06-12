import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../utils" as Utils
import "../choosers" as Choosers

ItemDelegate {
    id: root
    width: window.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    contentItem: GridLayout {
        columns: portrait ? 2 : 3
        enabled: !root.model.loading

        Utils.LabeledTextField {
            name: qsTr("Name")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 2
        }

        Utils.LabeledTextField {
            name: qsTr("Website")
            textOf: root.model.website
            onEdit: (txt) => { root.model.website = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: portrait ? 2 : 1
        }

        CheckBox {
            id: regionCheck
            checked: root.model.region_id === 0
            onCheckStateChanged: if (root.model.region_id !== 0 && checked)
                                     root.model.region_id = 0
            text: qsTr("Supraregional")
        }

        Choosers.EnumValueChooser {
            name: qsTr("Region")
            model: regionListModel
            enumOf: root.model.region_id
            onEdit: (value) => { root.model.region_id = value }
            visible: !regionCheck.checked
            valueRole: "id"
            textRole: "name"
        }

        Item { visible: regionCheck.checked }

        Choosers.JuisdicionChooser {
            parentModel: root.model
        }

        Utils.FilterSaveRemove {
            model: root.model
            listModel: regulatorListModel
            listView: root.ListView
            Layout.columnSpan: portrait ? 2 : 3
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
