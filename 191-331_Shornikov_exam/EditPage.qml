import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15

Page {
    id: editPage

    title: redactedNote > -1 ? "Редактирование" : "Создание"

    // ComboBox для выбора цвета, 2.1.
    ComboBox {
        id: colorSelection
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 15
        textRole: "text"
        valueRole: "color"
        width: 150
        height: 45
        Component.onCompleted: currentIndex = redactedNote > -1 ? indexOfValue(notesList.get(redactedNote).color) > -1 ? indexOfValue(notesList.get(redactedNote).color) : 0 : 0
        model: ListModel {
            id: cbItems
            ListElement { text: "Не выбрано"; color: "#c0f2ed" }
            ListElement { text: "Светло-синий"; color: "lightblue" }
            ListElement { text: "Светло-зелёный"; color: "lightgreen" }
            ListElement { text: "Светло-жёлтый"; color: "lightyellow" }
        }

        onCurrentIndexChanged: console.log("color changed to ", colorSelection.currentIndex)
    }
    // ComboBox для выбора тэга, 2.1.
    ComboBox {
        id: tagSelection
        anchors.left: colorSelection.right
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 15
        width: 175
        height: 45
        Component.onCompleted: currentIndex = redactedNote > -1 ? indexOfValue(notesList.get(redactedNote).tag) > -1 ? indexOfValue(notesList.get(redactedNote).tag) : 0 : 0
        model: ListModel {
            id: tags
            ListElement { text: "Не выбрано" }
            ListElement { text: "Работа" }
            ListElement { text: "Диплом" }
            ListElement { text: "Напоминания" }
            ListElement { text: "День рождения" }
        }

        onCurrentIndexChanged: console.log("tag changed to ", tagSelection.currentIndex)
    }

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
                notesList.setProperty(redactedNote, "color", colorSelection.currentValue)
                notesList.setProperty(redactedNote, "tag", tagSelection.currentValue)
            } else {
                notesList.append({
                                     "title": newTitle.text,
                                     "note": newNote.text,
                                     "color": colorSelection.currentValue,
                                     "tag": tagSelection.currentValue
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
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15
        maximumLength: 255
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
            color: colorSelection.currentValue
            anchors.fill: parent
        }
        // Настройки элемента прокрутки.
        id: textScroll
        anchors.top: newTitle.bottom
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 35
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
