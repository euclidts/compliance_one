import QtQuick.Window
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import Interface
import QappUser
import Qcountry
import Qcontact
import Qaddress
import Qindividual
import Qproduct_group
import Qproduct
import Qctp_group
import Qctp_type
import Qexchange
import Qcompany
import Qvessel

ApplicationWindow {
    id: window
    visible: true
    title: "Compliance One"
    width: 1024
    height: 768
    color: settingsDrawer.theme.checked ? "#83919f" : '#121212'
    font.pixelSize: 16

    Material.theme: settingsDrawer.theme.checked ? Material.Light : Material.Dark
    Material.primary: "#bfe8ff"
    Material.accent: "#4183a8"

    readonly property bool portrait: width < height
    readonly property var rateModel: [qsTr("Low"), qsTr("Medium"), qsTr("High")]
    property bool loading: false
    property var onLoaded: function () {}

    property var countryListModel: QcountryListModel{}
    property var product_groupListModel: Qproduct_groupListModel{}
    property var productListModel: QproductListModel{}
    property var ctp_groupListModel: Qctp_groupListModel{}
    property var ctp_typeListModel: Qctp_typeListModel{}
    property var exchangeListModel: QexchangeListModel{}
    property var contactListModel: QcontactListModel{}
    property var addressListModel: QaddressListModel{}
    property var individualListModel: QindividualListModel{}
    property var companyListModel: QcompanyListModel{}
    property var vesselListModel: QvesselListModel{}

    LogInDialog { id: loginDialog }
    Component.onCompleted: loginDialog.open()
    BusyDialog { id: busyDialog }
    ExceptionDialog { id: exceptionDialog }

    onLoadingChanged: if (loading) { busyDialog.open() }
                      else {
                          // set asside for imediate use and cleanup
                          var next = onLoaded
                          onLoaded = function () {}
                          busyDialog.close()
                          next()
                      }

    DateDialog { id: dateDialog }

    function onLogin (success: bool, error: string) {
        if (success) {
            contactListModel.get()
            addressListModel.get()
            individualListModel.get()
            companyListModel.get()
            vesselListModel.get()
            rootStack.currentIndex = 0
            loginDialog.clear()
            busyDialog.close()
        }
        else exceptionDialog.func = () => { loginDialog.open() }
    }

    function onException (prefix: string, error: string) {
        busyDialog.close()
        exceptionDialog.title = prefix
        exceptionDialog.text = error
        exceptionDialog.open()
    }

    function onExceptionAction (prefix: string, error: string, func, cancelable: bool) {
        if (typeof(func) !== 'undefined')
            exceptionDialog.func = func
        if (typeof(cancelable) !== 'undefined')
            exceptionDialog.cancelable = cancelable
        onException(prefix, error)
    }

    SettingsDrawer { id: settingsDrawer }

    StackLayout {
        id: rootStack
        currentIndex: count
        anchors.fill: parent

        Page {
            background: Rectangle { color: "transparent" }

            header: RowLayout {

                TextField {
                    id: search
                    implicitHeight: 38
                    Layout.margins: 6
                    Layout.fillWidth: true
                    placeholderText: qsTr("Search")
                    rightPadding: Material.textFieldHorizontalPadding + 50

                    Button {
                        id: magnifyingGlass
                        flat: true
                        icon.source: search.text === ""
                                     ? "qrc:/icons/search.svg"
                                     : "qrc:/icons/times-circle.svg"
                        onClicked: search.clear()
                        x: parent.width - width
                        y: parent.y - 12
                    }
                }
            }

            contentItem: StackLayout {
                id: homeStack
                currentIndex: homeBar.currentIndex

                FlickableItem {
                    Layout.fillWidth: true

                    ColumnLayout {
                        spacing: 12
                        width: parent.width

                        ListView {
                            Layout.fillWidth: true
                            implicitHeight: contentHeight
                            model: individualListModel
                            delegate: IndividualDelegate {}
                            interactive: false
                        }

                        ListView {
                            Layout.fillWidth: true
                            implicitHeight: contentHeight
                            model: companyListModel
                            delegate: CompanyDelegate {}
                            interactive: false
                        }

                        ListView {
                            Layout.fillWidth: true
                            implicitHeight: contentHeight
                            model: vesselListModel
                            delegate: VesselDelegate {}
                            interactive: false
                        }

                        GridLayout {
                            columns: portrait ? 1 : 3
                            rowSpacing: 12
                            Layout.fillWidth: true

                            Button {
                                text: qsTr("Add Individual")
                                Layout.leftMargin: 12
                                Layout.rightMargin: 12
                                Layout.fillWidth: true
                                icon.source: "qrc:/icons/user.svg"
                                Layout.alignment: Qt.AlignVCenter
                                onClicked: {
                                    individualPage.current_contact.clear()
                                    individualPage.current_address.clear()
                                    individualPage.current_individual.clear()
                                    rootStack.currentIndex = 1
                                }
                            }

                            Button {
                                text: qsTr("Add Company")
                                icon.source: "qrc:/icons/industry.svg"
                                Layout.leftMargin: 12
                                Layout.rightMargin: 12
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                                onClicked: {
                                    companyPage.current_contact.clear()
                                    companyPage.current_address.clear()
                                    companyPage.current_company.clear()
                                    rootStack.currentIndex = 2
                                }
                            }

                            Button {
                                text: qsTr("Add Vessel")
                                Layout.leftMargin: 12
                                Layout.rightMargin: 12
                                Layout.fillWidth: true
                                icon.source: "qrc:/icons/ship.svg"
                                Layout.alignment: Qt.AlignVCenter
                                onClicked: {
                                    vesselPage.current_vessel.clear()
                                    rootStack.currentIndex = 3
                                }
                            }
                        }
                    }
                }

                ListView {
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : countryListModel
                    delegate: CountryDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: countryListModel.appendItem()
                        highlighted: true
                    }
                }

                ListView {
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : productListModel
                    delegate: ProductDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: productListModel.appendItem()
                        highlighted: true
                    }
                }

                ListView {
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : ctp_typeListModel
                    delegate: CtpTypeDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: ctp_typeListModel.appendItem()
                        highlighted: true
                    }
                }

                ListView {
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : exchangeListModel
                    delegate: ExchangeDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: exchangeListModel.appendItem()
                        highlighted: true
                    }
                }
            }

            footer: RowLayout {
                id: footer
                height: 48

                TabBar {
                    id: homeBar
                    Layout.fillWidth: true

                    TabButton {
                        text: "Home"
                    }
                    TabButton {
                        text: "Countries"
                    }
                    TabButton {
                        text: "Products"
                    }
                    TabButton {
                        text: "Counterparty types"
                    }
                    TabButton {
                        text: "Exchange codes"
                    }
                }
            }
        }

        IndividualPage { id: individualPage }
        CompanyPage { id: companyPage }
        VesselPage { id: vesselPage }
    }
}
