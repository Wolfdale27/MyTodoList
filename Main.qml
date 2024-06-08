import QtQuick
import QtQuick.Controls
//import QtQuick.Controls.Styles
//import QtQuick.LocalStorage
import todo_manager

Window {
    width: 1280
    height: 720
    visible: true
    color: "#151515"
    title: qsTr("TODO")

    TaskManager {
        id: appBridge
    }

    Component.onCompleted: {
        //здесь загружается сохранение
        /*for (var i = appBridge.dataBegin(); i <= appBridge.dataEnd(); i++) {
            todoModel.append({ "_name": i.m_name, "_desc": i.m_description, "_iscompleted": i.m_isCompleted, "_date": i.m_datetime})
        }*/
    }
    /*Component.onDestroyed: {
        appBridge.saveData()
    }*/

    ListModel {
        id: todoModel
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: topBar
            height: 100
            width: parent.width
            color: "#301B3F"
            anchors.top: parent.top
            radius: 30

            Rectangle {
                id: addbutton
                color: "green"
                height: 50
                width: 50
                anchors.left: topBar.left
                anchors.leftMargin: 70
                anchors.verticalCenter: topBar.verticalCenter
                anchors.margins: 10
                radius: 40
                MouseArea {
                    anchors.fill: addbutton
                    onClicked: appBridge.saveData()
                }
            }
            Text {
                text: "Ручное сохранение"
                color: "white"
                font.pointSize: 20
                anchors.top: addbutton.bottom
                anchors.horizontalCenter: addbutton.horizontalCenter
            }
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
                        font.pointSize: 30
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
                            font.pointSize: 50
                            opacity: enabled
                            color: "#B4A5A5"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            var currentDate  = new Date();
                            todoModel.append({ "_name": nameField.text, "_desc": descArea.text, "_iscompleted": false, "_date": currentDate})
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
