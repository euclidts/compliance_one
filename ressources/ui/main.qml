import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material

import Interface
import QappUser
import Qsovereignty
import Qcountry
import Qproduct_group
import Qproduct

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

    function onLogin (success: bool, error: string) {
        if (success) {
            bottomBar.currentIndex = 0
            logginDialog.clear()
            busyDialog.close()
            console.log(user && user.id)
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
        currentIndex: 4
        anchors.fill: parent
//        currentIndex: bottomBar.currentIndex

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
            id: sovereigntyListView
            spacing: 6
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model : QsovereigntyListModel { list: sovereigntyList }
            delegate: QsovereigntyDelegate {}
            footer: RoundButton {
                        Layout.fillWidth: true
                        icon.source: "qrc:/icons/plus.svg"
                        onClicked: sovereigntyList.appendItem()
                        highlighted: true
                    }
        }

        ListView {
            spacing: 6
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model : QcountryListModel { list: countryList }
            delegate: QcountryDelegate {}
            footer: RoundButton {
                Layout.fillWidth: true
                icon.source: "qrc:/icons/plus.svg"
                onClicked: countryList.appendItem()
                highlighted: true
            }
        }

        ListView {
            spacing: 6
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model : QproductListModel { list: productList }
            delegate: QproductDelegate {}
            footer: RoundButton {
                Layout.fillWidth: true
                icon.source: "qrc:/icons/plus.svg"
                onClicked: productList.appendItem()
                highlighted: true
            }
        }

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
        visible: bottomBar.currentIndex !== 4

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
        height: 48

        TabBar {
            id: bottomBar
            visible: bottomBar.currentIndex !== 4 && user && user.user_type === 3
            Layout.fillWidth: true
            currentIndex: 4
            onCurrentIndexChanged: rootStack.currentIndex = currentIndex

            Component.onCompleted: console.log(user.username)

            TabButton {
                text: "Home"
            }
            TabButton {
                text: "Sovereignties"
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
