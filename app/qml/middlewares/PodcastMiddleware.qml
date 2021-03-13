import QtQuick 2.15
import QuickFlux 1.1
import actions 1.0

Middleware {

    function dispatch(type, message) {
        switch (type) {
        case ActionTypes.search:
            onSearch(message.payload)
            next(type, message)
            break
        case ActionTypes.subscribe:
            next(type, message)
            break
        case ActionTypes.unSubscribe:
            next(type, message)
            break
        default:
            next(type, message)
            break
        }
    }

    function onSearch(term) {
        const searchResults = ApiFixtures.normalizedSearchResult
        next(ActionTypes.searchResults, {
                 "payload": searchResults
             })
    }
}
