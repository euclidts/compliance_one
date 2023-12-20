import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

ScrollView {
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    FlickableItem {
        BackgroundRect {
            ColumnLayout {
                width: parent.width
                // Layout.minimumWidth: 200
                enabled: !current_contact.now_loading

                Label {
                    text: qsTr("Individual")
                    font.bold: true
                    Layout.margins: 12
                }

                GridLayout {
                    Layout.margins: 6
                    columns: portrait ? 1 : 2

                    LabeledTextField {
                        name: qsTr("Family Name (Latin script)")
                        textOf: current_contact.family_name
                        onEdit: (txt) => { current_contact.family_name = txt }
                        placeHolder: qsTr("* Mandatory")
                    }

                    LabeledTextField {
                        name: qsTr("Forenames (Latin script)")
                        textOf: current_contact.forenames
                        onEdit: (txt) => { current_contact.forenames = txt }
                        placeHolder: qsTr("* Mandatory")
                        Layout.maximumWidth: portrait ? window.width
                                                      : window.width / 2
                    }

                    LabeledTextField {
                        name: qsTr("Email")
                        textOf: current_contact.email
                        onEdit: (txt) => { current_contact.email = txt }
                        placeHolder: qsTr("* Mandatory")
                        validator: RegularExpressionValidator {
                            regularExpression: /^$|\S+@\S+\.\S+$/
                        }
                        inputHint: Qt.ImhEmailCharactersOnly
                    }

                    PhoneChooser {
                        phoneOf : current_contact.phone
                        codeOf : current_contact.calling_code
                        onPhoneEdit: (txt) => { current_contact.phone = txt }
                        onCodeEdit: (txt) => { current_contact.calling_code = txt }
                        Layout.maximumWidth: portrait ? window.width
                                                      : window.width / 2
                    }
                }

                AddressChooser {
                    Layout.margins: 6
                    countryOf: current_individual.country
                    onCountryEdit: (txt) => { current_individual.country = txt }
                    addressOf: current_individual.address
                    onAddressEdit: (txt) => { current_individual.address = txt }
                    regionOf: current_individual.region
                    onRegionEdit: (txt) => { current_individual.region = txt }
                    postcodeOf: current_individual.postcode
                    onPostcodeEdit: (txt) => { current_individual.postcode = txt }
                    localityOf: current_individual.locality
                    onLocalityEdit: (txt) => { current_individual.locality = txt }
                }

                GridLayout {
                    Layout.margins: 6
                    columns: portrait ? 1 : 2

                    LabeledTextField {
                        name: qsTr("Passport number")
                        textOf: current_individual.passport
                        onEdit: (txt) => { current_individual.passport = txt }
                        placeHolder: qsTr("* Mandatory")
                    }

                    CountryChooser {
                        name: qsTr("Ensuing country")
                        enumOf: current_individual.ensuing
                        onEdit: (value) => { current_individual.ensuing = value }
                    }

                    LabeledTextField {
                        name: qsTr("Name (Local Characters)")
                        textOf: current_individual.local_name
                        onEdit: (txt) => { current_individual.local_name = txt }
                        placeHolder: qsTr("* Optional")
                    }

                    LabeledTextField {
                        name: qsTr("Forenames (Local Characters)")
                        textOf: current_individual.local_forenames
                        onEdit: (txt) => { current_individual.local_forenames = txt }
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
                        onEdit: (value) => { current_individual.pep_country = value }
                    }

                    LabeledTextField {
                        name: qsTr("Additional PEP Notes")
                        textOf: current_individual.pep_notes
                        onEdit: (txt) => { current_individual.pep_notes = txt }
                        placeHolder: qsTr("* Optional")
                    }

                    LabeledTextField {
                        name: qsTr("Notes")
                        textOf: current_individual.notes
                        onEdit: (txt) => { current_individual.notes = txt }
                        placeHolder: qsTr("* Optional")
                    }
                }
            }
        }
    }
}
