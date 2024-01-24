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
            text: qsTr("Individual")
            font.bold: true
        }
    }

    contentItem: ScrollView {
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        FlickableItem {
            ColumnLayout {
                width: parent.width
                spacing: 12

                BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        uniformCellWidths: true
                        uniformCellHeights: true
                        columns: portrait ? 1 : 2


                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Family Name (Latin script)")
                            textOf: current_contact.family_name
                            onEdit: (txt) => {
                                        if (current_contact.family_name !== txt)
                                        current_contact.family_name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Forenames (Latin script)")
                            textOf: current_contact.forenames
                            onEdit: (txt) => {
                                        if (current_contact.forenames !== txt)
                                        current_contact.forenames = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Email")
                            textOf: current_contact.email
                            onEdit: (txt) => {
                                        if (current_contact.email !== txt)
                                        current_contact.email = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                            validator: RegularExpressionValidator {
                                regularExpression: /^$|\S+@\S+\.\S+$/
                            }
                            inputHint: Qt.ImhEmailCharactersOnly
                        }

                        PhoneChooser {
                            Layout.margins: 12
                            phoneOf : current_contact.phone
                            codeOf : current_contact.calling_code
                            onPhoneEdit: (txt) => {
                                             if (current_contact.phone !== txt)
                                             current_contact.phone = txt
                                         }
                            onCodeEdit: (txt) => {
                                            if (current_contact.calling_code !== txt)
                                            current_contact.calling_code = txt
                                        }
                        }
                    }
                }

                AddressChooser {
                    countryOf: current_individual.country
                    onCountryEdit: (value) => {
                                       if (current_individual.country !== value)
                                       current_individual.country = value
                                   }
                    addressOf: current_individual.address
                    onAddressEdit: (txt) => {
                                       if (current_individual.address !== txt)
                                       current_individual.address = txt
                                   }
                    regionOf: current_individual.region
                    onRegionEdit: (txt) => {
                                      if (current_individual.region !== txt)
                                      current_individual.region = txt
                                  }
                    postcodeOf: current_individual.postcode
                    onPostcodeEdit: (txt) => {
                                        if (current_individual.postcode !== txt)
                                        current_individual.postcode = txt
                                    }
                    localityOf: current_individual.locality
                    onLocalityEdit: (txt) => {
                                        if (current_individual.locality !== txt)
                                        current_individual.locality = txt
                                    }
                }

                BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        columns: portrait ? 1 : 2
                        uniformCellHeights: true
                        uniformCellWidths: true

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Passport number")
                            textOf: current_individual.passport
                            onEdit: (txt) => {
                                        if (current_individual.passport !== txt)
                                        current_individual.passport = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        CountryChooser {
                            Layout.margins: 12
                            name: qsTr("Isssuing country")
                            enumOf: current_individual.issuing
                            onEdit: (value) => {
                                        if (current_individual.issuing !== value)
                                        current_individual.issuing = value
                                    }
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Name (Local Characters)")
                            textOf: current_individual.local_name
                            onEdit: (txt) => {
                                        if (current_individual.local_name !== txt)
                                        current_individual.local_name = txt
                                    }
                            placeHolder: qsTr("* Optional")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Forenames (Local Characters)")
                            textOf: current_individual.local_forenames
                            onEdit: (txt) => {
                                        if (current_individual.local_forenames !== txt)
                                        current_individual.local_forenames = txt
                                    }
                            placeHolder: qsTr("* Optional")
                        }

                        RowLayout {
                            Layout.margins: 12
                            spacing: 24

                            CheckBox {
                                checked: current_individual.pep
                                onCheckStateChanged: if (current_individual.pep !== checked)
                                                         current_individual.pep !== checked
                                text: qsTr("Is a PEP")
                                Layout.columnSpan: current_individual.pep ? 1 : 2
                            }

                            CountryChooser {
                                name: qsTr("PEP country")
                                visible: current_individual.pep
                                enumOf: current_individual.pep_country
                                onEdit: (value) => {
                                            if (current_individual.pep_country !== value)
                                            current_individual.pep_country = value
                                        }
                            }
                        }

                        LabeledTextArea {
                            Layout.margins: 12
                            name: qsTr("Additional PEP Notes")
                            visible: current_individual.pep
                            textOf: current_individual.pep_notes
                            onEdit: (txt) => {
                                        if (current_individual.pep_notes !== txt)
                                        current_individual.pep_notes = txt
                                    }
                            placeHolder: qsTr("* Optional")
                            Layout.rowSpan: 2
                        }

                        Item { visible: current_individual.pep }

                        LabeledTextArea {
                            Layout.margins: 12
                            name: qsTr("Notes")
                            onEdit: (txt) => {
                                        if (current_individual.notes !== txt)
                                        current_individual.notes = txt
                                    }
                            placeHolder: qsTr("* Optional")
                            Layout.rowSpan: 4
                            Layout.columnSpan: 2
                        }

                        Item {}
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
            onClicked: {
                if (current_individual.flagged_for_update)
                    busyDialog.onLoaded = () => {
                        current_individual.contact_id = current_contact.id
                        current_individual.save()
                    }
                current_contact.save()
            }
            highlighted: true
            enabled: current_contact.flagged_for_update || current_individual.flagged_for_update
        }

        Item { Layout.fillWidth: true }

        RoundButton {
            Layout.margins: 12
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected individual will be deleted"),
                                         () => {
                                             busyDialog.onLoaded = () => {
                                                 current_contact.remove()
                                                 busyDialog.onLoaded = () => { rootStack.currentIndex = 0 }
                                             }
                                             current_individual.remove()
                                         }, true)
        }

        Connections {
            target: current_contact
            function onLoadingChanged() {
                current_contact.loading ? busyDialog.open() : busyDialog.close()
            }
        }

        Connections {
            target: current_individual
            function onLoadingChanged() {
                current_individual.loading ? busyDialog.open() : busyDialog.close()
            }
        }
    }
}
