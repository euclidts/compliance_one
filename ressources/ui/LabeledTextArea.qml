import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    spacing: 12

    property string placeHolder
    property alias readOnly: field.readOnly
    required property string name
    required property string textOf
    required property var onEdit
    property int inputHint: Qt.ImhNone
    property int capitalization: Font.MixedCase

    Label {
        id: label
        text: name
        font.italic: true
    }

    TextArea {
        id: field
        text: textOf
        inputMethodHints: inputHint
        placeholderText: placeHolder
        Layout.fillWidth: true
        Layout.fillHeight: true
        font.capitalization: capitalization
        onTextChanged: onEdit(text)
    }
}
