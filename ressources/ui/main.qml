import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
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

    function formatDateTimeMs(date) {
        let str = date.toISOString()
        str = str.replace('T', ' ')
        return str.slice(0, -1)
    }

    function formatDateTime(date) {
        return formatDateTimeMs(date).slice(0, -4)
    }

    function formatDate(date) {
        return formatDateTime(date).slice(0, -9)
    }

    function onLogin (success: bool, error: string) {
        if (success) {
            contact_list.get()
            address_list.get()
            individual_list.get()
            company_list.get()
            vessel_list.get()
            rootStack.currentIndex = 0
            loginDialog.clear()
            busyDialog.close()
        }
        else { loginDialog.open() }
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
                            model : QindividualListModel {
                                id: individualListModel
                                list: individual_list
                            }
                            delegate: IndividualDelegate {}
                            interactive: false
                        }

                        ListView {
                            Layout.fillWidth: true
                            implicitHeight: contentHeight
                            model : QcompanyListModel {
                                id: companyListModel
                                list: company_list
                            }
                            delegate: CompanyDelegate {}
                            interactive: false
                        }

                        ListView {
                            Layout.fillWidth: true
                            implicitHeight: contentHeight
                            model : QvesselListModel {
                                id: vesselListModel
                                list: vessel_list
                            }
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
                                    current_contact.clear()
                                    current_address.clear()
                                    current_individual.clear()
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
                                    current_contact.clear()
                                    current_address.clear()
                                    current_company.clear()
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
                                    current_vessel.clear()
                                    rootStack.currentIndex = 3
                                }
                            }
                        }
                    }
                }

                ListView {
                    id: countryListView
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : QcountryListModel { list: country_list }
                    delegate: CountryDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: country_list.appendItem()
                        highlighted: true
                    }
                }

                ListView {
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : QproductListModel { list: product_list }
                    delegate: ProductDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: product_list.appendItem()
                        highlighted: true
                    }
                }

                ListView {
                    spacing: 6
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    model : Qctp_typeListModel { list: ctp_type_list }
                    delegate: CtpTypeDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: ctp_type_list.appendItem()
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
                    }
                }
        }

        IndividualPage { id: individualPage }
        CompanyPage { id: companyPage }
        VesselPage { id: vesselPage }

        Connections {
            target: current_contact
            function onLoadingChanged() {
                current_contact.loading ? loading = true : loading = false
            }
        }

        Connections {
            target: current_address
            function onLoadingChanged() {
                current_address.loading ? loading = true : loading = false
            }
        }

        Connections {
            target: current_individual
            function onLoadingChanged() {
                current_individual.loading ? loading = true : loading = false
            }
        }

        Connections {
            target: current_company
            function onLoadingChanged() {
                current_company.loading ? loading = true : loading = false
            }
        }
    }
}
