/**
 * Picross, a picross/nonogram game for Sailfish
 *
 * Copyright (C) 2019-2022 Matti Viljanen
 *
 * Picross is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Picross is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with Picross. If not, see <https://www.gnu.org/licenses/gpl-3.0.html>.
 *
 * Authors: Matti Viljanen
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: aboutPage

    SilicaFlickable {
        id: aboutFlickable
        contentHeight: mainColumn.height + header.height + Theme.paddingMedium
        anchors.fill: parent

        VerticalScrollDecorator { flickable: aboutFlickable }

        PullDownMenu {
            MenuItem {
                text: qsTr("Translations")
                onClicked: pageStack.push(Qt.resolvedUrl("Translations.qml"))
            }
        }

        PageHeader {
            id: header
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
            AboutLabel {
                text: "Picross v2.4.2"
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            AboutLabel {
                text: "24.5.2019"
                font.pixelSize: Theme.fontSizeSmall
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("What's new?")
                onClicked: pageStack.push(Qt.resolvedUrl("WhatsNew.qml"))
            }
            AboutLabel {
                text: qsTr("Developed by")
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
            }
            AboutLabel {
                text: "Baspar"
                font.pixelSize: Theme.fontSizeMedium
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text: "GitHub"
                onClicked: Qt.openUrlExternally("https://github.com/Baspar/harbour-picross")
            }
            AboutLabel {
                text: qsTr("Maintainer")
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
            }
            AboutLabel {
                text: "direc85"
                font.pixelSize: Theme.fontSizeMedium
            }
            Button{
                anchors.horizontalCenter: parent.horizontalCenter
                text: "GitHub"
                onClicked: Qt.openUrlExternally("https://github.com/direc85/harbour-picross")
            }
            BackgroundItem {
                anchors.horizontalCenter: parent.horizontalCenter
                width: Theme.iconSizeExtraLarge * 1.2
                height: Theme.iconSizeExtraLarge * 1.2
                onClicked: Qt.openUrlExternally("https://ko-fi.com/direc85")
                contentItem.radius: Theme.paddingSmall
                Image {
                    anchors.centerIn: parent
                    source: Qt.resolvedUrl("/usr/share/harbour-picross2/images/Ko-fi_Icon_RGB_rounded.png")
                    width: Theme.iconSizeExtraLarge
                    height: Theme.iconSizeExtraLarge
                    smooth: true
                    asynchronous: true
                }
            }
            AboutLabel {
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.secondaryColor
                text: qsTr("If you like my work and would like to support me, you can buy me a coffee!")
            }
        }
    }
}
