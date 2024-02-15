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
            text: qsTr("Company")
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
                            name: qsTr("Counterparty Name (Latin script)")
                            textOf: current_company.name
                            onEdit: (txt) => {
                                        if (current_company.name !== txt)
                                            current_company.name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Counterparty Name (Local Characters)")
                            textOf: current_company.local_name
                            onEdit: (txt) => {
                                        if (current_company.local_name !== txt)
                                            current_company.local_name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Website")
                            textOf: current_company.website
                            onEdit: (txt) => {
                                        if (current_company.website !== txt)
                                            current_company.website = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Company Unique Identifier")
                            textOf: current_company.uuid
                            onEdit: (txt) => {
                                        if (current_company.uuid !== txt)
                                            current_company.uuid = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Legal Entitiy Identifier (LEI)")
                            textOf: current_company.lei
                            onEdit: (txt) => {
                                        if (current_company.lei !== txt)
                                            current_company.lei = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("ACER code")
                            textOf: current_company.acer
                            onEdit: (txt) => {
                                        if (current_company.acer !== txt)
                                            current_company.acer = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        CheckBox {
                            checked: current_company.is_public
                            onCheckStateChanged: if (current_company.is_public !== checked)
                                                     current_company.is_public = checked
                            text: qsTr("Company Publically Listed")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Commercial Registry Number")
                            textOf: current_company.comercial_registery
                            onEdit: (txt) => {
                                        if (current_company.comercial_registery !== txt)
                                            current_company.comercial_registery = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        CheckBox {
                            checked: current_company.is_branch
                            onCheckStateChanged: if (current_company.is_branch !== checked)
                                                     current_company.is_branch = checked
                            text: qsTr("Is a Branch")
                            Layout.columnSpan: portrait ? 1 : 2
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Branch Commercial Registry Number")
                            textOf: current_company.branch_registery
                            onEdit: (txt) => {
                                        if (current_company.branch_registery !== txt)
                                            current_company.branch_registery = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                            visible: current_company.is_branch
                        }
                    }
                }

                AddressChooser {
                    countryOf: current_address.country_id
                    onCountryEdit: (value) => {
                                       if (current_address.country_id !== value)
                                           current_address.country_id = value
                                   }
                    addressOf: current_address.address_lines
                    onAddressEdit: (txt) => {
                                       if (current_address.address_lines !== txt)
                                           current_address.address_lines = txt
                                   }
                    regionOf: current_address.region
                    onRegionEdit: (txt) => {
                                      if (current_address.region !== txt)
                                          current_address.region = txt
                                  }
                    postcodeOf: current_address.postcode
                    onPostcodeEdit: (txt) => {
                                        if (current_address.postcode !== txt)
                                            current_address.postcode = txt
                                    }
                    localityOf: current_address.locality
                    onLocalityEdit: (txt) => {
                                        if (current_address.locality !== txt)
                                            current_address.locality = txt
                                    }
                }

                ContatChooser {
                    label: "Contact person"
                    familyNameOf: current_contact.family_name
                    onFamilyNameEdit: (txt) => {
                                          if (current_contact.family_name !== txt)
                                              current_contact.family_name = txt
                                      }
                    forenamesOf: current_contact.forenames
                    onForenamesEdit: (txt) => {
                                         if (current_contact.forenames !== txt)
                                             current_contact.forenames = txt
                                     }
                    emailOf: current_contact.email
                    onEmailEdit: (txt) => {
                                     if (current_contact.email !== txt)
                                         current_contact.email = txt
                                 }
                    phoneOf: current_contact.phone
                    codeOf: current_contact.calling_code
                    onPhoneEdit: (txt) => {
                                     if (current_contact.phone !== txt)
                                         current_contact.phone = txt
                                 }
                    onCodeEdit: (txt) => {
                                    if (current_contact.calling_code !== txt)
                                        current_contact.calling_code = txt
                                }
                }

                BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        columns: portrait ? 1 : 2
                        uniformCellWidths: true

                        CheckBox {
                            checked: current_company.pep
                            onCheckStateChanged: if (current_company.pep !== checked)
                                                     current_company.pep = checked
                            text: qsTr("PEP")
                        }

                        CheckBox {
                            checked: current_company.soe
                            onCheckStateChanged: if (current_company.soe !== checked)
                                                     current_company.soe = checked
                            text: qsTr("State Owned Enterprise (SOE)")
                        }

                        CheckBox {
                            checked: current_company.regulated
                            onCheckStateChanged: if (current_company.regulated !== checked)
                                                     current_company.regulated = checked
                            text: qsTr("Regulated")
                        }

                        CheckBox {
                            checked: current_company.ancillary
                            onCheckStateChanged: if (current_company.ancillary !== checked)
                                                     current_company.ancillary = checked
                            text: qsTr("ANCILLARY status")
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
            onClicked: {
                onLoaded = () => {
                    onLoaded = () => {
                        current_company.address_id = current_address.id
                        current_company.save()
                    }
                    current_company.contact_id = current_contact.id
                    current_address.save()
                }
                current_contact.save()
            }
            highlighted: true
            enabled: current_contact.flagged_for_update ||
                     current_address.flagged_for_update ||
                     current_company.flagged_for_update
        }

        Item { Layout.fillWidth: true }

        RoundButton {
            Layout.margins: 12
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected company will be deleted"),
                                         () => {
                                             onLoaded = () => {
                                                 onLoaded = () => {
                                                     onLoaded = () => { rootStack.currentIndex = 0 }
                                                     current_contact.remove()
                                                 }
                                                 current_address.remove()
                                             }
                                             current_comapny.remove()
                                         },
                                         true)
        }
    }
}
