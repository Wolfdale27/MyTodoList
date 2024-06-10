import QtQuick
import QtQuick.Controls



Rectangle {
    height: 100
    width: parent.width
    color: "#301B3F"
    anchors.top: parent.top
    radius: 30

    function listModelSort(listModel, compareFunction) {
        let indexes = [ ...Array(todoModel.count).keys() ]
        indexes.sort( (a, b) => compareFunction( todoModel.get(a), todoModel.get(b) ) )
        let sorted = 0
        while ( sorted < indexes.length && sorted === indexes[sorted] ) sorted++
        if ( sorted === indexes.length ) return
        for ( let i = sorted; i < indexes.length; i++ ) {
            todoModel.move( indexes[i], todoModel.count - 1, 1 )
            todoModel.insert( indexes[i], { } )
        }
        todoModel.remove( sorted, indexes.length - sorted )
    }

    Row {
        anchors.left: topBar.left
        anchors.leftMargin: 70
        anchors.verticalCenter: topBar.verticalCenter
        anchors.margins: 10
        spacing: 80

        Rectangle {
            id:sorticon
            color: "red"
            height: 50
            width: 50
            radius: 40
            Image {
                anchors.centerIn: sorticon
                width: parent.width * 0.5
                height: parent.height * 0.5
                source: "qrc:/res/filter.png"
            }
        }

        Rectangle {
            id: sortName
            color: "green"
            height: sorticon.height
            width: 100
            radius: 40
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Сортировка по имени")
                    listModelSort(todoModel, (a, b) => a._name.localeCompare(b._name))
                }
            }
            Text {
                text: "Имя"
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: sortDesc
            color: "orange"
            height: sorticon.height
            width: 150
            radius: 40
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Сортировка по описанию")
                    listModelSort(todoModel, (a, b) => a._desc.localeCompare(b._desc))
                }
            }
            Text {
                text: "Описание"
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: sortDate
            color: "blue"
            height: sorticon.height
            width: 150
            radius: 40
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Сортировка по дате")
                    listModelSort(todoModel, (a, b) => a._date.localeCompare(b._date))
                }
            }
            Text {
                text: "Дата"
                color: "white"
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }

        Rectangle {
            id: sortCheck
            color: "violet"
            height: sorticon.height
            width: 150
            radius: 40
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Сортировка по статусу(!)")
                    listModelSort(todoModel, (a, b) => a._iscompleted !== b._iscompleted)
                }
            }
            Text {
                text: "Статус(!)"
                color: "red"
                font.pointSize: 20
                anchors.centerIn: parent
            }
        }
    }
}
