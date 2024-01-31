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

    icon.source: "qrc:/icons/user.svg"
    text: root.model.local_name + " " + root.model.local_forenames

    onClicked : {
        individual_list.select(root.model.index)
        contact_list.select_by("id", current_individual.contact_id)
        address_list.select_by("id", current_individual.address_id)
        rootStack.currentIndex = 1
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
