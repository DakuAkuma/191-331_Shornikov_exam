import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Page {
    id: mainPage // Страница для отображения заметок.

    title: "Заметки"
    // Модель для создания, в будущем, "плитки" заметок.
    ListModel {
        id: notesList

        ListElement {
            title: "Заголовок 1"
            note: "Привет привет привет"
        }

        ListElement {
            title: "Заголовок 2"
            note: "Привет привет привет привет привет привет"
        }
    }

    GridView {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 25; anchors.topMargin: 25
        width: parent.width*0.95
        height: parent.height*0.85

        model: notesList

        cellWidth: 120; cellHeight: 120 // Ширина, высота ячейки.

        delegate: noteDelegate
        // Создаем делегат (шаблон) для нашего списка.
        Component {
            id: noteDelegate
            Rectangle {
                id: noteElement
                width: 105
                height: 105
                color: "#c0f2ed"
                Label {
                    id: noteLabel
                    text: "<font color='white'><strong>"+title+"</strong></font>"
                    background: Rectangle {
                        color: "#2bd4c3"
                        radius: 4
                    }
                    width: parent.width
                    height: 20
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                }
                Text {
                    id: noteText
                    anchors.top: noteLabel.bottom
                    width: parent.width
                    height: 40
                    wrapMode: Text.WordWrap
                    font.pixelSize: 14
                    color: "white"
                    text: note
                }
            }
        }
    }
}
