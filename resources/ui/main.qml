import QtQuick.Window
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material

import Interface
import QappUser
import Qcountry
import Qproduct_group
import Qproduct
import Qctp_group
import Qctp_type
import Qexchange

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

    SettingsDrawer { id: settingsDrawer }

    StackLayout {
        id: rootStack
        currentIndex: count
        anchors.fill: parent

        HomeStack {}
        IndividualPage { id: individualPage }
        CompanyPage { id: companyPage }
        VesselPage { id: vesselPage }
    }

    function onLogin (success: bool, error: string) {
        if (success) {
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
}
