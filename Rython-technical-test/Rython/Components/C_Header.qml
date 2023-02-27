import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import Rython.Components 1.0

RowLayout{
    layoutDirection: Qt.RightToLeft

    C_HeaderButton{
        iconSource: "qrc:/arrow-right.svg"
    }

    Label {
        id: pageTitle
        text: qsTr("غرفه‌ها ۲۰۱۹")
        Layout.fillWidth: true
        elide: Qt.ElideLeft
        color: Material.primary
        font{
            family: appFont.name
        }
    }
    C_HeaderButton{
        iconSource: "qrc:/star-box.svg"
        itemCount: 3
    }

    C_HeaderButton{
        iconSource: "qrc:/bookmark.svg"
    }

    C_HeaderButton{
        iconSource: "qrc:/grid-box.svg"
        itemCount: 2
    }

}

