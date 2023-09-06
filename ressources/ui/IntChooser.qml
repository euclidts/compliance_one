import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

ColumnLayout {
    spacing: 12

    required property int numberOf
    required property string name
    property var onEdit
    property int minimum: 0
    property int maximum
    property int step: 1
    property alias spin: spin
    property alias editable: spin.editable

    Label {
        text: name
        font.italic: true
        Layout.topMargin: -6
    }

    SpinBox {
        id: spin
        from: minimum
        to: maximum
        stepSize: step
        value: numberOf
        locale: Qt.locale()
        onFocusChanged: if (focus) contentItem.selectAll()
        onValueModified: onEdit(value)
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }
}
