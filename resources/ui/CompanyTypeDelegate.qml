import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import Qcompany_group

ItemDelegate {
    id: root
    width: window.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    contentItem: GridLayout {
        columns: 4
        enabled: !root.model.loading

        LabeledTextField {
            name: qsTr("Company Type")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 4
            Layout.fillWidth: true
        }

        EnumValueEditor {
            name: qsTr("Company group")
            model: company_groupListModel
            enumOf: root.model.group_id
            onEdit: (value) => { root.model.group_id = value }
            Layout.columnSpan: 2
            valueRole: "id"
            textRole: "name"
        }

        IntChooser {
            name: qsTr("Risk score")
            minimum: 1
            maximum: 10
            numberOf: root.model.risk_score
            onEdit: (val) => { root.model.risk_score = val }
            editable: true
            Layout.columnSpan: 2
        }

        LabeledTextArea {
            name: qsTr("Notes")
            textOf: root.model.notes
            onEdit: (txt) => { root.model.notes = txt }
            placeHolder: qsTr("* Optional")
            Layout.columnSpan: 4
            Layout.topMargin: 6
            areaHeight: 120
        }

        FilterSaveRemove {
            model: root.model
            listModel: company_typeListModel
            listView: root.ListView
            Layout.fillWidth: true
            Layout.columnSpan: 4
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
