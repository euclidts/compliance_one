import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    Layout.topMargin: 2
    spacing: 6

    property alias currentIndex: combo.currentIndex
    property alias highlightedIndex: combo.highlightedIndex
    property alias hoverEnabled: combo.hoverEnabled
    property alias model: combo.model
    property alias delegate: combo.delegate
    property alias textRole: combo.textRole
    property alias valueRole: combo.valueRole
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
        Layout.topMargin: 2
        editable: false
        Layout.minimumWidth: 160
        Layout.fillWidth: true
        Component.onCompleted: currentIndex = indexOfValue(enumOf)
        onActivated: onEdit(currentValue)
    }
}
