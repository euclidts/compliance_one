import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    spacing: 12

    required property var phoneOf
    property int capitalization: Font.Capitalize

    Label {
        id: label
        Layout.topMargin: 6
        text: qsTr("phone")
        font.italic: true
    }

    RowLayout {
        Layout.topMargin: -6
        ComboBox {
            id: codeBox
            Layout.maximumWidth: 90

            model: ListModel {
                ListElement {
                    text: "SUI"
                    code: "+41"
                }
                ListElement {
                    text: "FRA"
                    code: "+33"
                }
                ListElement {
                    text: "DEU"
                    code: "+49"
                }
                ListElement {
                    text: "ITA"
                    code: "+39"
                }
                ListElement {
                    text: "IRL"
                    code: "+353"
                }
            }
            textRole: "text"
            valueRole: "code"
            Component.onCompleted: currentIndex = indexOfValue(phoneOf.calling_code)
            onActivated: { phoneOf.calling_code = currentValue }
        }

        TextField {
            Layout.maximumWidth: 90
            text: phoneOf.calling_code
            onAccepted: phoneOf.calling_code = text
            validator: RegularExpressionValidator {
                regularExpression: /^(\+\d{1,3})|(\d{3,5})/
            }
            onTextChanged: acceptableInput ? color = Material.foreground
                                           : color = "red"
        }

        TextField {
            text: phoneOf.phone
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            Layout.fillWidth: true
            placeholderText: qsTr("* Mandatory")
            onAccepted: phoneOf.phone = text
            validator: RegularExpressionValidator {
                regularExpression: /^$|\d{6,13}?$/
            }
            onTextChanged: acceptableInput ? color = Material.foreground
                                           : color = "red"
        }
    }
}
