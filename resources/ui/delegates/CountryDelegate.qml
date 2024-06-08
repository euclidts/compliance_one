import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../utils" as Utils
import "../choosers" as Choosers

ItemDelegate {
    id: root
    width: window.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    contentItem: RowLayout {

        Button {
            id: dropIndicator
            flat: true
            checkable: true
            icon.source: "qrc:/qt-project.org/imports/QtQuick/Controls/Material/images/drop-indicator.png"
            icon.height: height
            icon.width: width
            rotation: checked ? 0 : -90
        }

        Label {
            visible: !dropIndicator.checked
            Layout.fillWidth: true
            text: root.model.emoji + ' ' + root.model.iso3 + '\t' + root.model.name
        }

        GridLayout {
            visible: dropIndicator.checked
            Layout.fillWidth: true
            columns: portrait ? 2 : 4
            enabled: !root.model.loading

            Utils.LabeledTextField {
                name: qsTr("Name")
                textOf: root.model.name
                onEdit: (txt) => { root.model.name = txt }
                placeHolder: qsTr("* Mandatory")
            }

            Choosers.EnumValueEditor {
                name: qsTr("Region")
                model: regionListModel
                enumOf: root.model.region_id
                onEdit: (value) => { root.model.region_id = value }
                valueRole: "id"
                textRole: "name"
            }

            CheckBox {
                id: unCheck
                checked: root.model.sovereignty_id === 0
                onCheckStateChanged: if (root.model.sovereignty_id !== 0 && checked)
                                         root.model.sovereignty_id = 0
                text: qsTr("UN Member State")
            }

            Choosers.CountryChooser {
                name: qsTr("Sovereignty")
                enumOf: root.model.sovereignty_id
                onEdit: (value) => { root.model.sovereignty_id = value }
                visible: !unCheck.checked
            }

            Item { visible: unCheck.checked }

            RowLayout {
                Utils.LabeledTextField {
                    name: qsTr("ISO 3")
                    textOf: root.model.iso3
                    onEdit: (txt) => { root.model.iso3 = txt }
                    placeHolder: qsTr("* Mandatory")
                }

                Utils.LabeledTextField {
                    name: qsTr("Flag")
                    textOf: root.model.emoji
                    onEdit: (txt) => { root.model.emoji = txt }
                }
            }
            Utils.LabeledTextField {
                name: qsTr("Numeric code")
                textOf: root.model.numeric_code
                onEdit: (txt) => { root.model.numeric_code = txt }
                placeHolder: qsTr("* Mandatory")
            }

            Utils.LabeledTextField {
                name: qsTr("Calling code")
                textOf: root.model.phonecode
                onEdit: (txt) => { root.model.phonecode = txt }
                placeHolder: qsTr("* Mandatory")
                validator: RegularExpressionValidator {
                    regularExpression: /^(\+\d{1,3})|(\d{1,5})|(\d{1,3}\-\d{2,5})|(\+\d{1,3}\-\d{2,5})/
                }
            }

            // Item {}

            // LabeledTextField {
            //     name: qsTr("Latitude")
            //     textOf: root.model.latitude
            //     onEdit: (val) => { root.model.latitude = val }
            //     validator: DoubleValidator {
            //         bottom: Math.min(-90.0, 90.0)
            //         top:  Math.max(-90.0, 90.0)
            //         decimals: 8
            //         notation: DoubleValidator.StandardNotation
            //     }
            // }

            // LabeledTextField {
            //     name: qsTr("Longitude")
            //     textOf: root.model.longitude
            //     onEdit: (val) => { root.model.longitude = val }
            //     validator: DoubleValidator {
            //         bottom: Math.min(-180.0, 180.0)
            //         top:  Math.max(-180.0, 180.0)
            //         decimals: 8
            //         notation: DoubleValidator.StandardNotation
            //     }
            // }

        Utils.LabeledTextField {
            name: qsTr("WikiData")
            textOf: root.model.wikiDataId
            onEdit: (txt) => { root.model.wikiDataId = txt }
        }

            Choosers.EnumIntChooser {
                name: qsTr("Internal Ranking")
                model: rateModel
                enumOf: root.model.ranking
                onEdit: (index) => { root.model.ranking = index }
            }

            Choosers.EnumIntChooser {
                name: qsTr("FATF")
                model: rateModel
                enumOf: root.model.fatf
                onEdit: (index) => { root.model.fatf = index }
            }

            Choosers.IntChooser {
                name: qsTr("Transparency International")
                minimum: 1
                maximum: 10
                numberOf: root.model.transparency
                onEdit: (val) => { root.model.transparency = val }
            }

            Choosers.IntChooser {
                name: qsTr("World Bank")
                minimum: 1
                maximum: 10
                numberOf: root.model.world_bank
                onEdit: (val) => { root.model.world_bank = val }
            }

            Utils.FilterSaveRemove {
                model: root.model
                listModel: countryListModel
                listView: root.ListView
                Layout.fillWidth: true
                Layout.columnSpan: portrait ? 2 : 4
            }
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
