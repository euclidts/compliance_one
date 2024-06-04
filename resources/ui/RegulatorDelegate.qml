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
                                var txt = '{"'
                                + "regulator_id"
                                + '" : '
                                + root.model.id
                                + ' , "'
                                + "country_id"
                                + '" : '
                                + value
                                + '}'

                                jurisdictionListModel.addWith(JSON.parse(txt))
                                visible = false
                            }
                }
            }

            model: QSortFilter {
                id: jurisdictionFilter
                sourceModel: jurisdictionListModel
                Component.onCompleted: filter_by_variants(["regulator_id", root.model.id])
            }

            delegate: GroupBox {
                id: jurisdictionBox

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
                        horizontalAlignment: Text.AlignHCenter
                        text: iCountryCombo.currentText
                        font.bold: true
                    }

                    Button {
                        flat: true
                        icon.source: "qrc:/icons/trash-alt.svg"
                        onClicked: onExceptionAction(ToolTip.text,
                                                     qsTr("The selected jurisdiction will be deleted"),
                                                     () => {
                                                         var index = jurisdictionFilter.parent_row(
                                                             jurisdictionBox.model.index)

                                                         console.log(index)

                                                         jurisdictionListModel.remove(index)
                                                     },
                                                     true)
                    }
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
