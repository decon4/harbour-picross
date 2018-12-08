import QtQuick 2.0
import Sailfish.Silica 1.0

Image {
    property string iconColor: Theme.primaryColor
    property string iconSource: "image://theme/icon-m-keypad"
    property int size: Theme.iconSizeLarge

    source: iconSource + "?" + iconColor
    width: size
    height: size
    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.iconColor = Theme.highlightColor
            parent.onPressed()
        }
        onReleased: {
            parent.iconColor = Theme.primaryColor
            parent.onReleased()
        }
    }

    // Implement onPressed() and onReleased()
}
