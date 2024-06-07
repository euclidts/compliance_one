import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import Qcontact
import Qaddress
import Qindividual

Page {
    property var current_contact : SingleQcontact {}
    property var current_address : SingleQaddress {}
    property var current_individual : SingleQindividual {}

    background: Rectangle { color: "transparent" }

    header: RowLayout {

        Button {
            id: backButton
            icon.source: "qrc:/icons/arrow-left.svg"
            flat: true
            onClicked: rootStack.currentIndex = 1
        }

        Label {
            text: qsTr("Individual")
            font.bold: true
        }
    }

    contentItem: ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        FlickableItem {
            ColumnLayout {
                width: parent.width
                spacing: 12

                ContatChooser {
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

                BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        columns: portrait ? 1 : 2
                        uniformCellWidths: true

                        LabeledDateField {
                            Layout.margins: 12
                            name: qsTr("Date of birth")
                            dateOf: current_individual.date_of_birth
                            onEdit: (date) => {
                                        if (current_individual.date_of_birth !== date)
                                            current_individual.date_of_birth = date
                                    }
                        }

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
                            name: qsTr("Isuing country")
                            enumOf: current_individual.issuing
                            onEdit: (value) => {
                                        if (current_individual.issuing !== value)
                                            current_individual.issuing = value
                                    }
                        }

                        LabeledDateField {
                            Layout.margins: 12
                            name: qsTr("Expiry date")
                            dateOf: current_individual.expiry_date
                            onEdit: (date) => {
                                        if (current_individual.expiry_date !== date)
                                            current_individual.expiry_date = date
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

                        ColumnLayout {
                            Layout.margins: 12
                            spacing: 24

                            CheckBox {
                                checked: current_individual.pep
                                onCheckStateChanged: {
                                    if (current_individual.pep !== checked)
                                        current_individual.pep = checked
                                   }
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
                    }
                }

                BackgroundRect {
                    implicitHeight: childrenRect.height + 24

                    LabeledTextArea {
                        width: parent.width - 24
                        areaHeight: 120
                        x: 12
                        y: 12
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

    footer: RowLayout {

        RoundButton {
            Layout.margins: 12
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: {
                if (current_contact.inserted &&
                    current_address.inserted &&
                    current_individual.inserted) {
                    current_contact.save()
                    current_address.save()
                    current_individual.save()
                }
                else {
                    onLoaded = () => {
                        onLoaded = () => {
                            onLoaded = () => {}
                            current_individual.address_id = current_address.id
                            current_individual.save()
                        }
                        current_individual.contact_id = current_contact.id
                        current_address.save()
                    }
                    current_contact.save()
                }
            }
            highlighted: true
            enabled: current_contact.flagged_for_update ||
                     current_address.flagged_for_update ||
                     current_individual.flagged_for_update
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
                                             onLoaded = () => {
                                                 onLoaded = () => {
                                                     onLoaded = () => {
                                                         onLoaded = () => {}
                                                         rootStack.currentIndex = 1
                                                     }
                                                     individualPage.current_contact.remove()
                                                 }
                                                 individualPage.current_address.remove()
                                             }
                                             individualPage.current_individual.remove()
                                         },
                                         true)
        }
    }

    Connections {
        target: current_contact
        function onLoadingChanged() {
            current_contact.loading ? loading = true : loading = false
        }
    }

    Connections {
        target: current_address
        function onLoadingChanged() {
            current_address.loading ? loading = true : loading = false
        }
    }

    Connections {
        target: current_individual
        function onLoadingChanged() {
            current_individual.loading ? loading = true : loading = false
        }
    }
}
