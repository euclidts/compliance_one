import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

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
        columns: 2
        enabled: !root.model.loading

        LabeledTextField {
            name: qsTr("Name")
            textOf: root.model.name
            onEdit: (txt) => { root.model.name = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 2
            Layout.fillWidth: true
        }

        ColumnLayout {
            spacing: 12
            Layout.fillWidth: true

            Label {
                text: qsTr("Jurisdictions")
                font.italic: true
            }

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
                model: QSortFilter {
                    id: jurisdictionFilter
                    sourceModel: jurisdictionListModel
                    Component.onCompleted: filter_by_variants(["regulator_id", root.model.id])
                }
                delegate: Label {
                    id: jurisdictionLabel
                    required property var model
                    horizontalAlignment: Text.AlignHCenter

                    Connections {
                        target: jurisdictionLabel.model
                        function onCountry_idChanged() {
                            iCountryCombo.currentIndex =
                            iCountryCombo.indexOfValue(jurisdictionLabel.model.country_id)
                        }
                    }

                    InvisibleCombo {
                        id: iCountryCombo
                        model: countryListModel
                        textRole: "name"
                        valueRole: "id"
                        Component.onCompleted:
                            currentIndex = indexOfValue(jurisdictionLabel.model.country_id)
                    }

                    text: iCountryCombo.currentText
                    font.bold: true
                }
            }
        }

        LabeledTextField {
            name: qsTr("Website")
            textOf: root.model.website
            onEdit: (txt) => { root.model.website = txt }
            placeHolder: qsTr("* Mandatory")
            Layout.columnSpan: 2
            Layout.fillWidth: true
        }

        RoundButton {
            icon.source: "qrc:/icons/floppy-disk.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Save")
            onClicked: regulatorListModel.save(root.model.index)
            highlighted: true
            enabled: root.model.flagged_for_update
            visible: !root.model.loading
        }

        BusyIndicator {
            visible: root.model.loading
            Layout.fillWidth: true
            Layout.columnSpan: 2
        }

        RoundButton {
            icon.source: "qrc:/icons/trash-alt.svg"
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Delete")
            Layout.alignment: Qt.AlignRight
            visible: !root.model.loading
            onClicked: onExceptionAction(ToolTip.text,
                                         qsTr("The selected regulator will be deleted"),
                                         () => { regulatorListModel.remove(root.model.index) }, true)
        }
    }

    background: Rectangle {
        implicitHeight: Material.delegateHeight - 4
        radius: 4
        color: Material.background
        opacity: .8
    }
}
