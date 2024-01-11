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

                BackgroundRect {
                    GridLayout {
                        width: parent.width
                        Layout.margins: 6
                        uniformCellWidths: true
                        uniformCellHeights: true
                        columns: portrait ? 1 : 2

                        LabeledTextField {
                            name: qsTr("Family Name (Latin script)")
                            textOf: current_contact.family_name
                            onEdit: (txt) => {
                                        if (current_contact.family_name !== txt)
                                        current_contact.family_name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            name: qsTr("Forenames (Latin script)")
                            textOf: current_contact.forenames
                            onEdit: (txt) => {
                                        if (current_contact.forenames !== txt)
                                        current_contact.forenames = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
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
                    onCountryEdit: (txt) => {
                                       if (current_individual.country !== txt)
                                       current_individual.country = txt
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
                    Layout.topMargin: 12
                    Layout.margins: 6

                    GridLayout {
                        width: parent.width
                        columns: portrait ? 1 : 2
                        uniformCellHeights: true
                        uniformCellWidths: true

                        LabeledTextField {
                            name: qsTr("Passport number")
                            textOf: current_individual.passport
                            onEdit: (txt) => {
                                        if (current_individual.passport !== txt)
                                        current_individual.passport = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        CountryChooser {
                            name: qsTr("Isssuing country")
                            enumOf: current_individual.issuing
                            onEdit: (value) => {
                                        if (current_individual.issuing !== value)
                                        current_individual.issuing = value
                                    }
                        }

                        LabeledTextField {
                            name: qsTr("Name (Local Characters)")
                            textOf: current_individual.local_name
                            onEdit: (txt) => {
                                        if (current_individual.local_name !== txt)
                                        current_individual.local_name = txt
                                    }
                            placeHolder: qsTr("* Optional")
                        }

                        LabeledTextField {
                            name: qsTr("Forenames (Local Characters)")
                            textOf: current_individual.local_forenames
                            onEdit: (txt) => {
                                        if (current_individual.local_forenames !== txt)
                                        current_individual.local_forenames = txt
                                    }
                            placeHolder: qsTr("* Optional")
                        }

                        CheckBox {
                            checked: current_individual.pep
                            onCheckStateChanged: current_individual.pep = checked
                            text: qsTr("Is a PEP")
                        }

                        CountryChooser {
                            name: qsTr("PEP country")
                            enumOf: current_individual.pep_country
                            onEdit: (value) => {
                                        if (current_individual.pep_country !== value)
                                        current_individual.pep_country = value
                                    }
                        }

                        LabeledTextArea {
                            name: qsTr("Additional PEP Notes")
                            textOf: current_individual.pep_notes
                            onEdit: (txt) => {
                                        if (current_individual.pep_notes !== txt)
                                        current_individual.pep_notes = txt
                                    }
                            placeHolder: qsTr("* Optional")
                        }

                        LabeledTextArea {
                            name: qsTr("Notes")
                            textOf: current_individual.notes
                            onEdit: (txt) => {
                                        if (current_individual.notes !== txt)
                                        current_individual.notes = txt
                                    }
                            placeHolder: qsTr("* Optional")
                        }
                    }
                }
            }
        }
    }

    footer: RowLayout {

        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: current_contact.save()
            highlighted: true
            enabled: current_contact.flagged_for_update
        }

        Item { Layout.fillWidth: true }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            onClicked: current_contact.clear()
            // Layout.alignment: Qt.AlignRight
            // onClicked: onExceptionAction(ToolTip.text,
            //                              qsTr("The selected country will be deleted"),
            //                              () => { country_list.remove(root.model.index) }, true)
        }
    }
}
