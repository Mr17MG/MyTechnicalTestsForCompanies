import QtQuick 2.15
import QtQuick.Controls 2.15

RoundButton{
    id: root
    property alias iconSource: root.icon.source
    property int itemCount: 0
    implicitWidth: 40
    implicitHeight: 40
    flat: true
    font{
        family: appFont.name
    }
    Rectangle{
        visible: itemCount > 0
        anchors{
            bottom: parent.bottom
            right: parent.right
        }
        width: 20
        height: width
        radius: 20
        z:1
        color: Material.primary
        Label {
            text: itemCount
            anchors.centerIn: parent
            color: "white"
        }
    }
}
