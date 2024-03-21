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
    text: root.model.local_name + ' ' + root.model.local_forenames + "PPE: " + root.model.pep

    onClicked : {
        individualPage.current_individual.from_list(individual_list, root.model.index)
        individualPage.current_contact.from_list_by(contact_list,
                                                    "id",
                                                    individualPage.current_individual.contact_id)
        individualPage.current_address.from_list_by(address_list,
                                                    "id",
                                                    individualPage.current_individual.address_id)
        rootStack.currentIndex = 1
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
