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
                            textOf: current_company.Local_name
                            onEdit: (txt) => {
                                        if (current_company.local_name !== txt)
                                        current_company.local_name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("website")
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

                        CheckBox {
                            checked: current_company.is_public;
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
                            Layout.columnSpan: current_company.is_branch ? 1 : 2
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
                            name: qsTr("Legal Entitiy Identifier (LEI)")
                            textOf: current_company.uuid
                            onEdit: (txt) => {
                                        if (current_company.uuid !== txt)
                                        current_company.uuid = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }
                    }
                }

                // AddressChooser {
                //     countryOf: current_address.country_id
                //     onCountryEdit: (value) => {
                //                        if (current_address.country_id !== value)
                //                        current_address.country_id = value
                //                    }
                //     addressOf: current_address.address_lines
                //     onAddressEdit: (txt) => {
                //                        if (current_address.address_lines !== txt)
                //                        current_address.address_lines = txt
                //                    }
                //     regionOf: current_address.region
                //     onRegionEdit: (txt) => {
                //                       if (current_address.region !== txt)
                //                       current_address.region = txt
                //                   }
                //     postcodeOf: current_address.postcode
                //     onPostcodeEdit: (txt) => {
                //                         if (current_address.postcode !== txt)
                //                         current_address.postcode = txt
                //                     }
                //     localityOf: current_address.locality
                //     onLocalityEdit: (txt) => {
                //                         if (current_address.locality !== txt)
                //                         current_address.locality = txt
                //                     }
                // }

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
                            name: qsTr("Isssuing country")
                            enumOf: current_individual.issuing
                            onEdit: (value) => {
                                        if (current_individual.issuing !== value)
                                            current_individual.issuing = value
                                    }
                        }

                        LabeledDateField {
                            Layout.margins: 12
                            name: qsTr("Expeiry date")
                            dateOf: current_individual.expeiry_date
                            onEdit: (date) => {
                                        if (current_individual.expeiry_date !== date)
                                        current_individual.expeiry_date = date
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
                                onCheckStateChanged: if (current_individual.pep !== checked)
                                                         current_individual.pep = checked
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
                if (current_address.flagged_for_update)
                    onLoaded = () => {
                        current_address.save()
                        onLoaded = () => {
                            current_individual.contact_id = current_contact.id
                            current_individual.address_id = current_address.id
                            current_individual.save()
                        }
                    }
                current_contact.save()
            }
            highlighted: true
            enabled: current_contact.flagged_for_update ||
                     current_individual.flagged_for_update ||
                     current_address.flagged_for_update
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
                                                 current_address.remove()
                                                 onLoaded = () => {
                                                     current_contact.remove()
                                                     onLoaded = () => { rootStack.currentIndex = 0 }
                                                 }
                                             }
                                             current_individual.remove()
                                         }, true)
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
}
