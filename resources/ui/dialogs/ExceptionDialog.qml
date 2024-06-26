import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Dialog {
    modal: true
    closePolicy: Popup.NoAutoClose
    background.opacity: .8
    x: Math.round((parent.width - width) / 2)
    y: parent.height / 3
    implicitWidth: parent.width * 0.6

    property var func: function () {}
    property alias text: textLabel.text
    property bool cancelable: false

    function onClose() {
        func = function () {}
        cancelable = false
        exceptionDialog.close()
    }

    contentItem: ColumnLayout {
        spacing: 15

        Label {
            id: textLabel
            Layout.fillWidth: true
        }

        RowLayout {
            Layout.fillWidth: true

            Item { Layout.fillWidth: true }

            RoundButton {
                id: cancelButton
                text: qsTr("Cancel")
                visible: cancelable
                font.capitalization: Font.MixedCase
                font.bold: true
                highlighted: true
                onClicked: onClose()
            }

            RoundButton {
                id: validateButton
                text: qsTr("Ok")
                font.capitalization: Font.MixedCase
                font.bold: true
                highlighted: true
                onClicked: {
                    func()
                    onClose()
                }
            }
        }

        onVisibleChanged: if (visible) cancelable ? cancelButton.focus = true
                                                  : validateButton.focus = true
    }
}

