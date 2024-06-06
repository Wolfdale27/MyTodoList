import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import todo_manager

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Hello World")

    TaskManager {
        id: appBridge
    }

    ListModel {
            id: todoModel
        }

        Item {
            anchors.fill: parent

            Rectangle {
                id: topBar
                height: 100
                width: parent.width
                color: "red"
                anchors.top: parent.top
            }

            Item {
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.top: topBar.bottom

                Rectangle {
                    id: todo
                    height: parent.height
                    width: parent.width * 0.5
                    anchors.left: parent.left
                    color: "#808080"

                    ListView {
                        id:lView
                        model: todoModel

                        spacing: 5
                        anchors.centerIn: parent
                        width: todo.width * 0.65
                        height: todo.height * 0.8
                        delegate: Rectangle {
                            id: delegator
                            width: lView.width
                            height: 100
                            color: "#696969"
                            radius: 10

                            //переменные делегатора, определяют содержимое задачи
                            property string name
                            property string description
                            property date date
                            property bool iscompleted

                            //в дальнейшем значения присваиваются по ключу с префиксом _
                            name: _name
                            description: _desc
                            date: _date
                            iscompleted: _iscompleted

                            //кнопка удаления задачи
                            Rectangle {
                                color: "red"
                                radius: 10
                                width: 50
                                height: delegator.height
                                anchors.right: delegator.right

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        console.log(index)
                                        todoModel.remove(index)
                                        //Операция удаления


                                    }
                                }
                            }

                            CheckBox {
                                width: 30
                                height: 30
                                anchors.left: delegator.left
                                checked: delegator.iscompleted
                            }

                            //колонка с данными задачи
                            Column {
                                anchors.fill: parent
                                anchors.leftMargin: 40
                                anchors.rightMargin: 50
                                anchors.topMargin: 5
                                anchors.bottomMargin: 5

                                Text {
                                    color: "black"
                                    font.bold: true
                                    font.pixelSize: 20
                                    text: delegator.name
                                }

                                Text {
                                    color: "black"
                                    font.bold: true
                                    font.pixelSize: 17
                                    text: delegator.description
                                }

                                Text {
                                    color: "black"
                                    font.bold: true
                                    font.pixelSize: 17
                                    text: delegator.date
                                }
                            }
                        }
                    }
                }

                Item {
                    id: controlPanel
                    height: parent.height
                    width: parent.width * 0.5
                    anchors.right: parent.right
                    Column {
                        anchors.top: parent.top
                        anchors.topMargin: 50
                        spacing: 50
                        anchors.horizontalCenter: parent.horizontalCenter
                        TextField {
                            id: nameField
                            placeholderText: "Введите имя..."
                            height: 100
                            width: controlPanel.width * 0.65
                            color: "black"
                        }

                        TextArea {
                            id:descArea
                            placeholderText: "Введите описание..."
                            width: controlPanel.width * 0.65
                            height: 200
                        }

                        Button {
                            text: "+"
                            height: 100
                            width: controlPanel.width * 0.65
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
