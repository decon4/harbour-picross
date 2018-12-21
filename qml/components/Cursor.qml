import QtQuick 2.0

Rectangle {
    id: cursor
    property int index: game.currIndex
    property int space
    property int offset
    property int origX
    property int origY
    property int gridX: Math.floor(index % game.gridSize)
    property int gridY: Math.floor(index / game.gridSize)

    radius: width * 0.1
    color: 'transparent'
    border.color: 'white'
    border.width: width * 0.15

    x: gridX * width + (gridX-1) * space + offset
    y: gridY * height + (gridY-1) * space + offset

    Behavior on anchors.leftMargin{
        id: animX
        NumberAnimation {
            easing.type: Easing.OutQuint
            duration: 100
        }
    }
    Behavior on anchors.topMargin {
        id: animY
        NumberAnimation {
            easing.type: Easing.OutQuint
            duration: 100
        }
    }

    SequentialAnimation {
        running: cursor.visible
        loops: Animation.Infinite
        NumberAnimation {
            target: cursor
            property: "opacity"
            to: 0.5
            duration: 250
        }
        NumberAnimation {
            target: cursor
            property: "opacity"
            to: 0.25
            duration: 750
        }
    }

    function animate(isEnabled) {
        animX.enabled = isEnabled
        animY.enabled = isEnabled
    }
}
