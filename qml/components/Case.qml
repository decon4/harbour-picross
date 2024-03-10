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
    property string estate
    property int myID

    readonly property bool invalid: {
        switch (estate) {
        case "full":
        case "guess_full":
            return game.solvedGrid.get(myID).myEstate !== "full"
        case "hint":
        case "guess_hint":
            return game.solvedGrid.get(myID).myEstate === "full"
        default:
            break
        }
        return false
    }

    id: thisrect
    width: unitSize
    height: width

    Rectangle {
        anchors.fill: parent
        opacity: game.guessMode && thisrect.estate==="full"?0.25:1
        color: thisrect.estate==="full"||thisrect.estate=="guess_full"?Theme.rgba(Theme.highlightColor, 0.6):Qt.rgba(0, 0, 0, 0.1)
        radius: width * 0.1
        Behavior on color {ColorAnimation{duration: 100}}
        Behavior on opacity {NumberAnimation{duration: 100}}

        Rectangle {
            anchors.fill: parent
            visible: game.validateMode && thisrect.invalid
            color: "transparent"
            border {
                width: Math.max(0.1 * parent.width, 1)
                color: "red"
            }
        }
    }

    Canvas{
        property bool appActive: game.applicationActive
        onAppActiveChanged: requestPaint()

        id: canvas
        opacity: thisrect.estate==="hint"?game.guessMode?0.15:0.6:thisrect.estate==="guess_hint"?0.6:0
        Behavior on opacity {NumberAnimation{duration: 100}}
        width: parent.width
        height: parent.height
        onPaint:{
            var ctx = getContext("2d")
            ctx.strokeStyle = Theme.highlightColor
            ctx.lineWidth = width * 0.1
            ctx.lineCap = "round"

            ctx.beginPath()
            ctx.moveTo(0.3*width,0.3*height)
            ctx.lineTo(0.7*width, 0.7*height)
            ctx.stroke()
            ctx.closePath()

            ctx.beginPath()
            ctx.moveTo(0.3*width, 0.7*height)
            ctx.lineTo(0.7*width, 0.3*height)
            ctx.stroke()
            ctx.closePath()
        }
    }



    MouseArea{
        anchors.fill: parent

        property real realX: Math.floor((myID%game.gridSize*(unitSize+insideBorderSize)+mouseX)/(unitSize+insideBorderSize))
        property real realY: Math.floor((Math.floor(myID/game.gridSize)*(unitSize+insideBorderSize)+mouseY)/(unitSize+insideBorderSize))
        property int cellNumber:realX+realY*game.gridSize


        onPressAndHold: {
            if(!game.won) {
                if(!game.guessMode || (thisrect.estate!=="hint" && thisrect.estate!=="full")) {
                    flick.interactive=false
                    flickUp.interactive=false
                    if(game.vibrate)
                        game.longBuzz.start()
                    flash.flash()
                }
            }
        }

        onCellNumberChanged: if(!flick.interactive && realX>=0 && realY>=0 && realX<game.gridSize && realY<game.gridSize){
                                 game.currIndex = cellNumber
                                 if(game.mySolvingGrid.get(cellNumber).myEstate!==thisrect.estate){
                                     if(game.vibrate)
                                         game.shortBuzz.start()
                                     game.setSelectedCell(thisrect.estate)
                                 }
                             }

        onPressed: {
            game.currIndex = myID
        }

        onReleased:{
            flick.interactive=true
            flickUp.interactive=true
        }


        onClicked: {
            if(!game.won)
                game.clickSelectedCell()
        }
    }
}


