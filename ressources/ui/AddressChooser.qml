import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

GroupBox {
    id: root
    Layout.topMargin: 12
    Layout.fillWidth: true

    // required property var addressOf

    label: Label {
        text: qsTr("Adress")
        font.italic: true
    }

    ColumnLayout {
        spacing: 12
        width: parent.width

        GridLayout {
            columns: portrait ? 1 : 2
            Layout.fillWidth: true

            EnumValueChooser {
                id: countryCombo
                name: qsTr("Country")
                model: countryListView.model
                // enumOf: root.model.sovereignty_id
                Layout.fillWidth: true
                valueRole: "id"
                textRole: "country_name"
            }

            IntChooser {
                name: qsTr("ZIP")
                minimum: 1000
                maximum: 9999
                // numberOf: addressOf.zip
                // onEdit: (val) => { addressOf.zip = val }
                spin.textFromValue: (value, locale) => {
                    return Number(value).toString();
                }
            }

            LabeledTextField {
                name: qsTr("City")
                // textOf: addressOf.city
                // onEdit: function(txt) { addressOf.city = txt }
                capitalization: Font.MixedCase
            }

            LabeledTextField {
                name: qsTr("Street")
                // textOf: addressOf.street
                // onEdit: function(txt) { addressOf.street = txt }
                capitalization: Font.MixedCase
            }
        }
    }
}
