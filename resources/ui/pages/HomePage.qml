import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../utils" as Utils
import "../delegates" as Delegates

import Qindividual_view
import Qcompany_view
import Qvessel

Page {
    background: Rectangle { color: "transparent" }

    property var individual_viewListModel: Qindividual_viewListModel{}
    property var company_viewListModel: Qcompany_viewListModel{}
    property var vesselListModel: QvesselListModel{}

    header: Utils.SearchBar {
        width: parent.width
        busy: individual_viewListModel.loading ||
              company_viewListModel.loading ||
              vesselListModel.loading
        onTextChanged: (text) => {
                           individual_viewListModel.search(text)
                           company_viewListModel.search(text)
                           vesselListModel.search(text)
                       }
        onCleared: () => {
                       individual_viewListModel.clear()
                       company_viewListModel.clear()
                       vesselListModel.clear()
                   }
    }

    contentItem: ScrollView {
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        Utils.FlickableItem {
            ColumnLayout {
                spacing: 12
                width: parent.width

                ListView {
                    Layout.fillWidth: true
                    implicitHeight: contentHeight
                    model: individual_viewListModel
                    delegate: Delegates.IndividualDelegate {}
                    interactive: false
                    reuseItems: true

                    header: Button {
                        text: qsTr("Add Individual")
                        width: parent.width
                        icon.source: "qrc:/icons/user.svg"
                        onClicked: {
                            individualPage.current_contact.clear()
                            individualPage.current_address.clear()
                            individualPage.current_individual.clear()
                            rootStack.currentIndex = 2
                        }
                    }
                }

                ListView {
                    Layout.fillWidth: true
                    implicitHeight: contentHeight
                    model: company_viewListModel
                    delegate: Delegates.CompanyDelegate {}
                    interactive: false
                    reuseItems: true

                    header: Button {
                        text: qsTr("Add Company")
                        icon.source: "qrc:/icons/industry.svg"
                        width: parent.width
                        onClicked: {
                            companyPage.current_contact.clear()
                            companyPage.current_address.clear()
                            companyPage.current_company.clear()
                            rootStack.currentIndex = 3
                        }
                    }
                }

                ListView {
                    Layout.fillWidth: true
                    implicitHeight: contentHeight
                    model: vesselListModel
                    delegate: Delegates.VesselDelegate {}
                    interactive: false
                    reuseItems: true

                    header: Button {
                        text: qsTr("Add Vessel")
                        width: parent.width
                        icon.source: "qrc:/icons/ship.svg"
                        onClicked: {
                            vesselPage.current_vessel.clear()
                            rootStack.currentIndex = 4
                        }
                    }
                }
            }
        }
    }
}
