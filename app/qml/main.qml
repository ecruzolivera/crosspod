import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickFlux 1.1
import middlewares 1.0
import ui.pages 1.0
import stores 1.0

ApplicationWindow {
    minimumWidth: 640
    minimumHeight: 480
    width: 640
    height: 480
    visible: true
    title: MainStore.appName

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        PlayListPage {
            id: playListPageId
        }

        LibraryPage {
            id: libraryPageId
        }

        SearchPage {
            id: searchPageId
        }
    }

    header: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: playListPageId.name
        }

        TabButton {
            text: libraryPageId.name
        }

        TabButton {
            text: searchPageId.name
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            ToolButton {
                text: "<"
            }
            ToolButton {
                text: "Play"
            }
            ToolButton {
                text: ">"
            }
        }
    }

    MiddlewareList {
        applyTarget: AppDispatcher
        SystemMiddleware {}
        PodcastMiddleware {}
    }
}
