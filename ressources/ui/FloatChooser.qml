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
        stepSize: decimalFactor
        value: numberOf
        locale: Qt.locale()

        property int decimals: 2
        property real realValue: value / step
        readonly property int decimalFactor: Math.pow(10, decimals)

        function decimalToInt(decimal) {
            return decimal * decimalFactor
        }

        validator: DoubleValidator {
            bottom: Math.min(spinBox.from, spinBox.to)
            top:  Math.max(spinBox.from, spinBox.to)
            decimals: spinBox.decimals
            notation: DoubleValidator.StandardNotation
        }

        textFromValue: function(value, locale) {
            return Number(value / decimalFactor).toLocaleString(locale, 'f', spinBox.decimals)
        }

        valueFromText: function(text, locale) {
            return Math.round(Number.fromLocaleString(locale, text) * decimalFactor)
        }
    }
}
