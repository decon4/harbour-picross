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
