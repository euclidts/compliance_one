import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    spacing: 12

    required property string phoneOf
    required property var onPhoneEdit
    required property string codeOf
    required property var onCodeEdit
    property int capitalization: Font.Capitalize

    onCodeOfChanged: codeBox.currentIndex = codeBox.indexOfValue(codeOf)

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
            model: countryListView.model
            textRole: "iso3"
            valueRole: "phonecode"
            delegate: MenuItem {
                width: ListView.view.width
                text: model["emoji"] + ' ' + model["iso3"]
                Material.foreground: codeBox.currentIndex === index ?
                                         ListView.view.contentItem.Material.accent :
                                         ListView.view.contentItem.Material.foreground
                highlighted: codeBox.highlightedIndex === index
                hoverEnabled: codeBox.hoverEnabled
            }
            onActivated: codeField.text = currentValue
        }

        TextField {
            id: codeField
            Layout.maximumWidth: 90
            text: codeOf
            onAccepted: focus = false
            validator: RegularExpressionValidator {
                regularExpression: /^(\+\d{1,3})|(\d{1,5})|(\d{1,3}\-\d{2,5})|(\+\d{1,3}\-\d{2,5})/
            }
            onTextChanged: if (acceptableInput) {
                               color = Material.foreground
                               onCodeEdit(text)
                               codeBox.currentIndex = codeBox.indexOfValue(text)
                           } else {
                               color = "red"
                               codeBox.currentIndex = -1
                           }
        }

        TextField {
            text: phoneOf
            inputMethodHints: Qt.ImhDialableCharactersOnly
            Layout.fillWidth: true
            placeholderText: qsTr("* Mandatory")
            onAccepted: focus = false
            validator: RegularExpressionValidator {
                regularExpression: /^$|\d{6,13}?$/
            }
            onTextChanged: if (acceptableInput) {
                               color = Material.foreground
                               onPhoneEdit(text)
                           } else color = "red"
        }
    }
}
