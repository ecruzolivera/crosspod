import QtQuick 2.15
import QuickFlux 1.1
import actions 1.0

Store {
    id: root
    property var searchResult: ([])

    property bool searchResultReady: false
    property bool isSearching: false

    Filter {
        type: ActionTypes.search
        onDispatched: {
            console.log("ActionTypes.search term:",
                        JSON.stringify(message.payload))
            root.searchResultReady = false
            root.isSearching = true
        }
    }

    Filter {
        type: ActionTypes.searchResults
        onDispatched: {
            root.isSearching = false
            root.searchResult = message.payload || {}
        }
    }

    Filter {
        type: ActionTypes.subscribe
        onDispatched: console.log("ActionTypes.subscribe")
    }

    Filter {
        type: ActionTypes.unSubscribe
        onDispatched: console.log("ActionTypes.unSubscribe")
    }
}
