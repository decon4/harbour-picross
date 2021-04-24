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

Rectangle {
    id: rectGrille
    property int newSpace: calculateGridSize()

    function calculateGridSize() {
        var numCells = 0
        // Set spacer size automatically?
        if(game.space === -1) {
            switch(game.gridSize) {
            case 12:
            case 17:
                numCells = 3
                break
            case 8:
            case 19:
                numCells = 4
                break
            case 15:
            case 20:
            case 25:
                numCells = 5
                break
            case 14:
                numCells= 7
                break
            case 3:
            case 5:
            default:
                numCells = 0
            }
        }
        else {
            numCells = game.space
        }
        return numCells
    }

    color: Qt.rgba(255, 255, 255, 0.1)
    width: game.gridSize*unitSize+(game.gridSize-1)*insideBorderSize
    height: width

    Grid {
        id: grille
        anchors.fill: parent
        spacing: insideBorderSize
        columns: game.gridSize
        Repeater {
            id: myRepeat
            model: game.mySolvingGrid
            Case{
                estate:myEstate
                myID: index
            }
        }
    }

    // Horizontal separators
    Repeater{
        enabled: newSpace > 0
        visible: enabled
        model: (game.gridSize-1)/newSpace
        Rectangle{
            x: (newSpace*(index+1)-1)*insideBorderSize+newSpace*(index+1)*unitSize
            y:0
            width: insideBorderSize
            height: rectGrille.height
            color: Theme.rgba(Theme.highlightColor, 0.1)
        }
    }

    // Vertical separators
    Repeater{
        enabled: newSpace > 0
        visible: enabled
        model: (game.gridSize-1)/newSpace
        Rectangle{
            x: 0
            y: (newSpace*(index+1)-1)*insideBorderSize+newSpace*(index+1)*unitSize
            width: rectGrille.height
            height: insideBorderSize
            color: Theme.rgba(Theme.highlightColor, 0.1)
        }
    }

    Cursor {
        id: cursor
        visible: game.showKeypad && game.zoom === 1
        width: unitSize
        height: unitSize
        space: insideBorderSize
        offset: insideBorderSize
        origX: grille.x
        origY: grille.y
    }

}
