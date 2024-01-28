import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import Qctp_group

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

        EnumValueEditor {
            name: qsTr("Counterparty group")
            model: Qctp_groupListModel { list: ctp_group_list }
            enumOf: root.model.group_id
            onEdit: (value) => { root.model.group_id = value }
            Layout.columnSpan: 2
            Layout.fillWidth: true
            valueRole: "id"
            textRole: "name"
        }

        LabeledTextField {
            name: qsTr("Counterparty Type")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
        }

        IntChooser {
            name: qsTr("Risk score")
            minimum: 1
            maximum: 10
            numberOf: root.model.risk_score
            onEdit: (val) => { root.model.risk_score = val }
            editable: true
        }

        LabeledTextArea {
            name: qsTr("Notes")
            textOf: root.model.notes
            onEdit: (txt) => { root.model.notes = txt }
            placeHolder: qsTr("* Optional")
            Layout.columnSpan: 2
            Layout.rowSpan: 2
        }


        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: ctp_type_list.save(root.model.index)
            highlighted: true
            enabled: root.model.flagged_for_update
            visible: !root.model.loading
        }

        Item {
            Layout.fillWidth: true
            visible: !portrait && !root.model.loading
            Layout.columnSpan: portrait ? 1 : 2
        }

        BusyIndicator {
            visible: root.model.loading
            Layout.fillWidth: true
            Layout.columnSpan: portrait ? 1 : 2
        }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            visible: !root.model.loading
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected counterpary type will be deleted"),
                                         () => { ctp_type_list.remove(root.model.index) }, true)
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
