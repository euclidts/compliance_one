import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    spacing: 12

    required property string name
    required property date dateOf
    required property var onEdit

    function openCal () {
        dateDialog.currentDate = dateOf
        dateDialog.func = onEdit
        dateDialog.open()
    }

    Label {
        id: label
        text: name
        font.italic: true
    }

    TextField {
        id: field
        text: dateOf.toLocaleDateString(Locale.ShortFormat)
        readOnly: true
        placeholderText: qsTr(locale.dateFormat(Locale.ShortFormat))
        Layout.fillWidth: true

        MouseArea {
            anchors.fill: parent
            onClicked: openCal()
        }

        IconImage {
            source: "qrc:/icons/calendar-days.svg"
            x: parent.width - width - 12
            y: 12
            color: Material.accent
            height: parent.height - 24
        }
    }
}
