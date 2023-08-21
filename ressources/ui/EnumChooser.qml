import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    Layout.topMargin: 2
    spacing: 6

    property alias model: combo.model
    required property string name
    required property string enumOf
    required property var onEdit

    Label {
        id: label
        text: name
        font.italic: true
    }

    ComboBox {
        id: combo
        Layout.minimumWidth: 160
        Component.onCompleted: currentIndex = enumOf
        onActivated: onEdit(currentIndex)
    }
}
