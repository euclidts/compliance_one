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

    icon.source: "qrc:/icons/industry.svg"
    text: root.model.name + ' ' + root.model.local_name + ' '

    onClicked : {
        companyPage.current_contact.id = root.model.contact_id
        companyPage.current_contact.get()
        companyPage.current_address.id = root.model.address_id
        companyPage.current_address.get()
        companyPage.current_company.id = root.model.id
        companyPage.current_company.get()

        rootStack.currentIndex = 3
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
