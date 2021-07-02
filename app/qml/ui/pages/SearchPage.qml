import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import actions 1.0
import stores 1.0
import ui.theme 1.0

Pane {
    property string name: qsTr("Search")
    FocusScope {
        anchors.fill: parent
        Timer {
            id: debouncerTimerId
            interval: 500
            onTriggered: {
                AppActions.search(searchId.text)
            }
        }

        TextField {
            id: searchId
            anchors.top: parent.top
            width: parent.width
            placeholderText: qsTr("Search Podcast...")
            focus: true
            onTextChanged: debouncerTimerId.restart()
        }

        StackView {
            id: stackViewId
            width: parent.width
            anchors.top: searchId.bottom
            anchors.topMargin: Theme.spacing_sm
            anchors.bottom: parent.bottom
            initialItem: resultsListViewId
        }

        Component {
            id: resultsListViewId
            ListView {
                id: resultsId
                anchors.fill: parent
                spacing: Theme.spacing_sm
                clip: true
                model: MainStore.podcast.searchResult
                ScrollBar.vertical: ScrollBar {}
                delegate: MouseArea {
                    width: resultsId.width
                    height: childrenRect.height
                    onClicked: {
                        AppActions.selectPodcast(modelData)
                        stackViewId.push(selectedPodcastId)
                    }
                    RowLayout {
                        width: resultsId.width
                        spacing: Theme.spacing_sm
                        Image {
                            Layout.preferredHeight: 100
                            Layout.preferredWidth: 100
                            asynchronous: true
                            fillMode: Image.PreserveAspectFit
                            source: modelData.image_url
                        }
                        Column {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: Theme.spacing_sm / 2
                            Label {
                                text: modelData.podcast_name
                                font.bold: true
                            }
                            Label {
                                text: modelData.description
                                wrapMode: Label.WordWrap
                                horizontalAlignment: Text.AlignJustify
                                width: parent.width
                            }
                        }
                        Button {
                            text: highlighted ? qsTr("Unsubscribe") : qsTr(
                                                    "Subscribe")
                            onClicked: highlighted ? AppActions.unSubscribe(
                                                         modelData.id) : AppActions.subscribe(
                                                         modelData.id)
                            highlighted: !!modelData.is_subscribed
                        }
                    }
                }
            }
        }
        Component {
            id: selectedPodcastId
            ColumnLayout {
                anchors.fill: parent
                spacing: Theme.spacing_sm
                property var selected: MainStore.podcast.selected
                Image {
                    Layout.preferredHeight: 100
                    Layout.preferredWidth: 100
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    source: selected.image_url
                }
                Column {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    spacing: Theme.spacing_sm / 2
                    Label {
                        text: selected.podcast_name
                        font.bold: true
                    }
                    Label {
                        text: selected.description
                        wrapMode: Label.WordWrap
                        horizontalAlignment: Text.AlignJustify
                        width: parent.width
                    }
                }
                Button {
                    text: highlighted ? qsTr("Unsubscribe") : qsTr("Subscribe")
                    onClicked: highlighted ? AppActions.unSubscribe(
                                                 modelData.id) : AppActions.subscribe(
                                                 modelData.id)
                    highlighted: !!selected.is_subscribed
                }
            }
        }
    }
}
