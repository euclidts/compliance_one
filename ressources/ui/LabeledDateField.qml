import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    spacing: 12

    required property string name
    required property date dateOf
    required property var onEdit

    Label {
        id: label
        text: name
        font.italic: true
    }

    TextField {
        id: field
        text: dateOf.toISOString()
        readOnly: true
        placeholderText: "YYYY-MM-DD"
        Layout.fillWidth: true
        onAccepted: focus = false

        Button {
            flat: true
            checkable: true
            icon.source: "qrc:/icons/calendar-days.svg"
            x: parent.width - width
            onClicked: {
                dateDialog.currentDate = dateOf
                dateDialog.func = onEdit
                dateDialog.open()
            }
        }
    }
}
