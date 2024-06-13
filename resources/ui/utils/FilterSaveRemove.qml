import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

RowLayout {

    required property var model
    required property var listModel
    required property var listView

    RoundButton {
        icon.source: "qrc:/icons/floppy-disk.svg"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Save")
        enabled: model.flagged_for_update
        visible: !model.loading
        highlighted: true
        onClicked: listModel.save(
                       listView.view.model.parent_row(
                           model.index)
                       )
    }

    Item {
        Layout.fillWidth: true
        visible: !root.model.loading
    }

    BusyIndicator {
        visible: model.loading
        Layout.fillWidth: true
    }

    RoundButton {
        icon.source: "qrc:/icons/trash-alt.svg"
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Delete")
        Layout.alignment: Qt.AlignRight
        visible: !model.loading
        onClicked: onExceptionAction(ToolTip.text,
                                     qsTr("The selected item will be deleted"),
                                     () => { listModel.remove(
                                             listView.view.model.parent_row(
                                                 model.index)
                                             ) },
                                     true)
    }
}
