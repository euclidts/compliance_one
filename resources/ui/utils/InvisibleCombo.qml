import QtQuick
import QtQuick.Templates as T

T.ComboBox {
    // minimum requirement to leavrage combobox functionalities
    // ie. indexOfValue, currentValue & currentText
    delegate: Item { visible: false }
}
