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

Item{
    id: unzoom
    Rectangle{
        id: unzoomButton
        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(game.zoom===1) {
                    //                    game.zoom=((page.height-pageHeader.height-maxSizeIndicTop-outsideBorderSize+insideBorderSize)/game.gridSize-insideBorderSize)
                    //                                                                                 /
                    //                            ((page.width-maxSizeIndicLeft-outsideBorderSize+insideBorderSize)/game.gridSize-insideBorderSize)
                    //game.zoom=3
                    if(game.gridSize < 6)
                        zoom = 2
                    else if(game.gridSize < 16)
                        zoom = 3
                    else
                        zoom = 4
                }
                else{
                    game.zoom=1
                    foldTopMode=true
                }
            }
        }

        width: 0.9*(sizeIndicLeft-outsideBorderSize)
        height: 0.9*(sizeIndicTop-outsideBorderSize)
        x: width/18
        y: height/18
        color: Qt.rgba(0, 0, 0, 0)
        border.width: 5
        border.color: Theme.rgba(Theme.highlightColor, 0.3)

        Image {
            source: "image://theme/icon-m-search"
            width: 4 * parent.width / 5
            height: 4 * parent.height / 5
            anchors.centerIn: parent
        }
    }
}
