/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"
import "Source.js" as Source
import "Levels.js" as Levels
import "DB.js" as DB


ApplicationWindow{

    Timer{
        id: myTimer
        repeat: true
        onTriggered: if(!won && !pause) time++

        Component.onCompleted: myTimer.start()
    }

    id: game
    initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    signal checkWin
    signal win

    property bool allLevelsCompleted: false
    property bool inLevelSelect: false

    property QtObject longBuzz
    property QtObject shortBuzz

    property int level: -1
    property int diff: -1

    property int time: 0

    property bool guessMode: false
    property string slideMode: ""
    property bool won: false
    property bool pause: false

    property bool foldTopMode: true
    property bool foldLeftMode: true
    property bool showKeypadHint: false

    property bool vibrate
    property bool zoomIndic
    property bool showKeypad
    property bool hideGrid: false

    property int gridSize: 0
    property int cellCount: gridSize * gridSize
    property int currIndex: 0
    property real zoom: 1
    property string hintTitle: ""
    property string title: ""

    property ListModel mySolvingGrid:ListModel{}
    property ListModel solvedGrid: ListModel{}
    property ListModel indicUp: ListModel{}
    property ListModel indicLeft: ListModel{}

    property int space
    property string save: ""
    property int nbSolvingFullCell
    property int nbSolvedFullCell


    property int maxHeight:0
    property int maxWidth:0

    /*
    // 0.5fps on 15x15 grid...
    Behavior on zoom {
        NumberAnimation {
                easing.type: Easing.OutQuint
                duration: 100
        }
    }
    */

    function clearData() {
        level = -1
        diff = -1
        time = 0
        gridSize = 0
        hintTitle = ""
        title = ""
        mySolvingGrid.clear()
        solvedGrid.clear()
        indicUp.clear()
        indicLeft.clear()
    }

    Component.onCompleted: {
        DB.initialize()

        //Parameters
        loadSettings()

        // Are all levels completed?
        allLevelsCompleted = DB.numCompletedLevels() === Levels.getNumLevels()

        //Buzzer
        longBuzz  = Qt.createQmlObject("import QtFeedback 5.0; HapticsEffect {attackTime: 50; fadeTime: 50; attackIntensity: 0.2; fadeIntensity: 0.01; intensity: 0.8; duration: 100}", game)
        shortBuzz = Qt.createQmlObject("import QtFeedback 5.0; HapticsEffect {attackTime: 25; fadeTime: 25; attackIntensity: 0.2; fadeIntensity: 0.01; intensity: 0.8; duration: 50}", game)
    }
    Component.onDestruction: {
        Source.save()
    }
    onApplicationActiveChanged:{
        if(!applicationActive){
            Source.save()
            pause=true
        } else {
            if(pageStack.depth === 1)
                pause=false
        }
    }

    function loadSettings() {
        space = DB.getParameter("space")
        vibrate = DB.getParameter("vibrate") === 1
        zoomIndic = DB.getParameter("zoomindic")
        showKeypad = DB.getParameter("showKeypad") === 1

        // The odd one out: -1 (unset) is evaluated as true
        showKeypadHint = DB.getParameter("showKeypadHint") !== 0

        if(showKeypad && showKeypadHint)
            disableKeyboardHint()
    }

    function loadLevel() {
        Levels.initSolvedGrid(solvedGrid, diff, level)
        maxWidth=0
        maxHeight=0
        foldTopMode=true
        won=false
        Source.genIndicCol(indicUp, solvedGrid)
        Source.genIndicLine(indicLeft, solvedGrid)
        if(save!==""){
            Source.loadSave(save)
            time=DB.getSavedTime(diff, level)
        } else {
            Source.initVoid(mySolvingGrid)
            time=0
        }
        pause=false
        slideMode=""
        zoom=1
        currIndex = (gridSize+(gridSize % 2 === 0 ? 1 : 0)) * (gridSize / 2)
    }

    onCheckWin: {
        if(!won && Source.checkWin())
            win()
    }

    onWin: {
        won=true
        DB.setIsCompleted(diff, level, 'true')
        DB.eraseSave(diff, level)
        if(DB.getTime(diff, level) === 0 || DB.getTime(diff, level) > time)
            DB.setTime(diff, level, time)
        pageStack.replace(Qt.resolvedUrl("pages/ScorePage.qml"))
        allLevelsCompleted = DB.numCompletedLevels() === Levels.getNumLevels()
    }

    function clickSelectedCell() {
        Source.click(mySolvingGrid, currIndex)
    }

    function setSelectedCell(newEstate) {
        Source.slideClick(mySolvingGrid, currIndex, newEstate)
    }

    function completeRowX(index, toFill) {
        Source.completeRowX(index, toFill)
    }

    function completeColX(index, toFill) {
        Source.completeColX(index, toFill)
    }

    function disableKeyboardHint() {
        DB.setParameter("showKeypadHint", 0)
        showKeypadHint = false
    }

    function updateIndex(change) {
        var currRow = Math.floor(currIndex / gridSize)
        var currColumn = currIndex % gridSize
        // Left / Right
        if(change === 1 || change === -1) {
            var newColumn = currColumn + change
            if(newColumn < 0)
                newColumn = newColumn + gridSize
            else if(newColumn >= gridSize)
                newColumn = newColumn - gridSize
            //console.log("("+currColumn+","+currRow+") -> ("+newColumn+","+currRow+")")
            currIndex = gridSize * currRow + newColumn
        }

        // Left / Right
        if(change === -gridSize || change === gridSize) {
            var newRow = currRow + (change > 0 ? 1 : -1)
            if(newRow < 0)
                newRow = newRow + gridSize
            else if(newRow >= gridSize)
                newRow = newRow - gridSize
            //console.log("("+currColumn+","+currRow+") -> ("+currColumn+","+newRow+")")
            currIndex = gridSize * newRow + currColumn
        }
    }

    Keys.onLeftPressed: updateIndex(-1)
    Keys.onRightPressed: updateIndex(1)
    Keys.onUpPressed: updateIndex(-gridSize)
    Keys.onDownPressed: updateIndex(gridSize)

    Keys.onSpacePressed: Source.click(mySolvingGrid, currIndex)
}
