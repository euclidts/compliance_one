import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

ScrollView {
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    FlickableItem {
        BackgroundRect {
            ColumnLayout {
                width: parent.width
                Layout.minimumWidth: 200

                Label {
                    text: qsTr("Individual")
                    font.bold: true
                    Layout.margins: 12
                }

                GridLayout {
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
            }
        }
    }
}
