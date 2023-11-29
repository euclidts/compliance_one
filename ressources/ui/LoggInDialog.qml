import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Dialog {
    modal: true
    closePolicy: Popup.NoAutoClose
    background.opacity: .8
    x: Math.round((parent.width - width) / 2)
    y: 120
    implicitWidth: 270

    function validate() {
        bridge.authenticate(userNameField.text,
                            passwordField.text)
        logginDialog.close()
        busyDialog.open()
    }

    function clear() { passwordField.text = "" }

    contentItem: ColumnLayout {
        spacing: 15

        Image {
            id: logo
            source: "qrc:/icons/C1_logov1.svg"
            Layout.fillWidth: true
            Layout.preferredHeight: width
            fillMode: Image.PreserveAspectFit
        }

        TextField {
            id: userNameField
            Layout.fillWidth: true
            placeholderText: qsTr("Username")
            onAccepted: passwordField.text !== "" ? validate()
                                                   : passwordField.fieldFocus = true
        }

        PwdField {
            id: passwordField
            onFieldAccepted: function () {
                userNameField.text !== "" ? validate()
                                          : userNameField.focus = true
            }
        }

        RoundButton {
            id: validationButton
            icon.source: "qrc:/icons/door-open.svg"
            text: qsTr("Logg in")
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.bold: true
            highlighted: passwordField.text !== "" && userNameField.text !== ""
            onClicked: if (passwordField.text !== "" && userNameField.text !== "")
                           validate()
        }

        Component.onCompleted: {
            userNameField.focus = true
            sovereignty_list.get()
            country_list.get()
            product_group_list.get()
            product_list.get()
        }
    }
}

