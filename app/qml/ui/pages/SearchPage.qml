import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import actions 1.0
import ui.theme 1.0

Pane {
    property string name: qsTr("Search")
    FocusScope {
        anchors.fill: parent
        Timer {
            id: debouncerTimerId
            interval: 500
            onTriggered: console.log(searchId.text)
        }

        TextField {
            id: searchId
            anchors.top: parent.top
            width: parent.width
            placeholderText: qsTr("Search Podcast...")
            focus: true
            onTextChanged: debouncerTimerId.restart()
        }

        ListView {
            id: resultsId
            anchors.top: searchId.bottom
            anchors.topMargin: Theme.spacing_sm
            anchors.bottom: parent.bottom
            width: parent.width
            spacing: Theme.spacing_sm
            clip: true
            model: 10
            ScrollBar.vertical: ScrollBar {}
            delegate: MouseArea {
                width: resultsId.width
                height: childrenRect.height
                onClicked: resultsId.currentIndex = index
                RowLayout {
                    width: resultsId.width
                    spacing: Theme.spacing_sm
                    Rectangle {
                        width: 75
                        height: 75
                        color: Qt.rgba(Math.random(), Math.random(),
                                       Math.random(), 100)
                    }
                    Column {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        spacing: Theme.spacing_sm / 2
                        Label {
                            text: "Title " + index
                            font.bold: true
                        }
                        Label {
                            text: "Description Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temporal" + index
                            wrapMode: Label.WordWrap
                            width: parent.width
                        }
                    }
                    Button {
                        text: qsTr("Subscribe")
                        onClicked: AppActions.subscribePodcast(index)
                    }
                }
            }
        }
    }
}
