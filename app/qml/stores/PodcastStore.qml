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
    property var subscribed: ([])

    onSearchResultChanged: console.log(JSON.stringify(searchResult))
    onSubscribedChanged: console.log(JSON.stringify(subscribed))

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
            root.searchResult = message.payload || []
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
                subscribed.push(podcastSubscribed)
                searchResultChanged()
                subscribedChanged()
            }

        }
    }

    Filter {
        type: ActionTypes.unSubscribe
        onDispatched: {
            const id = Utils.getSafe(message.payload, null)
            subscribed = subscribed.filter(item => item.id !== id)
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

    Settings {
        property alias subscribed: root.subscribed
    }
}
