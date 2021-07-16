import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Page {
    id: editPage

    title: redactedNote > -1 ? "Редактирование" : "Создание"

    //Кнопка "Сохранить"
    Button {
        id: saveBtn
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.rightMargin: 25

        width: 175; height: 45
        background: Rectangle {
            radius: 5
            color: "#2bd4c3"
        }
        Text {
            text: "Сохранить"
            anchors.centerIn: parent
            font.pixelSize: 14
            color: "white"
        }
        onClicked: {
            if(redactedNote > -1) {
                notesList.setProperty(redactedNote, "title", newTitle.text)
                notesList.setProperty(redactedNote, "note", newNote.text)
            } else {
                notesList.append({
                                     "title": newTitle.text,
                                     "note": newNote.text
                                 })
            }
            stackView.pop(null)
        }
    }

    // TextField для заголовка
    TextField {
        id: newTitle
        anchors.top: saveBtn.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        maximumLength: 255
        width: 300
        height: 45
        background: Rectangle {
            radius: 10
            color: "#c0f2ed"
            anchors.fill: parent
        }
        color: "white"
        placeholderText: qsTr("Введите заголовок...")
        placeholderTextColor: "#262626"
        font.pixelSize: 14
        font.bold: true
        text: redactedNote > -1 ? notesList.get(redactedNote).title : ""
    }
    // TextArea для заметки, ScrollView для полосы прокрутки.
    ScrollView {
        // Задний фон.
        background: Rectangle {
            color: "#c0f2ed"
            anchors.fill: parent
        }
        // Настройки элемента прокрутки.
        id: textScroll
        anchors.top: newTitle.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        width: 250
        height: 150
        clip: true
        ScrollBar.horizontal.interactive: false
        ScrollBar.vertical.interactive: true
        // Поле ввода.
        TextArea {
            id: newNote
            font.pixelSize: 12
            height: parent.height
            placeholderText: qsTr("Введите текст...")
            placeholderTextColor: "#262626"
            text: redactedNote > -1 ? notesList.get(redactedNote).note : ""
            wrapMode: Text.Wrap
        }
    }
}
