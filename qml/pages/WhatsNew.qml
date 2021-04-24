/**
 * Picross, a picross/nonogram game for Sailfish
 *
 * Copyright (C) 2015-2018 Bastien Laine
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
 * Authors: Bastien Laine, Matti Viljanen
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../DB.js" as DB

Page{
    id: newsPage

    PageHeader {
        id: newsTitle
        title: "What's new?"
    }

    SilicaFlickable {
        id: newsFlickable
        contentHeight: mainColumn.height + Theme.paddingLarge
        anchors.top: newsTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true

        VerticalScrollDecorator { flickable: newsFlickable }

        Column {
            id: mainColumn
            width: parent.width - 2*Theme.paddingLarge
            x: Theme.paddingLarge
            spacing: Theme.paddingSmall

            SectionHeader {
                text: "Picross v2.4.2 (24.5.2019)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "- Animate victory screen"
            }
            SectionHeader {
                text: "Picross v2.4.1 (13.2.2019)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "- Added translations' credits page"
            }
            SectionHeader {
                text: "Picross v2.4 (11.2.2019)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "- Added simple statistics to welcome page\n"+
                      "- Added Polish and Spanish translations"
            }
            SectionHeader {
                text: "Picross v2.3 (17.12.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
                    "- What's new page added in About page\n"+
                    "- Keypad hint added\n"+
                    "- Dragging difficulty bar handled correctly\n"+
                    "- Add indicator for saved level\n"+
                    "- Fix level loading indicator\n"+
                    "- Fix keypad cursor wrapping\n"+
                    "- Less opaque grid in application cover\n"+
                    "- Cross made shorter and bolder (again)\n"+
                    "- Added version and date to About page\n"+
                    "- Level select dialog uses SQLite more effectively\n"+
                    "- Code cleanup, reorganisation and clarification"
            }
            SectionHeader {
                text: "Picross v2.2 (09.12.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "- On-screen keypad\n"+
                      "- Disable cover action if already on level select\n"+
                      "- Code reorganisation\n"+
                      "- Make flash animation weaker and shorter\n"+
                      "- Reseting settings actually works now\n"+
                      "- Fix stuttering level selection\n"+
                      "- Add loading indicator to main page\n"+
                      "- Auto save when entering level select"
            }
            SectionHeader {
                text: "Picross v2.1 (07.12.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
                    "- Don't start next levels game timer in winning screen"
            }
            SectionHeader {
                text: "Picross v2.0 (29.11.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
                    "- Fix: level selection empty\n"+
                    "- QML-only application, fix QML warnings\n"+
                    "- Finnish translation\n"+
                    "- Fixed level selection layout\n"+
                    "- Redesign many UI elements\n"+
                    "- Many parts rewritten or revised\n"+
                    "- Retouched zoom levels\n"+
                    "- Option for automatic grid size\n"+
                    "- Update icons"
            }
        }
    }
}
