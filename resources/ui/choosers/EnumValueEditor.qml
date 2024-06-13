import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    Layout.topMargin: 2
    spacing: 6

    property alias highlightedIndex: combo.highlightedIndex
    property alias hoverEnabled: combo.hoverEnabled
    property alias model: combo.model
    property alias textRole: combo.textRole
    property alias valueRole: combo.valueRole
    property alias name: label.text
    required property var enumOf
    required property var onEdit

    onEnumOfChanged: combo.currentIndex = combo.indexOfValue(enumOf)

    Label {
        id: label
        font.italic: true
    }

    ComboBox {
        id: combo
        Layout.topMargin: 2
        editable: true
        Layout.minimumWidth: 160
        Layout.fillWidth: true
        rightPadding: Material.textFieldHorizontalPadding + 50
        onActivated: onEdit(currentValue)
        onAccepted: onEdit(currentValue)
        indicator.visible: editText === "" || find(editText) !== -1
        Component.onCompleted: currentIndex = indexOfValue(enumOf)

        delegate: MenuItem {
            required property var model
            required property int index

            width: ListView.view.width
            text: model[combo.textRole]
            Material.foreground: combo.currentIndex === index ? ListView.view.contentItem.Material.accent : ListView.view.contentItem.Material.foreground
            highlighted: combo.highlightedIndex === index
            hoverEnabled: combo.hoverEnabled

            Button {
                flat: true
                visible: combo.currentValue !== model[valueRole]
                icon.source: "qrc:/icons/times-circle.svg"
                x: parent.width - width - padding
                y: parent.topPadding + (parent.availableHeight - height) / 2
                onClicked: onExceptionAction(ToolTip.text,
                                             qsTr("The selected item will be deleted"),
                                             () => { combo.model.remove(index) }, true)
            }
        }

        property string insertText

        Button {
            id: addButton
            flat: true
            visible: !combo.indicator.visible
            icon.source: "qrc:/icons/plus.svg"
            x: parent.width - width - padding
            y: parent.topPadding + (parent.availableHeight - height) / 2
            onClicked: {
                enqueue([() => {
                             combo.insertText = combo.editText
                             model.add_with_queued(JSON.parse('{"'
                                                              + textRole
                                                              + '" : "'
                                                              + combo.editText
                                                              + '"}'))
                         },
                         () => {
                             combo.currentIndex = combo.find(combo.insertText)
                             onEdit(combo.currentValue)
                         }])
                dequeue()
            }
        }
    }
}
