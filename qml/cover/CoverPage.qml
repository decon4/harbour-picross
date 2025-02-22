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
import "../pages"

CoverBackground {
    Rectangle {

        transform: [Rotation {angle: 33}, Scale { xScale: 2; yScale: 2}, Translate {x: width/3; y: width/5}]
        id: rectGrille
        color: Qt.rgba(0, 0, 0, 0.1)
        width: parent.width*0.9
        height: width
        radius: width*0.01

        Grid {
            id: grille
            width: parent.width*0.95
            height: width
            anchors.centerIn: parent
            spacing: 2
            columns: game.gridSize
            Repeater {
                id: myRepeat
                model: game.mySolvingGrid
                Rectangle {
                    property string estate:myEstate
                    id: thisrect
                    width: (rectGrille.width-(game.gridSize-1)*2)/game.gridSize
                    height: width
                    color: thisrect.estate=="full"?Theme.rgba(Theme.highlightColor, 0.2):Qt.rgba(0, 0, 0, 0.05)
                    radius: width * 0.1

                    Canvas{
                        id: cross
                        opacity: (thisrect.estate=="hint")?0.3:0
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
                }
            }
        }
    }
    Label {
        id: levelInfo
        anchors.horizontalCenter: parent.horizontalCenter
        y: Theme.fontSizeSmall
        enabled: game.gStatus === "playing"
        visible: enabled
        text: "Level " + (game.diff+1) + "-" + (game.level+1)
    }
    Label {
        id: levelTime
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: levelInfo.bottom
        enabled: game.gStatus === "playing"
        visible: enabled
        text: new Date(null, null, null, null, null, game.time).toLocaleTimeString(Qt.locale(), "HH:mm:ss")
    }
    Label {
        id: label1
        anchors.centerIn: parent
        font.pixelSize: Theme.fontSizeLarge
        text: qsTr("Picross")
    }
    CoverActionList {
        id: coverAction
        enabled: game.gState === "welcome" || game.gState === "playing"
        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                if (!game.applicationActive) {
                    game.activate()
                }
                pageStack.push(Qt.resolvedUrl("../pages/NewGame.qml"))
                game.pause=true
                game.gState = "levelSelect"
            }
        }
    }
}


