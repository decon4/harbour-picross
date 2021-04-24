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
