import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import Qt.labs.settings 1.0

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
    // 3.1 + 3.2. Сохранение в файл и вывод из файла.
    property string datastore: ""

    // Восстанавливаем данные из файла.
    Component.onCompleted: {
        //cryptoController.decryptFile("", "file:///../build-191-331_Shornikov_exam-Desktop_Qt_5_15_2_MSVC2019_64bit-Debug/listModel_crypted.txt")
        if (datastore) {
            // Чистим модель, чтобы не было дублирования
            notesList.clear()
            // Парсим JSON
            var datamodel = JSON.parse(datastore)
            // Заполняем модель.
            for (var i = 0; i < datamodel.length; ++i) notesList.append(datamodel[i])
        }
    }

    // "Сохранение" в файл.
    onClosing: {
        var datamodel = []
        // Считываем элементы модели.
        for (var i = 0; i < notesList.count; ++i) datamodel.push(notesList.get(i))
        // Записываем в формате JSON.
        datastore = JSON.stringify(datamodel)
        //cryptoController.encryptFile("", "file:///../build-191-331_Shornikov_exam-Desktop_Qt_5_15_2_MSVC2019_64bit-Debug/listModel.txt")
    }

    Settings {
        property alias datastore: window.datastore
        fileName: "listModel.txt"
    }



    // Модель для создания, в будущем, "плитки" заметок.
    ListModel {
        id: notesList

        ListElement {
            title: "Заголовок 1"
            note: "Привет привет привет"
            color: "lightyellow"
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
