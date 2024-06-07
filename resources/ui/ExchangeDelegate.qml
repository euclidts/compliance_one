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

        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: exchangeListModel.save(
                           root.ListView.view.model.parent_row(
                               root.model.index)
                           )
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
            Layout.columnSpan: portrait ? 2 : 4
        }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            visible: !root.model.loading
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected country will be deleted"),
                                         () => { exchangeListModel.remove(
                                                 root.ListView.view.model.parent_row(
                                                     root.model.index)
                                                 ) },
                                         true)
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
