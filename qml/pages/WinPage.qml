import QtQuick 2.0
import Sailfish.Silica 1.0
import "../DB.js" as DB
import "../Levels.js" as Levels


Page {
    id: winPage
    property int nextDiff: Levels.getNextDiff()
    property int nextLevel: Levels.getNextLevel()

    property ListModel modelcpy : ListModel{}
    property int gDimension
    property string gTitle
    property int gLevel
    property int gDiff
    property int bTime
    property int gTime

    Component.onCompleted:{
        // Prepare win screen
        gDimension = game.dimension
        gTitle     = game.title
        gLevel     = game.level+1
        gDiff      = game.diff+1
        gTime      = game.time
        bTime      = DB.getTime(game.diff, game.level)
        for(var i=0; i < game.solvedGrid.count; i++)
            modelcpy.append(game.solvedGrid.get(i))
    }
    onStatusChanged: {
        // Prepare the next level
        if(status == PageStatus.Active) {
            // Prepare the next level
            game.diff=nextDiff
            game.level=nextLevel
            game.save=DB.getSave(game.diff, game.level)
            Levels.initSolvedGrid(game.solvedGrid, game.diff, game.level)
            game.gridUpdated()
        }
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                id: nextLevelMenuItem
                enabled: nextDiff != -1 && nextLevel != -1
                visible: enabled
                text: qsTr("Next level")
                onClicked: {
                    game.pause = false
                    pageStack.replace(Qt.resolvedUrl("MainPage.qml"))
                }
            }
        }

        PageHeader {
            id: pageHeader
            title: qsTr("Level completed!")
        }
        Label {
            id: solution
            anchors.top: pageHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Level")+" "+gDiff+"-"+gLevel
            font.pixelSize: Theme.fontSizeMedium
        }
        Rectangle{
            id: myFinalRect
            border.width: Theme.paddingSmall
            border.color: Theme.rgba(Theme.highlightColor, 0.3)
            width: parent.width*3/4
            height: width
            color: Theme.rgba("black", 0.25)
            radius: width * 0.025
            anchors.top: solution.bottom
            anchors.topMargin: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter
            Grid{
                id: myFinalGrid
                anchors.centerIn: parent
                width: parent.width*0.90
                height: width
                columns: gDimension
                spacing: Theme.paddingLarge / gDimension
                property int rectSize: (myFinalGrid.width-(gDimension-1)*myFinalGrid.spacing)/gDimension
                Repeater{
                    model: modelcpy
                    Rectangle{
                        width: myFinalGrid.rectSize
                        height: myFinalGrid.rectSize
                        radius: width * 0.1
                        opacity: 0.5
                        color: myEstate==="full"?Theme.highlightColor:"transparent"
                    }
                }
            }
        }

        Label{
            id: titleLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: myFinalRect.bottom
            anchors.topMargin: Theme.paddingLarge
            font.pixelSize: Theme.fontSizeLarge
            text: gTitle
        }
        Label{
            id: yourTimeLabel1
            anchors.top: titleLabel.bottom
            anchors.topMargin: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.highlightColor
            text: qsTr("Your time")+":"
        }
        Label{
            id: yourTimeLabel2
            anchors.top: yourTimeLabel1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: gTime===0?"--:--:--":gTime>=60*60*24?"24:00:00+":new Date(null, null, null, null, null, gTime).toLocaleTimeString(Qt.locale(), "HH:mm:ss")
        }
        Label{
            id: bestTimeLabel1
            anchors.top: yourTimeLabel2.bottom
            anchors.topMargin: Theme.paddingMedium
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.highlightColor
            text: qsTr("Best time")+":"
        }
        Label{
            id: bestTimeLabel2
            anchors.top: bestTimeLabel1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: bTime===0?"--:--:--":bTime>=60*60*24?"24:00:00+":new Date(null, null, null, null, null, bTime).toLocaleTimeString(Qt.locale(), "HH:mm:ss")
        }
        Label{
            id: congratsLabel1
            anchors.top: bestTimeLabel2.bottom
            visible: nextLevel === -1 && nextDiff === -1
            anchors.topMargin: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.highlightColor
            text: qsTr("Congratulations!")
            font.pixelSize: Theme.fontSizeLarge * 1.1
        }
        Label{
            id: congratsLabel2
            anchors.top: congratsLabel1.bottom
            visible: nextLevel === -1 && nextDiff === -1
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.highlightColor
            text: qsTr("You solved every level!")
            font.pixelSize: Theme.fontSizeLarge * 1.1
        }
    }
}
