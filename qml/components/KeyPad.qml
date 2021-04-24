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

Item {
    Key {
        id: upArrow
        x: 2*Theme.paddingLarge + width
        y: parent.height/2 - height/2 - height
        iconSource: "image://theme/icon-m-up"
        function onPressed() {
            game.updateIndex(-game.gridSize)
        }
        function onReleased() {
        }
    }
    Key {
        id: leftArrow
        x: 2*Theme.paddingLarge
        y: parent.height/2 - height/2
        source: "image://theme/icon-m-left"
        function onPressed() {
            game.updateIndex(-1)
        }
        function onReleased() {}
    }
    Key {
        id: downArrow
        x: 2*Theme.paddingLarge + width
        y: parent.height/2 + height/2
        iconSource: "image://theme/icon-m-down"
        function onPressed() {
            game.updateIndex(game.gridSize)
        }
        function onReleased() {}
    }
    Key {
        id: rightArrow
        x: 2*Theme.paddingLarge + 2*width
        y: parent.height/2 - height/2
        source: "image://theme/icon-m-right"
        function onPressed() {
            game.updateIndex(1)
        }
        function onReleased() {}
    }
    Key {
        id: actionButton
        x: parent.width - 2*Theme.paddingLarge - width
        y: parent.height/2 - height/2
        source: "image://theme/icon-m-dot"
        function onPressed() {
            game.clickSelectedCell()
        }
        function onReleased() {}
    }
}
