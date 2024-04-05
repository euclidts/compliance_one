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

    function connect() {
        bridge.setHost(hostField.text)
        countryListModel.get()
        product_groupListModel.get()
        productListModel.get()
        ctp_groupListModel.get()
        ctp_typeListModel.get()
        exchangeListModel.get()
        userNameField.focus = true
    }

    function validate() {
        bridge.authenticate(userNameField.text, passwordField.text)
        loginDialog.close()
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
            id:hostField
            Layout.fillWidth: true
            placeholderText: qsTr("Host")
            // text: "http://10.133.2.57:8080"
            text: "https://complianceonetestrive.euclidtradingsystems.com"
            onAccepted: connect()
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
            text: qsTr("Log in")
            Layout.fillWidth: true
            font.capitalization: Font.MixedCase
            font.bold: true
            highlighted: passwordField.text !== "" && userNameField.text !== ""
            onClicked: if (passwordField.text !== "" && userNameField.text !== "")
                           validate()
        }

        Component.onCompleted: connect()
    }
}

