import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

GroupBox {
    id: root
    Layout.topMargin: 12
    Layout.fillWidth: true

    property alias countryOf: country.enumOf
    property alias onCountryEdit: country.onEdit
    property alias addressOf: address.textOf
    property alias onAddressEdit: address.onEdit
    property alias localityOf: locality.textOf
    property alias onLocalityEdit: locality.onEdit
    property alias regionOf: region.textOf
    property alias onRegionEdit: region.onEdit
    property alias postcodeOf: postcode.textOf
    property alias onPostcodeEdit: postcode.onEdit

    label: Label {
        text: qsTr("Address")
        font.italic: true
    }

    ColumnLayout {
        spacing: 12
        width: parent.width

        GridLayout {
            columns: portrait ? 1 : 2
            Layout.fillWidth: true

            CountryChooser {
                id: country
            }

            LabeledTextField {
                id: address
                name: qsTr("Address")
                capitalization: Font.MixedCase
                Layout.rowSpan: 4
            }

            LabeledTextField {
                id: locality
                name: qsTr("Locality")
                capitalization: Font.MixedCase
            }

            LabeledTextField {
                id: region
                name: qsTr("Region")
                capitalization: Font.MixedCase
            }

            LabeledTextField {
                id: postcode
                name: qsTr("Postcode")
                capitalization: Font.MixedCase
            }
        }
    }
}
