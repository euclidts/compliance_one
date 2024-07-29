import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    spacing: 6

    property alias highlightedIndex: combo.highlightedIndex
    property alias hoverEnabled: combo.hoverEnabled
    property alias model: combo.model
    property alias delegate: combo.delegate
    property alias textRole: combo.textRole
    property alias valueRole: combo.valueRole
    property alias name: label.text
    property alias ediatable: combo.editable
    property var enumOf
    required property var onEdit

    onEnumOfChanged: combo.currentIndex = combo.indexOfValue(enumOf)

    Label {
        id: label
        font.italic: true
        visible: text !== ""
    }

    ComboBox {
        id: combo
        Layout.topMargin: 2
        Layout.minimumWidth: 160
        Layout.fillWidth: true
        onActivated: onEdit(currentValue)
        onAccepted: onEdit(currentValue)
        Component.onCompleted: currentIndex = indexOfValue(enumOf)
    }
}
