import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 896
    height: 414
    title: qsTr("Drone Ground Control Application")

    Loader{
        id: loader
        anchors.fill: parent
        source: "./UI/window.qml"
    }
}
