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
        columns: 3

        LabeledTextField {
            name: qsTr("Name")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 3
        }

        GridLayout {
            Layout.topMargin: 6
            columns: 2

            Label {
                text: qsTr("Internal Ranking")
                font.italic: true
            }

            Label {
                text: qsTr("FATF")
                font.italic: true
            }

            ComboBox {
                Layout.minimumWidth: 160
                 model: ["Low", "Medium", "High"]
                 Component.onCompleted: currentIndex = root.model.ranking
                 onActivated: root.model.ranking = currentIndex
            }

            ComboBox {
                Layout.minimumWidth: 160
                model: ["Low", "Medium", "High"]
                Component.onCompleted: currentIndex = root.model.fatf
                onActivated: root.model.fatf = currentIndex
            }
        }

        IntChooser {
            Layout.topMargin: 6
            name: qsTr("Transparency International")
            minimum: 1
            maximum: 10
            numberOf: root.model.transparency
            onEdit: (val) => { root.model.transparency = val }
        }

        IntChooser {
            Layout.topMargin: 6
            name: qsTr("World Bank")
            minimum: 1
            maximum: 10
            numberOf: root.model.world_bank
            onEdit: (val) => { root.model.world_bank = val }
        }

        RoundButton {
            icon.source: "qrc:/icons/check-square.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Validate")
            //                onClicked: onExceptionAction(ToolTip.text,
            //                                         qsTr("Le dossier selectionné serra supprimé définitivement"),
            //                                         () => { accounts.remove(model.id) }, true)
        }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            //                onClicked: onExceptionAction(ToolTip.text,
            //                                         qsTr("Le dossier selectionné serra supprimé définitivement"),
            //                                         () => { accounts.remove(model.id) }, true)
        }
    }

//    onClicked: {
//        bridge.accountId = model.id
//        bridge.accountState = model.state
//        accountsPages.loadItem()
//    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
