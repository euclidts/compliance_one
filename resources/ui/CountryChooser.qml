import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

EnumValueChooser {
    id: countryCombo
    name: qsTr("Country")
    model: countryListModel
    Layout.fillWidth: true
    ediatable: true
    valueRole: "id"
    textRole: "name"
    delegate: MenuItem {
        width: ListView.view.width
        text: model["emoji"] + ' ' + model["name"]
        Material.foreground: countryCombo.currentIndex === index ?
                                 ListView.view.contentItem.Material.accent :
                                 ListView.view.contentItem.Material.foreground
        highlighted: countryCombo.highlightedIndex === index
        hoverEnabled: countryCombo.hoverEnabled
    }
}
