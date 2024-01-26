import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    Layout.topMargin: 2
    spacing: 6

    property alias model: combo.model
    property alias delegate: combo.delegate
    property alias textRole: combo.textRole
    property alias name: label.text
    required property string enumOf
    required property var onEdit

    onEnumOfChanged: combo.currentIndex = combo.indexOfValue(enumOf)

    Label {
        id: label
        font.italic: true
    }

    ComboBox {
        id: combo
        Layout.topMargin: 2
        editable: false
        Layout.minimumWidth: 160
        onActivated: onEdit(currentIndex)
    }
}
