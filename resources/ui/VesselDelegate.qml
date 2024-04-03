import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ItemDelegate {
    id: root
    width: parent.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    icon.source: "qrc:/icons/ship.svg"
    text: root.model.name

    onClicked : {
        vesselPage.current_vessel.from_list(vesselListModel, root.model.index)
        rootStack.currentIndex = 3
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
