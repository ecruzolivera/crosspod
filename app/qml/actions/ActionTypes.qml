pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

KeyTable {
    // Call it when the initialization is finished.
    // Now, it is able to start and show the application
    property string startApp
    // Call it to quit the application
    property string quitApp
    // Podcasts
    property string search
    property string searchResults
    property string subscribe
    property string unSubscribe
    // Navigation
    property string selectPodcast
    // File manager
    property string downloadTrack
    property string deleteFile
    property string cleanCache
    // Player
    property string play
    property string stop
    property string next
    property string previous
    property string fastForward
    property string rewind
}
