import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    PageHeader {
        id: aboutTitle
        //title: qsTr("About Picross")
    }

    SilicaFlickable {
        id: aboutFlickable
        contentHeight: mainColumn.height
        anchors.top: aboutTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        VerticalScrollDecorator { flickable: aboutFlickable }

        Column {
            id: mainColumn
            width: parent.width - 2*Theme.paddingLarge
            y: parent.y
            x: Theme.paddingLarge
            spacing: Theme.paddingMedium

            //spacing: Theme.paddingLarge

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 3
                height: width
                source: "/usr/share/icons/hicolor/172x172/apps/harbour-picross2.png"
            }
            Label {
                text: "Picross"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Developed by")
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Baspar"
                font.pixelSize: Theme.fontSizeMedium
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("GitHub")
                onClicked: Qt.openUrlExternally("https://github.com/Baspar/harbour-picross")
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Maintainer")
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor

            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "direc85"
                font.pixelSize: Theme.fontSizeMedium
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("GitHub")
                onClicked: Qt.openUrlExternally("https://github.com/direc85/harbour-picross")
            }
        }
    }
}
