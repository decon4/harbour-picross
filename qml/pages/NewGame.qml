import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Source.js" as Source
import "../Levels.js" as Levels
import "../DB.js" as DB
import "../components"

Dialog{
    property int diffSelected: -1
    property int levelSelected: -1
    property string save: ""
    property bool autoLoadSaves: DB.getParameter("autoLoadSave") === 1
    property bool cheatMode: false

    id: newGameDialog
    canAccept: diffSelected != -1 && levelSelected != -1

    // Load last diff
    Component.onCompleted:{
        game.inLevelSelect = true
        Source.save()
        if(!cheatMode)
            mySlideShowView.positionViewAtIndex(Levels.getCurrentDiff(), PathView.SnapPosition)
    }

    onAccepted: {
        game.hideGrid = true
        game.diff=diffSelected
        game.level=levelSelected
        game.save=save
        game.inLevelSelect = false
    }

    onRejected: {
        game.pause=false
        game.inLevelSelect = false
    }

    // Title: New game
    DialogHeader {
        id: header
        title: cheatMode?qsTr("Cheat..."):qsTr("Level select")
        acceptText: qsTr("Play")
        cancelText: qsTr("Back")
    }

    // Difficulty list
    Item {
        id: diffSelector
        anchors.top: header.bottom
        width: parent.width
        height: Theme.paddingSmall + Theme.fontSizeHuge + Theme.paddingSmall

        // Indicator bar background
        Rectangle {
            width: parent.width
            height: Theme.paddingSmall
            color: Theme.highlightColor
            opacity: Theme.highlightBackgroundOpacity
        }

        // Indicator bar highlight
        Rectangle{
            width: parent.width / diffListModel.count
            height: Theme.paddingSmall
            x: parent.width / diffListModel.count * mySlideShowView.currentIndex
            color: Theme.secondaryHighlightColor
            opacity: 1 - Theme.highlightBackgroundOpacity / 3
            Behavior on x { NumberAnimation { duration: 100 } }
        }

        // The clickable difficulty items
        SilicaListView {
            id: diffSelectorItems
            y: Theme.paddingSmall
            width: parent.width
            height: Theme.fontSizeHuge

            orientation: ListView.Horizontal

            // Model: difficulty levels
            model: ListModel {
                id: diffListModel
                Component.onCompleted: Levels.getDifficultiesAndLevels(diffListModel)
            }

            // Delegate: each difficulty
            delegate: Item {
                height: parent.height
                width: diffSelector.width / diffListModel.count

                // "Text background" for item
                Rectangle {
                    id: diffItemBack
                    anchors.fill: parent
                    color: Theme.highlightColor
                    opacity: Theme.highlightBackgroundOpacity / 3
                    Behavior on opacity { NumberAnimation { duration: 100 } }
                }

                // Difficulty text for item
                Label {
                    anchors.centerIn: diffItemBack
                    property bool locked: Levels.isLocked(index)
                    color: locked ? Theme.highlightColor : Theme.primaryColor
                    opacity: locked ? 0.5 : 1
                    text : name
                    font.pixelSize: Theme.fontSizeTiny
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    onContainsMouseChanged: {
                        if(containsMouse) {
                            diffItemBack.opacity = Theme.highlightBackgroundOpacity
                        }
                        else {
                            diffItemBack.opacity = Theme.highlightBackgroundOpacity / 3
                        }
                    }
                    onClicked: {
                        diffItemBack.opacity = Theme.highlightBackgroundOpacity
                        mySlideShowView.currentIndex = index
                        Theme.highlightDimmerColor
                        levelSelected = -1
                    }
                }
            }
        }
    }

    // Level list
    SlideshowView {
        id: mySlideShowView
        interactive: DB.getParameter("slideInteractive")===1 && diffSelected===-1
        clip: true
        width: parent.width
        anchors.top: diffSelector.bottom
        anchors.bottom: parent.bottom

        model: ListModel{
            id: difficultyList
            Component.onCompleted: Levels.getDifficultiesAndLevels(difficultyList)
        }

        delegate : Item {
            id: currentLevelList
            property int difficultyIndex: index
            property int completedLevels: DB.getNbCompletedLevel(difficultyIndex)
            width: parent.width
            height: parent.height
            Column{
                anchors.topMargin: Theme.paddingSmall
                anchors.fill: parent
                spacing: Theme.paddingSmall

                // Diff details
                Label{
                    id: diffLabel
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: Theme.highlightColor
                    text: name+" ["+completedLevels+"/"+levelList.count+"]"
                    Component.onCompleted: {
                        if(Levels.isLocked(difficultyIndex))
                            text = name+" [?/?]"
                    }
                    MouseArea{
                        anchors.fill: parent
                        MouseArea{
                            anchors.fill: parent
                            //onPressAndHold: cheatMode = !cheatMode
                        }
                    }
                }

                // Separator
                Rectangle{
                    id: separatorRect
                    width: parent.width
                    height: Theme.paddingSmall
                    color: Theme.rgba(Theme.highlightColor, 0.2)
                }

                // Level list
                SilicaListView{
                    id: levelView
                    clip: true
                    VerticalScrollDecorator{}
                    height: parent.height - separatorRect.height - diffLabel.height - Theme.paddingMedium
                    width: parent.width

                    ViewPlaceholder{
                        verticalOffset: -(mySlideShowView.y + separatorRect.y) / 2
                        enabled: Levels.isLocked(difficultyIndex)
                        text: qsTr("Locked")
                        hintText: qsTr("Complete all previous levels to unlock this difficulty")
                    }

                    model: ListModel{
                        id: levelList
                        Component.onCompleted: {
                            if(!Levels.isLocked(difficultyIndex))
                                Levels.arrayToList(difficultyIndex, levelList)
                            else
                                levelList.clear()
                        }
                    }
                    delegate: ListItem{
                        id: levelItem
                        menu: contextMenu
                        contentHeight: levelTitle.height + levelDescription.height + Theme.paddingSmall

                        property int levelIndex:  index   // 0-based index
                        property int levelNumber: index+1 // 1-based index

                        property bool hasSavedState: DB.getSave(difficultyIndex, levelIndex) !== ""
                        property bool isCompleted: DB.isCompleted(difficultyIndex, levelIndex)

                        Rectangle {
                            anchors.fill: parent
                            visible: (levelItem.highlighted || (levelIndex==levelSelected && difficultyIndex==diffSelected))
                            color: Theme.highlightBackgroundColor
                            opacity: Theme.highlightBackgroundOpacity
                        }

                        // Draw empty level completex checkbox
                        Image {
                            id: levelCheckbox
                            source: "image://theme/icon-m-tabs"
                            width: 2*Theme.fontSizeExtraSmall
                            height: 2*Theme.fontSizeExtraSmall
                            x: Theme.paddingMedium
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // If the level is completed, draw the tick in the box
                        Image {
                            id: levelCheckboxTick
                            visible: isCompleted
                            source: "image://theme/icon-m-dismiss"
                            width: Theme.fontSizeExtraSmall*1.6
                            height: Theme.fontSizeExtraSmall*1.6
                            x: Theme.paddingMedium + 0.2*Theme.fontSizeExtraSmall
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // First row, e.g. "[3x3] Box"
                        Label{
                            id: levelTitle
                            text: levelNumber+". ["+dimension+"x"+dimension+"] " + (isCompleted ? title : "")
                            font.pixelSize: Theme.fontSizeMedium
                            anchors.left: levelCheckbox.right
                            anchors.leftMargin: Theme.paddingMedium
                            anchors.topMargin: Theme.paddingSmall
                            anchors.right: parent.right
                        }
                        // Second row, e.g. "Numbers = size of the groups"
                        Label{
                            id: levelDescription
                            anchors.top: levelTitle.bottom
                            anchors.left: levelCheckbox.right
                            anchors.leftMargin: Theme.paddingMedium
                            anchors.right: parent.right
                            text: hintTitle
                            font.pixelSize: Theme.fontSizeSmall
                        }
                        onPressed: {
                            if(cheatMode){
                                DB.setIsCompleted(myDiff, myLevel, 'true')
                                levelCheckboxTick.visible = true
                                levelTitle.text= (myLevel+1)+". ["+dimension+"x"+dimension+"] " + (DB.isCompleted(myDiff, myLevel)?title:"?????")
                                levelTitle.color= listItem.highlighted || (myLevel == levelSelected && myDiff == diffSelected)
                                        ? Theme.highlightColor
                                        : DB.isCompleted(myDiff, myLevel)? Theme.primaryColor:"grey"
                            }else{
                                if(diffSelected !== myDiff || levelSelected !== myLevel){
                                    diffSelected=myDiff
                                    levelSelected=myLevel
                                    save=DB.getParameter("autoLoadSave")===0?"":DB.getSave(myDiff, myLevel)
                                } else {
                                    diffSelected=-1
                                    levelSelected=-1
                                }
                            }
                        }

                        ContextMenu {
                            id: contextMenu
                            MenuItem {
                                text: qsTr("Play from scratch")
                                onClicked: {
                                    diffSelected=difficultyIndex
                                    levelSelected=levelIndex
                                    save=""
                                    accept()
                                }
                            }
                            MenuItem {
                                id: restoreSave
                                visible: DB.getSave(myDiff, myLevel)!==""
                                text: qsTr("Restore save")
                                onClicked: {
                                    diffSelected=difficultyIndex
                                    levelSelected=levelIndex
                                    save=DB.getSave(difficultyIndex, levelIndex)
                                    accept()
                                }
                            }
                            MenuItem {
                                id: eraseSave
                                visible: DB.getSave(myDiff, myLevel)!==""
                                text: qsTr("Erase save")
                                onClicked: {
                                    DB.eraseSave(difficultyIndex, levelIndex)
                                    levelItem.hasSavedState = false
                                }
                            }
                            MenuItem {
                                visible: isCompleted
                                text: qsTr("Details")
                                onClicked: {
                                    pageStack.push(Qt.resolvedUrl("ScorePage.qml"), {"gDiff": myDiff, "gLevel": myLevel, "highScorePage": true})
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
