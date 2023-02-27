import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Rython.Components 1.0

ApplicationWindow {
    id: rootWindow
    width: 400
    height: 680
    minimumWidth: 360
    minimumHeight: 300
    visible: true
    title: qsTr("Hello World")
    Material.primary: Material.Pink
    FontLoader{
        id: appFont
        source: "qrc:/vazir.ttf"
    }
    Page{
        anchors{
            fill: parent
        }

        header: AppHeader{
            height: 50
        }


        Item{
            id: headerItem
            height: 50
            width: parent.width
            Rectangle{
                height: 1
                width: parent.width
                color: "#CFCFCF"
                anchors{
                    bottom: parent.bottom
                }
            }

            TabBar{
                height: parent.height
                anchors{
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 1
                }

                TabButton{
                    text: qsTr("اسپانسرها")
                    height: parent.height
                    width: 80
                    font{
                        family: appFont.name
                        pixelSize: 11
                    }
                }
                TabButton{
                    text: qsTr("غرفه‌ها")
                    height: parent.height
                    font{
                        family: appFont.name
                        pixelSize: 11
                    }
                }
            }

            Flow{
                height: parent.height
                anchors{
                    verticalCenter: parent.verticalCenter
                }

                Button{
                    text: qsTr("زمینه‌های فعالیت")
                    LayoutMirroring.enabled: true
                    height: parent.height
                    flat: true
                    icon{
                        source: "qrc:/layers.svg"
                        color: Material.primaryColor
                        width: 20
                        height: 20
                    }
                }
                Button{
                    implicitWidth:  parent.height
                    implicitHeight: parent.height
                    flat: true
                    icon{
                        source: "qrc:/order-alphabetical-ascending.svg"
                    }
                }
            }
        }


        API{ id: api }
        Component.onCompleted: {
            api.getList(18,"",dataListModel)
        }

        GridView{
            id: gridView
            clip: true
            cellHeight: 90
            cellWidth: width / (parseInt(width / parseInt(300))===0?1:(parseInt(width / 300)))
//            layoutDirection: Qt.RightToLeft
            anchors{
                top: headerItem.bottom
                topMargin: 10
                bottom: footerItem.top
                bottomMargin: 10
                left: parent.left
                right: parent.right
            }
            model: ListModel{
                id: dataListModel
            }

            delegate: Item{
                width: gridView.cellWidth
                height: gridView.cellHeight

                Rectangle{
                    radius: 10
                    anchors{
                        fill: parent
                        margins: 5
                    }
                    Text {
                        id: titleText
                        text: model.title
                        elide: Qt.ElideRight
                        font{
                            family: appFont.name
                            pixelSize: 13
                            bold: true
                        }
                        opacity: 0.9
                        anchors{
                            right: parent.right
                            rightMargin: 10
                            top: parent.top
                            topMargin: model.subtitle !== ""?10:15
                            left: buttonsFlow.right
                            leftMargin: 5
                        }
                    }
                    Text {
                        id: subTitleText
                        text: model.subtitle
                        visible:  model.subtitle !== ""
                        elide: Qt.ElideRight
                        font{
                            family: appFont.name
                            pixelSize: 10
                        }
                        anchors{
                            right: parent.right
                            rightMargin: 10
                            top: titleText.bottom
                            topMargin: 5
                            left: buttonsFlow.right
                            leftMargin: 5
                        }
                    }
                    Text {
                        id: categoryText
                        text: model.category
                        elide: Qt.ElideRight
                        font{
                            family: appFont.name
                            pixelSize: 10
                        }
                        anchors{
                            right: parent.right
                            rightMargin: 10
                            top: model.subtitle !== ""?subTitleText.bottom:titleText.bottom
                            topMargin: 5
                            left: buttonsFlow.right
                            leftMargin: 5
                        }
                    }
                    Flow{
                        id: buttonsFlow
                        spacing: -15
                        anchors{
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                        }
                        RoundButton{
                            flat: true
                            implicitWidth: 45
                            implicitHeight: 45
                            icon{
                                source: "qrc:/map-marker.svg"
                                color: "gray"
                            }
                        }
                        RoundButton{
                            flat: true
                            implicitWidth: 45
                            implicitHeight: 45
                            icon{
                                source: "qrc:/bookmark.svg"
                                color: model.isBookmarked?"Yellow":"gray"
                            }
                        }
                        RoundButton{
                            flat: true
                            implicitWidth: 45
                            implicitHeight: 45
                            icon{
                                source: "qrc:/share-variant.svg"
                                color: "gray"
                            }
                        }
                    }
                    Text {
                        id: locationText
                        text: model.location
                        elide: Qt.ElideRight
                        font{
                            family: appFont.name
                            pixelSize: 10
                        }
                        anchors{
                            top: buttonsFlow.bottom
                            horizontalCenter: buttonsFlow.horizontalCenter
                        }
                    }
                }

            }
        }

        Item{
            id: footerItem
            width: parent.width
            height: 70
            anchors{
                bottom: parent.bottom
            }
            Rectangle{
                height: 1
                width: parent.width
                color: "#CFCFCF"
                anchors{
                    top: parent.top
                }
            }
            RoundButton{
                id: locationBtn
                flat: true
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                }

                icon{
                    width: 30
                    height: 30
                    source: "qrc:/map-marker.svg"
                    color: Material.primaryColor
                }
            }

            Rectangle{
                height: parent.height - 20
                radius: 40
                color: "transparent"

                border{
                    width: 1
                    color: "#CFCFCF"
                }

                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                    left: locationBtn.right
                }

                RoundButton{
                    id: searchBtn
                    padding: 0
                    flat: true
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }
                    icon{
                        width: 30
                        height: 30
                        source: "qrc:/magnify.svg"
                        color: Material.primaryColor
                    }
                    onClicked: {
//                        if(searchInput.text.trim()!=="")
                            api.getList(18,searchInput.text.trim(),dataListModel)
                    }
                }

                TextField{
                    id: searchInput
                    height: parent.height
                    placeholderText: qsTr("جستجو کنید")
                    background: Rectangle{color: "transparent"}
                    rightPadding: 10
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    Keys.onReturnPressed: searchBtn.clicked()
                    Keys.onEnterPressed: searchBtn.clicked()
                    EnterKey.type: Qt.EnterKeyGo
                    font{
                        family: appFont.name
                        pixelSize: 13
                    }
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: searchBtn.right
                        right: parent.right
                        rightMargin: 5
                    }
                }
            }
        }

        Dialog{
            id: busyDialog
            width: 300
            height: 100
            closePolicy: Dialog.NoAutoClose
            anchors.centerIn: parent
            modal: true
            BusyIndicator{
                anchors.centerIn: parent
            }
        }
    }
}
