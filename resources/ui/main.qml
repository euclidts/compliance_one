import QtQuick.Window
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material

import "dialogs" as Dialogs
import "utils" as Utils
import "pages" as Pages

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
    property list<var> queue: []

    property var regionListModel: QregionListModel{}
    property var countryListModel: QcountryListModel{}
    property var product_groupListModel: Qproduct_groupListModel{}
    property var productListModel: QproductListModel{}
    property var company_groupListModel: Qcompany_groupListModel{}
    property var company_typeListModel: Qcompany_typeListModel{}
    property var exchangeListModel: QexchangeListModel{}
    property var regulatorListModel: QregulatorListModel{}
    property var jurisdictionListModel: QjurisdictionListModel{}

    Dialogs.BusyPopup { id: busyPopup }
    Dialogs.ExceptionDialog { id: exceptionDialog }
    Dialogs.LogInDialog { id: loginDialog }
    Component.onCompleted: loginDialog.open()

    Connections {
        target: bridge
        function onLoadingChanged() {
            if (bridge.loading)
                busyPopup.open()
            else
                busyPopup.close()
        }
    }

    Dialogs.DateDialog { id: dateDialog }

    Utils.SettingsDrawer { id: settingsDrawer }

    StackLayout {
        id: rootStack
        currentIndex: 0
        anchors.fill: parent

        Page { background: Rectangle { color: "transparent" } }
        Pages.HomeStack {}
        Pages.IndividualPage { id: individualPage }
        Pages.CompanyPage { id: companyPage }
        Pages.VesselPage { id: vesselPage }
    }

    function onLogin () {
        exceptionDialog.func = () => {}
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
    }

    function onException (prefix: string, error: string) {
        exceptionDialog.title = prefix
        exceptionDialog.text = error
        queue.length = 0
        exceptionDialog.open()
    }

    function onExceptionAction (prefix: string, error: string, func, cancelable: bool) {
        if (typeof(func) !== 'undefined')
            exceptionDialog.func = func
        if (typeof(cancelable) !== 'undefined')
            exceptionDialog.cancelable = cancelable
        onException(prefix, error)
    }

    function enqueue (funcs) {
        if (queue.length === 0)
            queue = funcs
        else
            queue = queue.concat(funcs)
    }

    function dequeue () {
        if (queue.length > 0) queue.shift()()
    }
}
