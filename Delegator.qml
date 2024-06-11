import QtQuick
import QtQuick.Controls


Rectangle {

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
        radius: 40
        width: 50
        height: delegator.height
        anchors.right: delegator.right

        Image {
            anchors.centerIn: parent
            anchors.margins: 5
            height: parent.height * 0.4
            width: parent.width * 0.7
            source: "qrc:/res/trash.png"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                //Операция удаления
                console.log(index)
                todoModel.remove(index)
            }
        }
    }

    CheckBox {
        width: 30
        height: 30
        indicator.width: 40
        indicator.height: 40
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
            color: "#B4A5A5"
            font.bold: true
            font.pixelSize: 20
            text: delegator.name
        }

        Text {
            color: "#B4A5A5"
            font.bold: true
            font.pixelSize: 17
            text: delegator.description
        }

        Text {
            color: "#B4A5A5"
            font.bold: true
            font.pixelSize: 15
            text: delegator.date
        }
    }
}
