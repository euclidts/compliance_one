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

    icon.source: "qrc:/icons/industry.svg"
    text: root.model.name

    onClicked : {
        company.select(root.model.index)
        // individual_list.select_by("contact_id", root.model.id)
        // address_list.select_by("id", current_individual.address_id)
        rootStack.currentIndex = 2
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
