import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Page {
    id: mainPage // Страница для отображения заметок.

    title: "Заметки"

    GridView { // Список для отображения заметок.
        id: notesView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 35; anchors.topMargin: 25
        width: parent.width*0.95
        height: parent.height*0.85

        model: notesList

        cellWidth: 110; cellHeight: 110 // Ширина, высота ячейки.

        delegate: noteDelegate
        // Создаем делегат (шаблон) для нашего списка.
        Component {
            id: noteDelegate
            MouseArea {
                width: 105
                height: 105
                Rectangle {
                    id: noteElement
                    anchors.fill: parent
                    color: notesList.get(index).color
                    Label {
                        id: noteLabel
                        text: "<font color='"+(notesList.get(index).color !== "lightyellow" ? "white" : "black" )+"'><strong>"+title+"</strong></font>"
                        background: Rectangle {
                            color: "#2bd4c3"
                            radius: 4
                        }
                        width: parent.width
                        height: 20
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                    }
                    Text {
                        id: noteText
                        anchors.top: noteLabel.bottom
                        anchors.topMargin: 5
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        width: parent.width
                        wrapMode: Text.WordWrap
                        height: 30
                        elide: Text.ElideRight
                        font.pixelSize: 12
                        color: notesList.get(index).color !== "lightyellow" ? "white" : "black"
                        text: note
                    }
                    Text {
                        id: tagText
                        anchors.top: noteText.bottom
                        anchors.topMargin: 25
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        horizontalAlignment: Text.AlignHCenter
                        width: parent.width
                        wrapMode: Text.WordWrap
                        height: 15
                        font.bold: true
                        font.pixelSize: 12
                        color: notesList.get(index).color !== "lightyellow" ? "white" : "black"
                        text: tag
                    }
                }
                onClicked: {
                    redactedNote = index
                    stackView.push("EditPage.qml")
                    //console.log(mouseX, mouseY, redactedNote)
                }
            }
        }
    }

    // Кнопка для создания заметки.
    RoundButton {
        Text {
            anchors.centerIn: parent
            text: "\uFF0B" // Символ "+"
            font.pixelSize: 48
        }
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 55; anchors.rightMargin: 35
        width: 75; height: 75
        // Создание новой заметки.
        onClicked: {
            redactedNote = -1
            stackView.push("EditPage.qml")
            // Было до добавления страницы редактирования.
            //            notesList.append({
            //                                 "title": "Заголовок",
            //                                 "note": "Какой-то текст..."
            //                             })
            //            console.log(notesList.get(notesList.count).note)
        }
    }
}
