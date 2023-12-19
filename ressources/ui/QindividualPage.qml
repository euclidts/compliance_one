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
                        // readOnly: current_contact.now_loading
                    }

                    LabeledTextField {
                        name: qsTr("Forenames (Latin script)")
                        textOf: current_contact.forenames
                        onEdit: (txt) => { current_contact.forenames = txt }
                        placeHolder: qsTr("* Mandatory")
                        Layout.maximumWidth: portrait ? window.width
                                                      : window.width / 2
                        // readOnly: current_contact.now_loading
                    }

                    LabeledTextField {
                        name: qsTr("Email")
                        textOf: current_contact.email
                        onEdit: (txt) => { current_contact.email = txt }
                        placeHolder: qsTr("* Mandatory")
                        validator: RegularExpressionValidator {
                            regularExpression: /^$|\S+@\S+\.\S+$/
                        }
                        // readOnly: current_contact.now_loading
                    }

                    PhoneChooser {
                        phoneOf : current_contact
                        Layout.maximumWidth: portrait ? window.width
                                                      : window.width / 2
                    }
                }

                AddressChooser {
                    Layout.margins: 6
                    // addressOf: model
                }

                GridLayout {
                    Layout.margins: 6
                    columns: portrait ? 1 : 2

                    EnumIntChooser {
                        name: "Role"
                        model: [
                            "owner",
                            "director",
                            "intermediary",
                            "other"
                        ]
                    }

                    LabeledTextField {
                        name: qsTr("Individual Unique Identifier")
                        // textOf: current_contact.family_name
                        // onEdit: (txt) => { current_contact.family_name = txt }
                        placeHolder: qsTr("* Mandatory")
                        // readOnly: current_contact.now_loading
                    }

                    LabeledTextField {
                        name: qsTr("Name (Local Characters)")
                        // textOf: current_contact.family_name
                        // onEdit: (txt) => { current_contact.family_name = txt }
                        placeHolder: qsTr("* Optional")
                        // readOnly: current_contact.now_loading
                    }

                    LabeledTextField {
                        name: qsTr("Forenames (Local Characters)")
                        // textOf: current_contact.forenames
                        // onEdit: (txt) => { current_contact.forenames = txt }
                        placeHolder: qsTr("* Optional")
                        // readOnly: current_contact.now_loading
                    }

                    CheckBox {
                        // checked: exterior.hasParking
                        // onCheckStateChanged: exterior.hasParking = checked
                        text: qsTr("Is a PEP")
                    }

                    EnumValueChooser {
                        name: qsTr("Country")
                        model: countryListView.model
                        // enumOf: root.model.sovereignty_id
                        Layout.fillWidth: true
                        valueRole: "id"
                        textRole: "country_name"
                    }

                    LabeledTextField {
                        name: qsTr("Additional PEP Notes")
                        // textOf: current_contact.family_name
                        // onEdit: (txt) => { current_contact.family_name = txt }
                        placeHolder: qsTr("* Optional")
                        // readOnly: current_contact.now_loading
                    }

                    LabeledTextField {
                        name: qsTr("Notes")
                        // textOf: current_contact.forenames
                        // onEdit: (txt) => { current_contact.forenames = txt }
                        placeHolder: qsTr("* Optional")
                        // readOnly: current_contact.now_loading
                    }
                }
            }
        }
    }
}
