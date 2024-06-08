import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import "../utils" as Utils

Utils.BackgroundRect {

    property string label
    property alias familyNameOf: familyNameField.textOf
    property alias onFamilyNameEdit: familyNameField.onEdit
    property alias forenamesOf: forenamesField.textOf
    property alias onForenamesEdit: forenamesField.onEdit
    property alias emailOf: emailField.textOf
    property alias onEmailEdit: emailField.onEdit
    property alias phoneOf: phoneField.phoneOf
    property alias onPhoneEdit: phoneField.onPhoneEdit
    property alias codeOf: phoneField.codeOf
    property alias onCodeEdit: phoneField.onCodeEdit

    GridLayout {
        width: parent.width
        columnSpacing: 0
        rowSpacing: 0
        uniformCellWidths: true
        columns: portrait ? 1 : 2

        Label {
            Layout.margins: 12
            text: label && label
            font.bold: true
            visible: label
            Layout.columnSpan: portrait ? 1 : 2
        }

        Utils.LabeledTextField {
            id: familyNameField
            Layout.margins: 12
            name: qsTr("Family Name (Latin script)")
            placeHolder: qsTr("* Mandatory")
        }

        Utils.LabeledTextField {
            id: forenamesField
            Layout.margins: 12
            name: qsTr("Forenames (Latin script)")
            placeHolder: qsTr("* Mandatory")
        }

        Utils.LabeledTextField {
            id: emailField
            Layout.margins: 12
            name: qsTr("Email")
            placeHolder: qsTr("* Mandatory")
            validator: RegularExpressionValidator {
                regularExpression: /^$|\S+@\S+\.\S+$/
            }
            inputHint: Qt.ImhEmailCharactersOnly
        }

        PhoneChooser {
            id: phoneField
            Layout.margins: 12
        }
    }
}
