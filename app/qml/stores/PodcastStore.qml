import QtQuick 2.15
import Qt.labs.settings 1.1
import QuickFlux 1.1
import actions 1.0
import "../Utils.js" as Utils

Store {
    id: root
    property var searchResult: ([])
    property bool searchResultReady: false
    property bool isSearching: false
    property var subscribedList: ([])
    property var selected: ({})

    Settings {
        property alias subscribed: root.subscribedList
    }

    Filter {
        type: ActionTypes.search
        onDispatched: {
            root.searchResultReady = false
            root.isSearching = true
        }
    }

    Filter {
        type: ActionTypes.searchResults
        onDispatched: {
            root.isSearching = false
            root.searchResult = Utils.getSafe(message.payload, [])
        }
    }

    Filter {
        type: ActionTypes.subscribe
        onDispatched: {
            const id = Utils.getSafe(message.payload, null)
            const podcastToSubscribe = searchResult.find(item => item.id === id)

            if (!!podcastToSubscribe) {
                const podcastSubscribed = Object.assign(podcastToSubscribe, {
                                                            "is_subscribed": true
                                                        })
                subscribedList.push(podcastSubscribed)
                searchResultChanged()
                subscribedChanged()
            }
        }
    }

    Filter {
        type: ActionTypes.unSubscribe
        onDispatched: {
            const id = Utils.getSafe(message.payload, null)
            subscribedList = subscribedList.filter(item => item.id !== id)
            const podcastToUnsubscribe = searchResult.find(
                                           item => item.id === id)
            if (!!podcastToUnsubscribe) {
                Object.assign(podcastToUnsubscribe, {
                                  "is_subscribed": false
                              })
            }
            searchResultChanged()
            subscribedChanged()
        }
    }

    Filter {
        type: ActionTypes.selectPodcast
        onDispatched: {
            selected = Utils.getSafe(message.payload, {})
        }
    }
}
