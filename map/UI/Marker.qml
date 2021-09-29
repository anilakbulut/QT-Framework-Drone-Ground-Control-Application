import QtQuick 2.0
import QtLocation 5.11

MapQuickItem {
    id: marker
    sourceItem: Rectangle {
        width: 32
        height: 32
        color: "transparent"
        Image {
            anchors.fill: parent
            source: "button.png"
            sourceSize: Qt.size(parent.width, parent.height)
        }
    }
    opacity: 1.0
    anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
}
