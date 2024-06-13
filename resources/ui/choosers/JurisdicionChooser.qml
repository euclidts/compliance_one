import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material.impl

import "../utils" as Utils
import "../choosers" as Choosers

import QSortFilter
import Qjurisdiction

ListView {
    interactive: false
    Layout.fillWidth: true
    implicitHeight: contentHeight
    reuseItems: true
    spacing: 6

    required property var parentModel

    header: GridLayout {
        width: parent && parent.width
        columns: 2

        Label {
            text: qsTr("Jurisdictions")
            font.italic: true
            Layout.columnSpan: jurisdictionChooser.visible ? 2 : 1
            Layout.maximumWidth: 20
        }

        Button {
            flat: true
            icon.source: "qrc:/icons/plus.svg"
            visible: !jurisdictionChooser.visible
            onClicked: jurisdictionChooser.visible = true
        }

        Choosers.CountryChooser {
            id: jurisdictionChooser
            name: ""
            visible: false
            Layout.columnSpan: 2
            onEdit: (value) => {
                        jurisdictionListModel.add_with(
                            JSON.parse('{"'
                                       + "regulator_id"
                                       + '" : '
                                       + parentModel.id
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

    Connections {
        target: parentModel
        function onIdChanged() {
            jurisdictionFilter.filter_by_variants(["regulator_id", parentModel.id])
        }
    }

    model: QSortFilter {
        id: jurisdictionFilter
        sourceModel: jurisdictionListModel
        Component.onCompleted: filter_by_variants(["regulator_id", parentModel.id])
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

            Utils.InvisibleCombo {
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
                icon.source: "qrc:/icons/times-circle.svg"
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
