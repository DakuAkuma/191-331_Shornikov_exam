import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

ApplicationWindow { // Само приложение.
    id:window
    width: 640
    height: 480
    visible: true
    title: qsTr("Заметки")

    property int redactedNote: -1 // Редактируемая заметка. -1 для избежания кривой работы.

    header: ToolBar { // Заголовок для страницы "Заметок"
        contentHeight: toolButton.implicitHeight
        background: Rectangle {
            anchors.fill: parent
            color: "#262626"
        }

        ToolButton {
            id: toolButton
            background: Rectangle {
                anchors.fill: parent
                color: "#262626"
            }

            text: stackView.depth > 1 ? "<font color='white'>\u25C0</font>" : "<font color='white'>\u2630</font>"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop(null)
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: Qt.application.font.pixelSize * 1.6
        }
    }
    // Модель для создания, в будущем, "плитки" заметок.
    ListModel {
        id: notesList

        ListElement {
            title: "Заголовок 1"
            note: "Привет привет привет"
            color: "lightblue"
            tag: "Работа"
        }

        ListElement {
            title: "Заголовок 2"
            note: "Привет привет привет привет привет привет"
            color: "lightgreen"
            tag: "Диплом"
        }
    }

    // Страница, отображающая все заметки.
    MainPage {
        id: mainPage
    }
    // Страница для редактирования.
    EditPage {
        id: editPage
    }

    // Боковая информационная панель
    DrawerInfo {
        id: drawer
    }

    // Для отображения страничек используем StackView
    StackView {
        id: stackView
        initialItem: "MainPage.qml"
        anchors.fill: parent
    }
}
