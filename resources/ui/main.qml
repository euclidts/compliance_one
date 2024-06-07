import QtQuick.Window
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material

import Interface
import Qregion
import Qcountry
import Qproduct_group
import Qproduct
import Qcompany_group
import Qcompany_type
import Qexchange
import Qregulator
import Qjurisdiction

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
    readonly property list<string> rateModel: [qsTr("Low"), qsTr("Medium"), qsTr("High")]
    property bool loading: false
    property var onLoaded: function () {}

    property var regionListModel: QregionListModel{}
    property var countryListModel: QcountryListModel{}
    property var product_groupListModel: Qproduct_groupListModel{}
    property var productListModel: QproductListModel{}
    property var company_groupListModel: Qcompany_groupListModel{}
    property var company_typeListModel: Qcompany_typeListModel{}
    property var exchangeListModel: QexchangeListModel{}
    property var regulatorListModel: QregulatorListModel{}
    property var jurisdictionListModel: QjurisdictionListModel{}

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
        currentIndex: 0
        anchors.fill: parent

        Page { background: Rectangle { color: "transparent" } }
        HomeStack {}
        IndividualPage { id: individualPage }
        CompanyPage { id: companyPage }
        VesselPage { id: vesselPage }
    }

    function onLogin (success: bool, error: string) {
        if (success) {
            regionListModel.get()
            countryListModel.get()
            product_groupListModel.get()
            productListModel.get()
            company_groupListModel.get()
            company_typeListModel.get()
            exchangeListModel.get()
            regulatorListModel.get()
            jurisdictionListModel.get()
            rootStack.currentIndex = 1
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
