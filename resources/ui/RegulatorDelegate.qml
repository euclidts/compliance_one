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
            name: "Name"
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 4
            Layout.fillWidth: true
        }

        LabeledTextArea {
            name: "Website"
            textOf: root.model.website
            onEdit: (txt) => { root.model.website = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 4
            Layout.topMargin: 6
            areaHeight: 120
        }

        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: regulatorListModel.save(root.model.index)
            highlighted: true
            enabled: root.model.flagged_for_update
            visible: !root.model.loading
        }

        Item {
            Layout.fillWidth: true
            visible: !root.model.loading
            Layout.columnSpan: 2
        }

        BusyIndicator {
            visible: root.model.loading
            Layout.fillWidth: true
            Layout.columnSpan: 4
        }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            visible: !root.model.loading
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected regulator will be deleted"),
                                         () => { regulatorListModel.remove(root.model.index) }, true)
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
