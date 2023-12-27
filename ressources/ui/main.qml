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
import Qindividual

ApplicationWindow {
    id: window
    visible: true
    title: "Compliance One"
    width: 1024
    height: 768
    color: settingsDrawer.theme.checked ? "#83919f" : '#121212'

    Material.theme: settingsDrawer.theme.checked ? Material.Light : Material.Dark
    Material.primary: "#bfe8ff"
    Material.accent: "#4183a8"

    font.pixelSize: 16

    readonly property bool portrait: width < 500
    readonly property var rateModel: [qsTr("Low"), qsTr("Medium"), qsTr("High")]

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
            // individual_list.get()
            bottomBar.currentIndex = 0
            logginDialog.clear()
            busyDialog.close()
        }
        else { logginDialog.open() }
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

    ExceptionDialog { id: exceptionDialog }

//    UrlProvider { id: urlProvider }

    SettingsDrawer { id: settingsDrawer }

    BusyDialog { id: busyDialog }

    LoggInDialog { id: logginDialog }
    Component.onCompleted: logginDialog.open()

    StackLayout {
        id: rootStack
        currentIndex: count
        anchors.fill: parent

//        onCurrentIndexChanged: topBar.searchBar.text = ""

//        StackLayout {
//            id: accountsPages

        GridLayout {
            columns: 3
            columnSpacing: 12
            rowSpacing: 12
            Layout.maximumHeight: parent.height / 2

            Button {
                Layout.topMargin: parent.implicitHeight / 2
                Layout.leftMargin: 12
                icon.source: "qrc:/icons/users.svg"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                icon.height: (implicitBackgroundHeight + topInset + bottomInset) * 2
                icon.width: (implicitBackgroundWidth + leftInset + rightInset) * 2
                onClicked: rootStack.currentIndex = 3
            }

            Button {
                Layout.topMargin: parent.implicitHeight / 2
                icon.source: "qrc:/icons/industry.svg"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                icon.height: (implicitBackgroundHeight + topInset + bottomInset) * 2
                icon.width: (implicitBackgroundWidth + leftInset + rightInset) * 2
            }

            Button {
                Layout.topMargin: parent.implicitHeight / 2
                Layout.rightMargin: 12
                icon.source: "qrc:/icons/ship.svg"
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                icon.height: (implicitBackgroundHeight + topInset + bottomInset) * 2
                icon.width: (implicitBackgroundWidth + leftInset + rightInset) * 2
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

        QindividualPage { id: individualPage }

//        StackLayout {
//            id: usersPages

//            ListView {
//                Layout.fillWidth: true
//                model: userModel
//                delegate: UserDelegate {}
//                onMovementStarted: topBar.searchBar.focus = false
//                clip: true
//                boundsBehavior: Flickable.StopAtBounds
//            }

//            Connections {
//                target: selectedUser
//                function onFilterRoleChanged() {
//                    usersPages.currentIndex = 1
//                }
//            }

//            UserPage { id: userPage }
//        }

//        CalculatorPage { id: calculatorPage }
    }

    header: RowLayout {
        height: 48
        visible: rootStack.currentIndex !== rootStack.count

        Button {
            id: backButton
            visible: !bottomBar.visible
            icon.source: "qrc:/icons/arrow-left.svg"
            flat: true
            onClicked: rootStack.currentIndex = 0
        }

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

//    header: TopBar { id: topBar }
//    footer: BottomBar { id: bottomBar }
    footer: RowLayout {
        id: footer
        height: 48
        property var setVis: () => {
                                 footer.visibleChildren.length === 0
                                 ? footer.visible = false
                                 : footer.visible = true
                             }

        TabBar {
            id: bottomBar
            visible: rootStack.currentIndex < count && user && user.clearance === 3
            Layout.fillWidth: true
            onCurrentIndexChanged: rootStack.currentIndex = currentIndex
            currentIndex: rootStack.count
            // onVisibleChanged: footer.setVis()

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
