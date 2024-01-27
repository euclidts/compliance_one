import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material

import Interface
import QappUser
import Qcountry
import Qproduct_group
import Qproduct
import Qcontact
import Qaddress
import Qindividual

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

    readonly property bool portrait: width < 500
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
                            model : QcontactListModel {
                                id: contactListModel
                                list: contact_list
                            }
                            delegate: QcontactDelegate {}
                            interactive: false
                        }

                        GridLayout {
                            columns: 3
                            rowSpacing: 12
                            columnSpacing: 12
                            Layout.fillWidth: true

                            Button {
                                text: qsTr("Add Individual")
                                Layout.leftMargin: 12
                                Layout.fillWidth: true
                                icon.source: "qrc:/icons/user.svg"
                                Layout.alignment: Qt.AlignVCenter
                                onClicked: {
                                    current_contact.clear()
                                    rootStack.currentIndex = 1
                                }
                            }

                            Button {
                                text: qsTr("Add Counterparty")
                                icon.source: "qrc:/icons/industry.svg"
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignVCenter
                            }

                            Button {
                                text: qsTr("Add Vessel")
                                Layout.rightMargin: 12
                                Layout.fillWidth: true
                                icon.source: "qrc:/icons/ship.svg"
                                Layout.alignment: Qt.AlignVCenter
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
                    delegate: QcountryDelegate {}
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
                    delegate: QproductDelegate {}
                    footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: product_list.appendItem()
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
                    }
                }
        }

        QindividualPage { id: individualPage }
    }
}
