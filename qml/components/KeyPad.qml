import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Source.js" as Source

Item {
    height: downArrow.y + downArrow.height + Theme.paddingLarge

    property int currentIndex: game.selectedIndex
    property int numCells: game.dimension*game.dimension

    Key {
        id: upArrow
        x: 2*Theme.paddingLarge + width
        y: Theme.paddingLarge
        iconSource: "image://theme/icon-m-up"
        function onPressed() {
            game.updateIndex(-game.dimension)
        }
        function onReleased() {
        }
    }
    Key {
        id: leftArrow
        x: 2*Theme.paddingLarge
        y: Theme.paddingLarge + width
        source: "image://theme/icon-m-left"
        function onPressed() {
            game.updateIndex(-1)
        }
        function onReleased() {}
    }
    Key {
        id: downArrow
        x: 2*Theme.paddingLarge + width
        y: Theme.paddingLarge + 2*width
        iconSource: "image://theme/icon-m-down"
        function onPressed() {
            game.updateIndex(game.dimension)
        }
        function onReleased() {}
    }
    Key {
        id: rightArrow
        x: 2*Theme.paddingLarge + 2*width
        y: Theme.paddingLarge + width
        source: "image://theme/icon-m-right"
        function onPressed() {
            game.updateIndex(1)
        }
        function onReleased() {}
    }
    Key {
        id: actionButton
        x: parent.width - 2*Theme.paddingLarge - width
        y: Theme.paddingLarge + width
        source: "image://theme/icon-m-dot"
        function onPressed() {
            Source.click(game.mySolvingGrid, game.selectedIndex)
        }
        function onReleased() {}
    }
}
