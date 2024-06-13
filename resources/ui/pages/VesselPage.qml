import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import "../utils" as Utils

import Qvessel

Page {
    property var current_vessel: SingleQvessel {}

    background: Rectangle { color: "transparent" }

    header: RowLayout {

        Button {
            id: backButton
            icon.source: "qrc:/icons/arrow-left.svg"
            flat: true
            onClicked: rootStack.currentIndex = 1
        }

        Label {
            text: qsTr("Vessel")
            font.bold: true
        }
    }

    contentItem: ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        Utils.FlickableItem {
            ColumnLayout {
                width: parent.width
                spacing: 12
                enabled: !current_vessel.loading

                Utils.BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        uniformCellWidths: true
                        columns: portrait ? 1 : 2

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Name")
                            textOf: current_vessel.name
                            onEdit: (txt) => {
                                        if (current_vessel.name !== txt)
                                        current_vessel.name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("IMO")
                            textOf: current_vessel.imo
                            onEdit: (txt) => {
                                        if (current_vessel.imo !== txt)
                                        current_vessel.imo = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        // EnumValueChooser {
                        //     Layout.margins: 12
                        //     name: qsTr("Owner")
                        //     model: companyListModel
                        //     Layout.fillWidth: true
                        //     ediatable: true
                        //     valueRole: "id"
                        //     textRole: "name"
                        //     enumOf: current_vessel.owner_id
                        //     onEdit: (value) => {
                        //                 if (current_vessel.owner_id !== value)
                        //                 current_vessel.owner_id = value
                        //             }
                        // }

                        // EnumValueChooser {
                        //     Layout.margins: 12
                        //     name: qsTr("Manager")
                        //     model: companyListModel
                        //     Layout.fillWidth: true
                        //     ediatable: true
                        //     valueRole: "id"
                        //     textRole: "name"
                        //     enumOf: current_vessel.manager_id
                        //     onEdit: (value) => {
                        //                 if (current_vessel.manager_id !== value)
                        //                 current_vessel.manager_id = value
                        //             }
                        // }
                    }
                }
            }
        }
    }

    footer: Utils.QueuedSaveRemove {
        busy: current_vessel.loading
        enableSave: current_vessel.flagged_for_update
        saveSequence: [ current_vessel.save ]
        deleteSequence: [
            vesselPage.current_vessel.remove_queued,
            () => {
                vesselListModel.clear()
                rootStack.currentIndex = 1
            }
        ]
    }
}
