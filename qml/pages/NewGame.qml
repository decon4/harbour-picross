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
    property bool cheatMode: false

    id: newGameDialog
    canAccept: diffSelected != -1 && levelSelected != -1

    // Title: New game
    DialogHeader{
        id: pageTitle
        title: cheatMode?qsTr("Cheat..."):qsTr("Level select")
        acceptText: qsTr("Play")
        cancelText: qsTr("Back")
    }

    // Difficulty list
    Item {
        id: diffSelector
        anchors.top: pageTitle.bottom
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
    SlideshowView{
        interactive: DB.getParameter("slideInteractive")===1 && diffSelected===-1
        id: mySlideShowView
        clip: true
        width: parent.width
        anchors.top: decoratorTop.bottom
        anchors.bottom: parent.bottom
        model: ListModel{
            id: difficultyList
            Component.onCompleted: Levels.getDifficultiesAndLevels(difficultyList)
        }
        delegate : Rectangle{
            property int myDiff: index
            width: parent.width
            height: parent.height
            color: "transparent"
            Column{
                anchors.topMargin: Theme.paddingSmall
                anchors.fill: parent
                spacing: Theme.paddingSmall
                // Diff details
                Item{
                    height: diffHeader.height
                    width: parent.width
                    Label{
                        id: diffHeader
                        anchors.centerIn: parent
                        text: name+" ["+DB.getNbCompletedLevel(myDiff)+"/"+levelList.count+"]"
                        color: Theme.highlightColor
                        Component.onCompleted: {
                            if(Levels.isLocked(myDiff))
                                text = name+" [?/?]"
                        }
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
                    clip: true
                    VerticalScrollDecorator{}
                    id: levelView
                    height: parent.height - separatorRect.height - diffHeader.height - Theme.paddingMedium
                    width: parent.width

                    ViewPlaceholder{
                        verticalOffset: -pageTitle.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        enabled : Levels.isLocked(myDiff)
                        text: qsTr("Locked")
                        hintText: qsTr("Complete all previous levels to unlock this difficulty")
                    }

                    model: ListModel{
                        id: levelList
                        Component.onCompleted: {
                            if(!Levels.isLocked(myDiff))
                                Levels.arrayToList(myDiff, levelList)
                            else
                                levelList.clear()
                        }
                    }
                    delegate: ListItem{
                        property int myLevel: index
                        id: listItem
                        menu: contextMenu
                        contentHeight: levelTitle.height + levelDescription.height + Theme.paddingSmall
                        Rectangle{
                            anchors.fill: parent
                            visible: (listItem.highlighted || (myLevel==levelSelected && myDiff==diffSelected))
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
                            visible: DB.isCompleted(myDiff, myLevel)
                            source: "image://theme/icon-m-dismiss"
                            width: Theme.fontSizeExtraSmall*1.6
                            height: Theme.fontSizeExtraSmall*1.6
                            x: Theme.paddingMedium + 0.2*Theme.fontSizeExtraSmall
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        // First row, e.g. "[3x3] Box"
                        Label{
                            id: levelTitle
                            text: (myLevel+1)+". ["+dimension+"x"+dimension+"] " + (DB.isCompleted(myDiff, myLevel)?title:"?????")
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
                                    diffSelected=myDiff
                                    levelSelected=myLevel
                                    save=""
                                    accept()
                                }
                            }
                            MenuItem {
                                id: restoreSave
                                visible: DB.getSave(myDiff, myLevel)!==""
                                text: qsTr("Restore save")
                                onClicked: {
                                    diffSelected=myDiff
                                    levelSelected=myLevel
                                    save=DB.getSave(myDiff, myLevel)
                                    accept()
                                }
                            }
                            MenuItem {
                                id: eraseSave
                                visible: DB.getSave(myDiff, myLevel)!==""
                                text: qsTr("Erase save")
                                onClicked: {
                                    DB.eraseSave(myDiff, myLevel)
                                    restoreSave.visible = false
                                    eraseSave.visible = false
                                }
                            }
                            MenuItem {
                                visible: DB.isCompleted(myDiff, myLevel)
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
}
