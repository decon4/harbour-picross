import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    SilicaFlickable {
        id: aboutFlickable
        contentHeight: mainColumn.height
        anchors.fill: parent

        VerticalScrollDecorator { flickable: aboutFlickable }

        PullDownMenu {
            MenuItem {
                text: qsTr("Translations")
                onClicked: pageStack.push(Qt.resolvedUrl("Translations.qml"))
            }
        }

        Column {
            id: mainColumn
            width: parent.width - 2*Theme.paddingLarge
            y: 4*Theme.paddingLarge
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
                text: "Picross v2.4.1"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                text: "13.2.2019"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("What's new?")
                onClicked: pageStack.push(Qt.resolvedUrl("WhatsNew.qml"))
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
                text: "GitHub"
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
                text: "GitHub"
                onClicked: Qt.openUrlExternally("https://github.com/direc85/harbour-picross")
            }
        }
    }
}
