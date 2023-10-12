import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import Qproduct_group

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

        EnumValueEditor {
            name: qsTr("Product group")
            model: Qproduct_groupListModel { list: product_group }
            enumOf: root.model.group_id
            onEdit: (value) => { root.model.group_id = value }
            Layout.columnSpan: 4
            Layout.fillWidth: true
            valueRole: "id"
            textRole: "name"
        }

        LabeledTextField {
            name: qsTr("Commodity")
            textOf: root.model.commodity
            onEdit: (txt) => { root.model.commodity = txt }
            placeHolder: qsTr("* Mandatory")
            readOnly: root.model.now_loading
            Layout.columnSpan: 2
        }

        IntChooser {
            name: qsTr("Risk score")
            minimum: 1
            maximum: 10
            Layout.columnSpan: 2
            numberOf: root.model.risk_score
            onEdit: (val) => { root.model.risk_score = val }
            editable: !root.model.now_loading
        }


        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: product.save(root.model.index)
            highlighted: true
            enabled: root.model.flagged_for_update
            visible: !root.model.now_loading
        }

        Item {
            Layout.fillWidth: true
            visible: !portrait && !root.model.now_loading
            Layout.columnSpan: portrait ? 1 : 2
        }

        BusyIndicator {
            visible: root.model.now_loading
            Layout.fillWidth: true
            Layout.columnSpan: portrait ? 2 : 4
        }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            visible: !root.model.now_loading
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected country will be deleted"),
                                         () => { product.remove(root.model.index) }, true)
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}