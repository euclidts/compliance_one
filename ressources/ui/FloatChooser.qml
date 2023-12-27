import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

ColumnLayout {
    spacing: 12

    required property int numberOf
    required property string name
    property var onEdit
    property int minimum: 0
    property int maximum
    property int step: 1
    property int decimals: 2
    property alias spin: spin
    property alias editable: spin.editable

    Label {
        text: name
        font.italic: true
        Layout.topMargin: -2
    }

    SpinBox {
        id: spin
        from: decimalToInt(minimum)
        to: decimalToInt(maximum)
        stepSize: decimalFactor * step
        value: decimalToInt(numberOf)
        locale: Qt.locale()

        readonly property int decimalFactor: Math.pow(10, decimals)

        function decimalToInt(decimal) {
            return decimal * decimalFactor
        }

        validator: DoubleValidator {
            bottom: Math.min(spin.from, spin.to)
            top:  Math.max(spin.from, spin.to)
            decimals: decimals
            notation: DoubleValidator.StandardNotation
        }

        textFromValue: function(value, locale) {
            return Number(value / decimalFactor).toLocaleString(spin.locale, 'f', decimals)
        }

        valueFromText: function(text, locale) {
            return Math.round(Number.fromLocaleString(spin.locale, text) * decimalFactor)
        }
    }
}
