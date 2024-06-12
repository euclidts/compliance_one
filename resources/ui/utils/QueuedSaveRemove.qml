import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

RowLayout {

    required property list<var> saveSequence
    required property list<var> deleteSequence
    property alias enableSave: saveBtn.enabled

    RoundButton {
        id: saveBtn
        Layout.margins: 12
        icon.source: "qrc:/icons/floppy-disk.svg"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Save")
        onClicked: {
            enqueue(saveSequence)
            dequeue()
        }
        highlighted: true
    }

    RoundButton {
        Layout.margins: 12
        icon.source: "qrc:/icons/trash-alt.svg"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Delete")
        Layout.alignment: Qt.AlignRight
        onClicked: onExceptionAction(ToolTip.text,
                                     qsTr("The item will be deleted"),
                                     () => {
                                         enqueue(deleteSequence)
                                         dequeue()
                                     },
                                     true)
    }
}
