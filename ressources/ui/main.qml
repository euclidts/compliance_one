import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material

import Qsovereignty

ApplicationWindow {
    id: window
    visible: true
    title: "Compliance One"
    width: 1024
    height: 768
    color: "#83919f"

    Material.theme: settingsDrawer.theme.checked ? Material.Light : Material.Dark
    Material.primary: "#bfe8ff"
    Material.accent: "#4183a8"

    font.pixelSize: 16

    readonly property bool portrait: width < 500

    function onLogin (success: bool, error: string) {
        if (success) {
            rootStack.currentIndex = 0
            logginDialog.clear()
            busyDialog.close()
        }
        else {
            onExceptionAction(qsTr("Authentication"),
                    error === "Host requires authentication" ?
                        qsTr("Incorect username or password")
                      : error,
                    function() { logginDialog.open() })
        }
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

    LoggInDialog { id: logginDialog }

//    UrlProvider { id: urlProvider }

    SettingsDrawer { id: settingsDrawer }

    BusyDialog { id: busyDialog }

//    Component.onCompleted: logginDialog.open()

    StackLayout {
        id: rootStack
        anchors.fill: parent
//        currentIndex: 3

//        onCurrentIndexChanged: topBar.searchBar.text = ""

//        StackLayout {
//            id: accountsPages

//        ColumnLayout {
//            Layout.fillHeight: true
//            Layout.fillWidth: true
//            spacing: 6

            ListView {
                spacing: 6
//                Layout.fillWidth: true
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                model : QsovereigntyListModel { list: sovereignty }
                delegate: QsovereigntyDelegate {}
            }

//            RoundButton {
//                Layout.fillWidth: true
//                icon.source: "qrc:/icons/plus.svg"
//                onClicked: sovereinty.appendItems(1)
//            }
//        }
//            ListView {
//                Layout.fillWidth: true
//                model: accountModel
//                delegate: AccountDelegate {}
//                onMovementStarted: topBar.searchBar.focus = false
//                clip: true
//                boundsBehavior: Flickable.StopAtBounds
//            }
//        }

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

//    header: TopBar { id: topBar }
//    footer: BottomBar { id: bottomBar }
    footer: RoundButton {
                Layout.fillWidth: true
                icon.source: "qrc:/icons/plus.svg"
                onClicked: sovereignty.appendItems(1)
            }
}
