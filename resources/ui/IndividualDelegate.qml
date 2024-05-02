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

    InvisibleCombo {
        id: familyNameCombo
        model: contactListModel
        valueRole: "id"
        textRole: "family_name"
        currentIndex: indexOfValue(root.model.contact_id)
        Component.onCompleted: currentIndex = indexOfValue(root.model.contact_id)
    }

    InvisibleCombo {
        id: forenamesCombo
        model: contactListModel
        valueRole: "id"
        textRole: "forenames"
        currentIndex: familyNameCombo.currentIndex
    }

    icon.source: "qrc:/icons/user.svg"
    text: familyNameCombo.currentText + ' ' + forenamesCombo.currentText + ' '
          + root.model.local_name + ' ' + root.model.local_forenames +
          (root.model.pep ? "\t PPE" : '')

    onClicked: {
        individualPage.current_individual.from_list(individualListModel, root.model.index)
        individualPage.current_contact.from_list_by(contactListModel,
                                                    "id",
                                                    individualPage.current_individual.contact_id)
        individualPage.current_address.from_list_by(addressListModel,
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
