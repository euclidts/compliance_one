import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import QSortFilter
import Qjurisdiction

ItemDelegate {
    id: root
    width: window.width
    leftInset: 6
    rightInset: 6
    topInset: 3
    bottomInset: 3

    required property var model

    contentItem: GridLayout {
        columns: portrait ? 2 : 3
        enabled: !root.model.loading

        LabeledTextField {
            name: qsTr("Name")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 2
        }

        LabeledTextField {
            name: qsTr("Website")
            textOf: root.model.website
            onEdit: (txt) => { root.model.website = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: portrait ? 2 : 1
        }

        CheckBox {
            id: regionCheck
            checked: root.model.region_id === 0
            onCheckStateChanged: if (root.model.region_id !== 0 && checked)
                                     root.model.region_id = 0
            text: qsTr("Supraregional")
        }

        EnumValueChooser {
            name: qsTr("Region")
            model: regionListModel
            enumOf: root.model.region_id
            onEdit: (value) => { root.model.region_id = value }
            visible: !regionCheck.checked
            valueRole: "id"
            textRole: "name"
        }

        Item { visible: regionCheck.checked }

        Connections {
            target: root.model
            function onIdChanged() {
                jurisdictionFilter.filter_by_variants(["regulator_id", root.model.id])
            }
        }

        ListView {
            interactive: false
            Layout.fillWidth: true
            implicitHeight: contentHeight
            reuseItems: true
            spacing: 6

            header: GridLayout {
                columns: 2

                Label {
                    text: qsTr("Jurisdictions")
                    font.italic: true
                    Layout.columnSpan: jurisdictionChooser.visible ? 2 : 1
                }

                Button {
                    flat: true
                    icon.source: "qrc:/icons/plus.svg"
                    visible: !jurisdictionChooser.visible
                    onClicked: jurisdictionChooser.visible = true
                }

                CountryChooser {
                    id: jurisdictionChooser
                    name: ""
                    visible: false
                    Layout.columnSpan: 2
                    onEdit: (value) => {
                                jurisdictionListModel.addWith(
                                    JSON.parse('{"'
                                               + "regulator_id"
                                               + '" : '
                                               + root.model.id
                                               + ' , "'
                                               + "country_id"
                                               + '" : '
                                               + value
                                               + '}')
                                    )

                                visible = false
                            }
                }
            }

            model: QSortFilter {
                id: jurisdictionFilter
                sourceModel: jurisdictionListModel
                Component.onCompleted: filter_by_variants(["regulator_id", root.model.id])
            }

            delegate: MaterialTextContainer {
                id: jurisdictionBox
                implicitWidth: parent && parent.width
                implicitHeight: Material.textFieldHeight
                outlineColor: Material.hintTextColor

                controlHasText: true
                horizontalPadding: Material.textFieldHorizontalPadding

                required property var model

                RowLayout {
                    anchors.fill: parent

                    Connections {
                        target: jurisdictionBox.model
                        function onCountry_idChanged() {
                            iCountryCombo.currentIndex =
                                    iCountryCombo.indexOfValue(jurisdictionBox.model.country_id)
                        }
                    }

                    InvisibleCombo {
                        id: iCountryCombo
                        model: countryListModel
                        textRole: "name"
                        valueRole: "id"
                        Component.onCompleted:
                            currentIndex = indexOfValue(jurisdictionBox.model.country_id)
                    }

                    Label {
                        leftPadding: Material.textFieldHorizontalPadding
                        text: iCountryCombo.currentText
                    }

                    Button {
                        flat: true
                        Layout.alignment: Qt.AlignRight
                        icon.source: "qrc:/icons/trash-alt.svg"
                        onClicked: onExceptionAction(ToolTip.text,
                                                     qsTr("The selected jurisdiction will be deleted"),
                                                     () => {
                                                         jurisdictionListModel.remove(
                                                             jurisdictionFilter.parent_row(
                                                                 jurisdictionBox.model.index)
                                                             )
                                                     },
                                                     true)
                    }
                }
            }

            footer: Label {
                visible: parent.count === 0
                text: qsTr("Supranational")
            }
        }

        FilterSaveRemove {
            model: root.model
            listModel: regulatorListModel
            listView: root.ListView
            Layout.columnSpan: portrait ? 2 : 3
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
