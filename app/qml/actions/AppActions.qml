pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {

    signal startApp

    signal quitApp

    // Podcasts
    function search(term) {
        dispatch(ActionTypes.search, {
                     "payload": term
                 })
    }

    function searchResults(results) {
        dispatch(ActionTypes.searchResults, {
                     "payload": results
                 })
    }

    function subscribe(id) {
        dispatch(ActionTypes.subscribe, {
                     "payload": id
                 })
    }

    function unSubscribe(id) {
        dispatch(ActionTypes.unSubscribe, {
                     "payload": id
                 })
    }

    // File manager
    function downloadTrack() {
        dispatch(ActionTypes.downloadTrack, {
                     "payload": {}
                 })
    }

    function deleteFile() {
        dispatch(ActionTypes.deleteFile, {
                     "payload": {}
                 })
    }

    function cleanCache() {
        dispatch(ActionTypes.cleanCache, {
                     "payload": {}
                 })
    }

    // Player
    function play() {
        dispatch(ActionTypes.play, {
                     "payload": {}
                 })
    }
    function stop() {
        dispatch(ActionTypes.stop, {
                     "payload": {}
                 })
    }
    function next() {
        dispatch(ActionTypes.next, {
                     "payload": {}
                 })
    }
    function previous() {
        dispatch(ActionTypes.previous, {
                     "payload": {}
                 })
    }
    function fastForward() {
        dispatch(ActionTypes.previous, {
                     "payload": {}
                 })
    }
}
