import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ItemDelegate {
    id: root
    width: parent && parent.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    icon.source: "qrc:/icons/user.svg"
    text: root.model.family_name + ' ' + root.model.forenames + ' '
          + root.model.local_name + ' ' + root.model.local_forenames +
          (root.model.pep ? "\t PPE" : '')

    onClicked: {
        individualPage.current_contact.id = root.model.contact_id
        individualPage.current_contact.get()
        individualPage.current_address.id = root.model.address_id
        individualPage.current_address.get()
        individualPage.current_individual.id = root.model.id
        individualPage.current_individual.get()

        rootStack.currentIndex = 2
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
