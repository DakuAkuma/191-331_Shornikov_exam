import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

ApplicationWindow { // Само приложение.
    id:window
    width: 640
    height: 480
    visible: true
    title: qsTr("Заметки")

    Drawer { // Боковая информационная страничка.
        id: drawer
        width: 0.66 * window.width
        height: window.height

        Label { // Заголовок Drawer'a.
            id: header_d
            text: "Заметки"
            font.pixelSize: Qt.application.font.pixelSize*3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 15
        }

        Label {
            anchors.top: header_d.bottom
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            Text { // Информация о приложении.
                width: parent.width
                id: information
                text: "Экзаменационное задание по дисциплине \"Разработка безопасных мобильных приложений\",\nМосковский политех,\n30 июня 2021 г."
                clip: true
                wrapMode: Text.WordWrap
                font.pixelSize: Qt.application.font.pixelSize*1.33
                horizontalAlignment: Text.AlignHCenter
            }
        }

    }
}
