import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

Page {
    background: Rectangle { color: "transparent" }

    header: RowLayout {

        Button {
            id: backButton
            icon.source: "qrc:/icons/arrow-left.svg"
            flat: true
            onClicked: rootStack.currentIndex = 0
        }

        Label {
            text: qsTr("Vessel")
            font.bold: true
        }
    }

    contentItem: ScrollView {
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        FlickableItem {
            BackgroundRect {
                width: parent.width

                GridLayout {
                    width: parent.width
                    columnSpacing: 0
                    rowSpacing: 0
                    columns: portrait ? 1 : 2
                    uniformCellWidths: true

                    LabeledTextField {
                        Layout.margins: 12
                        name: qsTr("Name")
                        textOf: current_vessel.name
                        onEdit: (txt) => {
                                    if (current_vessel.name !== txt)
                                        current_vessel.name = txt
                                }
                        placeHolder: qsTr("* Mandatory")
                    }

                    LabeledTextField {
                        Layout.margins: 12
                        name: qsTr("IMO")
                        textOf: current_vessel.imo
                        onEdit: (txt) => {
                                    if (current_vessel.imo !== txt)
                                        current_vessel.imo = txt
                                }
                        placeHolder: qsTr("* Mandatory")
                    }

                    EnumValueChooser {
                        Layout.margins: 12
                        name: qsTr("Owner")
                        model: companyListModel
                        Layout.fillWidth: true
                        ediatable: true
                        valueRole: "id"
                        textRole: "name"
                        enumOf: current_vessel.owner_id
                        onEdit: (value) => {
                                    if (current_vessel.owner_id !== value)
                                        current_vessel.owner_id = value
                                }
                    }

                    EnumValueChooser {
                        Layout.margins: 12
                        name: qsTr("Manager")
                        model: companyListModel
                        Layout.fillWidth: true
                        ediatable: true
                        valueRole: "id"
                        textRole: "name"
                        enumOf: current_vessel.manager_id
                        onEdit: (value) => {
                                    if (current_vessel.manager_id !== value)
                                    current_vessel.manager_id = value
                                }
                    }
                }
            }
        }
    }

    footer: RowLayout {

        RoundButton {
            Layout.margins: 12
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: current_vessel.save()
            highlighted: true
            enabled: current_vessel.flagged_for_update
        }

        Item { Layout.fillWidth: true }

        RoundButton {
            Layout.margins: 12
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected vessel will be deleted"),
                                         () => { current_vessel.remove() },
                                         true)
        }
    }
}
