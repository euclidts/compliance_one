import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import "../utils" as Utils
import "../choosers" as Choosers

import Qcontact
import Qaddress
import Qcompany

Page {
    property var current_contact : SingleQcontact {}
    property var current_address : SingleQaddress {}
    property var current_company : SingleQcompany {}

    background: Rectangle { color: "transparent" }

    header: RowLayout {

        Button {
            id: backButton
            icon.source: "qrc:/icons/arrow-left.svg"
            flat: true
            onClicked: rootStack.currentIndex = 1
        }

        Label {
            text: qsTr("Company")
            font.bold: true
        }
    }

    contentItem: ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        Utils.FlickableItem {
            ColumnLayout {
                width: parent.width
                spacing: 12

                Utils.BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        uniformCellWidths: true
                        uniformCellHeights: true
                        columns: portrait ? 1 : 2

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Company Name (Latin script)")
                            textOf: current_company.name
                            onEdit: (txt) => {
                                        if (current_company.name !== txt)
                                            current_company.name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Company Name (Local Characters)")
                            textOf: current_company.local_name
                            onEdit: (txt) => {
                                        if (current_company.local_name !== txt)
                                            current_company.local_name = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Website")
                            textOf: current_company.website
                            onEdit: (txt) => {
                                        if (current_company.website !== txt)
                                            current_company.website = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Company Unique Identifier")
                            textOf: current_company.uuid
                            onEdit: (txt) => {
                                        if (current_company.uuid !== txt)
                                            current_company.uuid = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }
                    }
                }

                Choosers.AddressChooser {
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

                Choosers.ContatChooser {
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

                Utils.BackgroundRect {
                    GridLayout {
                        width: parent.width
                        columnSpacing: 0
                        rowSpacing: 0
                        columns: portrait ? 1 : 2
                        uniformCellWidths: true

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Commercial Registry Number")
                            textOf: current_company.comercial_registery
                            onEdit: (txt) => {
                                        if (current_company.comercial_registery !== txt)
                                            current_company.comercial_registery = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        Item { visible: !portrait }

                        CheckBox {
                            checked: current_company.pep
                            onCheckStateChanged: if (current_company.pep !== checked)
                                                     current_company.pep = checked
                            text: qsTr("Associated PEPs")
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

                        Utils.LabeledTextField {
                            Layout.margins: 12
                            name: qsTr("Legal Entitiy Identifier (LEI)")
                            textOf: current_company.lei
                            onEdit: (txt) => {
                                        if (current_company.lei !== txt)
                                            current_company.lei = txt
                                    }
                            placeHolder: qsTr("* Mandatory")
                        }

                        Utils.LabeledTextField {
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

                        Item { visible: !portrait }

                        Choosers.CountryChooser {
                            name: qsTr("Country of Listing")
                            Layout.margins: 12
                            enumOf: current_company.listing_country_id
                            onEdit: (value) => {
                                        if (current_company.listing_country_id !== value)
                                            current_company.listing_country_id = value
                                    }
                            visible: current_company.is_public
                        }

                        Choosers.EnumValueChooser {
                            id: exchangeCombo
                            name: qsTr("Exchange")
                            model: exchangeListModel
                            Layout.margins: 12
                            valueRole: "code"
                            textRole: "description"
                            delegate: MenuItem {
                                width: ListView.view.width
                                text: model["code"] + ' - ' + model["description"]
                                Material.foreground: exchangeCombo.currentIndex === index ?
                                                         ListView.view.contentItem.Material.accent :
                                                         ListView.view.contentItem.Material.foreground
                                highlighted: exchangeCombo.highlightedIndex === index
                                hoverEnabled: exchangeCombo.hoverEnabled
                            }
                            enumOf: current_company.exchange
                            onEdit: (value) => {
                                        if (current_company.exchange !== value)
                                            current_company.exchange = value
                                    }
                            visible: current_company.is_public
                        }

                        CheckBox {
                            checked: current_company.is_branch
                            onCheckStateChanged: if (current_company.is_branch !== checked)
                                                     current_company.is_branch = checked
                            text: qsTr("Is a Branch")
                        }

                        Item { visible: !current_company.is_branch }

                        Utils.LabeledTextField {
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
                    current_company.inserted) {
                        current_contact.save()
                        current_address.save()
                        current_company.save()
                } else {
                    onLoaded = () => {
                        onLoaded = () => {
                            onLoaded = () => {}
                            current_company.address_id = current_address.id
                            current_company.save()
                        }
                        current_company.contact_id = current_contact.id
                        current_address.save()
                    }
                    current_contact.save()
                }
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
                                                     onLoaded = () => {
                                                         onLoaded = () => {}
                                                         rootStack.currentIndex = 1
                                                     }
                                                     companyPage.current_contact.remove()
                                                 }
                                                 companyPage.current_address.remove()
                                             }
                                             companyPage.current_comapny.remove()
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
        target: current_company
        function onLoadingChanged() {
            current_company.loading ? loading = true : loading = false
        }
    }
}
