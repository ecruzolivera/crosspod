import QtQuick 2.0
import QuickFlux 1.1
import actions 1.0

Store {
    readonly property string appName : "CrossPod"


    Filter{
        type: ActionTypes.startApp
        onDispatched: console.log("ActionTypes.startApp")
    }

    Filter{
        type: ActionTypes.subscribePodcast
        onDispatched: console.log("ActionTypes.subscribePodcast")
    }

}
