//не удается определиться с версиями зависимостей, так что только одна с указанием
import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Qt.labs.settings 1.0
//import QtQuick.Controls.Styles
//import QtQuick.LocalStorage
import todo_manager

Window {
    width: 1280
    height: 720
    visible: true
    color: "#151515"
    title: qsTr("TODO")

    Settings {
        id: settings
    }
    //@disable-check M16
    onClosing: {

        var dataSaver = []
        for (var i =0; i < todoModel.count; ++i) {
            dataSaver.push(todoModel.get(i))
        }
        settings.setValue("todoData", JSON.stringify(dataSaver))
        console.log("Called closing")
    }



    Component.onCompleted: {
        var storage = settings.value("todoData")
        if (storage) {
            todoModel.clear()
            var dataLoader = JSON.parse(storage)
            for(var i = 0; i < dataLoader.length; ++i){
                todoModel.append(dataLoader[i])
            }
        }
        console.log("Called completed")
    }



    TaskManager {
        id: appBridge
    }

    ListModel {
        id: todoModel
    }

    Item {
        anchors.fill: parent

        Topbar {
            id: topBar
        }

        Item {
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.top: topBar.bottom

            Rectangle {
                id: todo
                height: parent.height
                width: parent.width * 0.47
                anchors.right: parent.right
                radius: 30
                color: "#3C415C"

                ListView {
                    id:lView
                    model: todoModel
                    spacing: 5
                    anchors.centerIn: parent
                    width: todo.width * 0.65
                    height: todo.height * 0.8
                    delegate: Delegator {
                        id: delegator
                        width: lView.width
                        height: 100
                        color: "#301B3F"
                        radius: 10
                    }
                }
            }

            Rectangle {
                id: controlPanel
                height: parent.height
                width: parent.width * 0.47
                anchors.left: parent.left
                radius: 30
                color: "#3C415C"
                Column {
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    spacing: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    TextField {
                        id: nameField
                        placeholderText: "Введите имя..."
                        font.pointSize: 25
                        height: 100
                        width: controlPanel.width * 0.65
                        color: "#B4A5A5"
                    }

                    TextArea {
                        id:descArea
                        placeholderText: "Введите описание..."
                        font.pointSize: 20
                        color: "#B4A5A5"
                        width: controlPanel.width * 0.65
                        height: 200

                    }

                    Button {
                        height: 100
                        width: controlPanel.width * 0.65
                        contentItem: Text {
                            anchors.fill: parent
                            text: qsTr("Добавить")
                            font.pointSize: 30
                            opacity: enabled
                            color: "#B4A5A5"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            var currentDate  = new Date();
                            todoModel.append({ "_name": nameField.text, "_desc": descArea.text, "_iscompleted": false, "_date": currentDate.toDateString()})
                            //Передача аргументов в C++: объект типа Task
                            appBridge.setData(nameField.text, descArea.text, currentDate, false)

                            //Сброс полей ввода во избежание коллизий
                            nameField.text = ""
                            descArea.text = ""
                        }
                    }
                }
            }
        }
    }
}
