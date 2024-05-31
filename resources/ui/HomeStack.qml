import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Page {
    background: Rectangle { color: "transparent" }

    contentItem: StackLayout {
        currentIndex: homeBar.currentIndex

        HomePage {}

        ListSearchPage {
            sourceModel: countryListModel
            delegate: CountryDelegate {}
        }
        ListSearchPage {
            sourceModel: productListModel
            delegate: ProductDelegate {}
        }
        ListSearchPage {
            sourceModel: company_typeListModel
            delegate: CompanyTypeDelegate {}
        }
        ListSearchPage {
            sourceModel: exchangeListModel
            delegate: ExchangeDelegate {}
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
