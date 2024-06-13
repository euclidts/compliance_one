import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

RowLayout {

    required property list<var> saveSequence
    required property list<var> deleteSequence
    property alias enableSave: saveBtn.enabled
    property alias busy: busyIndicator.visible

    RoundButton {
        id: saveBtn
        Layout.margins: 12
        icon.source: "qrc:/icons/floppy-disk.svg"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Save")
        highlighted: true
        visible: !busyIndicator.visible
        onClicked: {
            enqueue(saveSequence)
            dequeue()
        }
    }

    BusyIndicator {
        id: busyIndicator
        Layout.fillWidth: true
    }

    RoundButton {
        Layout.margins: 12
        icon.source: "qrc:/icons/trash-alt.svg"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Delete")
        Layout.alignment: Qt.AlignRight
        visible: !busyIndicator.visible
        onClicked: onExceptionAction(ToolTip.text,
                                     qsTr("The item will be deleted"),
                                     () => {
                                         enqueue(deleteSequence)
                                         dequeue()
                                     },
                                     true)
    }
}
