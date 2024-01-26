import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Dialog {
    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape
    background.opacity: .8
    x: Math.round((parent.width - width) / 2)
    y: 120

    property date currentDate
    property int minYear: 1900
    property int maxYear: 2100
    property var func: function () {}

    onCurrentDateChanged: {
        if (years.value !== currentDate.getFullYear())
            years.value = currentDate.getFullYear()

        if (months.value !== currentDate.getMonth())
            months.value !== currentDate.getMonth()

        func(currentDate)
    }

    ColumnLayout {
        RowLayout {
            Layout.fillWidth: true

            SpinBox {
                id: years
                Layout.fillWidth: true
                from: minYear
                to: maxYear
                textFromValue: function(value) {
                    return Number(value).toString()
                }
                valueFromText: function(text) {
                    return Number.parseInt(text)
                }

                contentItem: TextInput {
                    text: years.textFromValue(years.value)
                    onTextChanged: years.value = years.valueFromText(text)

                    font: window.font
                    color: Material.foreground
                    selectionColor: Material.textSelectionColor
                    selectedTextColor: Material.foreground
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    cursorDelegate: CursorDelegate { }
                    clip: width < implicitWidth
                    inputMethodHints: Qt.ImhDigitsOnly
                    readOnly: false

                    validator: IntValidator {
                        bottom: Math.min(years.from, years.to)
                        top: Math.max(years.from, years.to)
                    }
                }
            }

            SpinBox {
                id: months
                Layout.fillWidth: true
                from: 1
                to: 12
            }
        }

        MonthGrid {
            id: grid
            month: Math.max(0, months.value - 1)
            year: years.value
            Layout.fillWidth: true
            Layout.fillHeight: true
            delegate: Text {
                 horizontalAlignment: Text.AlignHCenter
                 verticalAlignment: Text.AlignVCenter
                 opacity: model.month === grid.month ? 1 : 0.3
                 text: model.day
                 font: window.font
                 color: Material.foreground

                 required property var model

                 // adapted from
                 // https://stephenquan.github.io/qmlonline/?zcode=AAAH/nicrVXfa9swEH7PXyEMg4StWpKxF0MYXcrWwULXJmsfh2pfbFFZ58lyUnfkf99JTtL8sldYvwfjO313/nR3kmWWo7Hs2l6XMnroyD2Tj1Fbg6o49H8XFZa26PwQCbA/HUaQcchyMr2RG8zB2IrFWN4rYFFpDGg7kxmErO8pX42MbyUs1+EOQkcpmoLPpVIumQvZLmYYA3mH/X5/64tAqTsZ27T+NF+6973VS5BJatfLqTe263OFy3Crg38hc4b5DD+jtZhtaYUW+YQ+vkOdkutKww0utywSB4mwxPpmIdvZlMOyUaND2qLRYYyqzHRd8oPEDjN4POV2sLQUUtP4HE0m7AXpcy3oJrQRXoEw7C0LzgJ61q6M2p2SNehxi1NrpE66PZ6LeGqFsd3hOxb0g54P6g8CsiYEVhGC3pGA1ZHnQlRX8zuABypcg+J6l34C1o21poSTVIWRUFRvr7w2XqBh4rboGtkgwI2xy/i/6nwpQyZ1DI/sDRsMT7JcD9xMDwdU1ImwKaehRNOtw95T2HFdd/dOra1fuwHoXz+nJ9rg8DycLcPiQMdPPpFyoc6VTHRGB7CO4d6+HJMDTGP4gs68jBqCb/8RjLmIpK3C+qSvZ3E0GrGd0fzEBowuEH66mg71yNcpYlE18ubo1PnU7rWRZ+B3KQ3Ez1fago6Nz98YcwORFTpR0FJph9b7ri0gEyaRugjZ2cdW/hMxmkvltydiWVKi9jz3aGIwPEKFNK4BlSN4CX997X1o5W6SWiN0UdegPflCFvLeDf/OT8XPyabpFngC3t09fRwcjm+GDSZYFnBuQLx291CPFf08IT6Q/hrCj737npV7dPbXVp3VX5dA7oA=
                 Rectangle {
                     anchors.fill: parent
                     anchors.margins: -5
                     z: -2
                     radius: 4
                     border.color: Material.accent
                     border.width: 3
                     color: "transparent"
                     visible: currentDate.getDate() === model.date.getDate() &&
                              model.month === grid.month
                 }

                 MouseArea {
                     anchors.fill: parent
                     onClicked: currentDate.setTime(model.date.getTime())
                 }
             }
        }
    }

    // onClosed {
    // func = function () {}
    //     minYear = 1900
    //     maxYear = 2100
    // }
}

