import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

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
        id: information
        anchors.top: header_d.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width

        Text { // Информация о приложении.
            id: information_text
            anchors.fill: parent
            text: "Экзаменационное задание по дисциплине \"Разработка безопасных мобильных приложений\",\nМосковский политех,\n16 июля 2021 г."
            wrapMode: Text.WordWrap
            font.pixelSize: Qt.application.font.pixelSize*1.33
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Image { // Логотип Политеха.
        id: mpu_logo
        anchors.centerIn: parent
        width: parent.width-(parent.width*0.15)
        fillMode: Image.PreserveAspectFit
        source: "img/logo.png"
    }

    Label { // Email автора.
        id: author_mail
        text: "Автор: andrey19h4@gmail.com"
        font.pixelSize: Qt.application.font.pixelSize*1.33
        anchors.bottom: repolink.top
        anchors.bottomMargin: 25
        width: parent.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    Label { // ссылка на репозиторий.
        id: repolink
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 35
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width

        Text {
            id: link_r
            anchors.fill: parent
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Qt.application.font.pixelSize*1.33
            // Ссылка на репу и её открытие.
            text: "<a href='https://github.com/DakuAkuma/191-331_Shornikov_exam'>https://github.com/DakuAkuma/191-331_Shornikov_exam</a>"
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }

}
