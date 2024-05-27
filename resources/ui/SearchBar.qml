import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQml

RowLayout {

    property alias name: search.placeholderText
    property var onTextChanged: function (text) {}
    property var onCleared: onTextChanged
    property bool busy: false

    TextField {
        id: search
        implicitHeight: 38
        Layout.margins: 6
        Layout.fillWidth: true
        placeholderText: qsTr("Search")
        rightPadding: Material.textFieldHorizontalPadding + 50
        onTextChanged: if (text === "")
                       {
                           timer.stop()
                           onCleared()
                       }
                       else timer.restart()

        Timer {
            id: timer
            onTriggered: onTextChanged(search.text)
        }

        Button {
            visible: !timer.running
            flat: true
            icon.source: search.text === ""
                         ? "qrc:/icons/search.svg"
                         : "qrc:/icons/times-circle.svg"
            onClicked: search.clear()
            x: parent.width - width
            y: parent.y - 13
        }

        BusyIndicator {
            visible: timer.running || busy
            height: parent.height
            x: parent.width - width
            y: parent.y - 6
        }
    }
}
