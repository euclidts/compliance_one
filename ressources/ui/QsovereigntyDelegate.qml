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

        LabeledTextField {
            name: qsTr("Name")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 4
            readOnly: root.model.now_loading
        }

        EnumIntChooser {
            name: qsTr("Internal Ranking")
            model: rateModel
            enumOf: root.model.ranking
            onEdit: (index) => { root.model.ranking = index }
        }

        EnumIntChooser {
            name: qsTr("FATF")
            model: rateModel
            enumOf: root.model.fatf
            onEdit: (index) => { root.model.fatf = index }
        }

        IntChooser {
            name: qsTr("Transparency International")
            minimum: 1
            maximum: 10
            numberOf: root.model.transparency
            onEdit: (val) => { root.model.transparency = val }
            editable: !root.model.now_loading
        }

        IntChooser {
            name: qsTr("World Bank")
            minimum: 1
            maximum: 10
            numberOf: root.model.world_bank
            onEdit: (val) => { root.model.world_bank = val }
            editable: !root.model.now_loading
        }

        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: sovereigntyList.save(root.model.index)
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
                                         qsTr("The selected sovereignty will be deleted"),
                                         () => { sovereigntyList.remove(root.model.index) }, true)
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
