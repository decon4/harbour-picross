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

Page {
    allowedOrientations: Orientation.All

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: header.height + column.height + Theme.paddingLarge

        VerticalScrollDecorator { flickable: flick }

        PageHeader {
            id: header
            title: qsTr("Translations")
        }

        Column {
            id: column
            anchors.top: header.bottom
            x: Theme.paddingLarge
            width: parent.width - 2*x

            SectionHeader { text: "English (275/275)" }
            Label { text: "Baspar\n"
                          +"Matti Viljanen (direc85)" }

            SectionHeader { text: "Finnish (275/275)" }
            Label { text: "Matti Viljanen (direc85)\n"
                          +"Joikkeli"  }

            SectionHeader { text: "French (261/275)" }
            Label { text: "Baspar" }

            SectionHeader { text: "Italian (253/275)" }
            Label { text: "Tichy" }

            SectionHeader { text: "Polish (241/275)" }
            Label { text: "atlochowski" }

            SectionHeader { text: "Spanish (275/275)" }
            Label { text: "Carmen F. B. (carmenfdezb)" }
        }
    }
}
