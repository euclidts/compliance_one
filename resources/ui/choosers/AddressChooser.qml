import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import "../utils" as Utils

Utils.BackgroundRect {

    property string label
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

    GridLayout {
        columns: portrait ? 1 : 2
        width: parent.width
        uniformCellWidths: true

        Label {
            Layout.margins: 12
            text: label && label
            font.bold: true
            visible: label
            Layout.columnSpan: portrait ? 1 : 2
        }

        CountryChooser {
            id: country
            Layout.margins: 12
        }

        Utils.LabeledTextArea {
            id: address
            Layout.margins: 12
            name: qsTr("Address")
            capitalization: Font.MixedCase
            Layout.rowSpan: 4
        }

        Utils.LabeledTextField {
            id: locality
            Layout.margins: 12
            name: qsTr("Locality")
            capitalization: Font.MixedCase
        }

        Utils.LabeledTextField {
            id: region
            Layout.margins: 12
            name: qsTr("Region")
            capitalization: Font.MixedCase
        }

        Utils.LabeledTextField {
            id: postcode
            Layout.margins: 12
            name: qsTr("Postcode")
            capitalization: Font.MixedCase
        }
    }
}
