import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

RowLayout {
    spacing: 0

    property var onFieldAccepted
    property string placeholder: qsTr("YYYY-MM-DD")
    property alias text: field.text

    TextField {
        id: field
        Layout.fillWidth: true
        placeholderText: placeholder
        rightPadding: Material.textFieldHorizontalPadding + 50
        onAccepted: onFieldAccepted()

        Button {
            flat: true
            checkable: true
            icon.source: checked ? "qrc:/icons/eye-slash.svg"
                                 : "qrc:/icons/eye.svg"
            x: parent.width - width
            onClicked: {
                DateDialog.currentDate
            }
        }
    }
}
