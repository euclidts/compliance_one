import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../delegates" as Delegates

import Quser

Page {
    background: Rectangle { color: "transparent" }

    contentItem: StackLayout {
        currentIndex: homeBar.currentIndex
        onCurrentIndexChanged: if (currentIndex !== homeBar.currentIndex)
                                   homeBar.currentIndex = currentIndex

        HomePage {}

        ListSearchPage {
            sourceModel: countryListModel
            delegate: Delegates.CountryDelegate {}
        }
        ListSearchPage {
            sourceModel: regulatorListModel
            delegate: Delegates.RegulatorDelegate {}
        }
        ListSearchPage {
            sourceModel: exchangeListModel
            delegate: Delegates.ExchangeDelegate {}
        }
        ListSearchPage {
            sourceModel: productListModel
            delegate: Delegates.ProductDelegate {}
        }
        ListSearchPage {
            sourceModel: company_typeListModel
            delegate: Delegates.CompanyTypeDelegate {}
        }
    }

    footer: RowLayout {
        visible: appUser && appUser.clearance === 3
        height: 48

        TabBar {
            id: homeBar
            Layout.fillWidth: true
            currentIndex: 0

            TabButton {
                text: "Home"
            }
            TabButton {
                text: "Countries"
            }
            TabButton {
                text: "Regulators"
            }
            TabButton {
                text: "Exchange codes"
            }
            TabButton {
                text: "Products"
            }
            TabButton {
                text: "Company types"
            }
        }
    }
}
