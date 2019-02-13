import QtQuick 2.0
import Sailfish.Silica 1.0
import "../DB.js" as DB

Page{
    id: newsPage

    PageHeader {
        id: newsTitle
        title: "What's new?"
    }

    SilicaFlickable {
        id: newsFlickable
        contentHeight: mainColumn.height
        anchors.top: newsTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        clip: true

        VerticalScrollDecorator { flickable: newsFlickable }

        Column {
            id: mainColumn
            width: parent.width - 2*Theme.paddingLarge
            x: Theme.paddingLarge
            spacing: Theme.paddingSmall

            SectionHeader {
                text: "Picross v2.4.1 (13.2.2019)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text: "- Added translations' credits page"
            }
            SectionHeader {
                text: "Picross v2.4 (11.2.2019)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
"- Added simple statistics to welcome page
- Added Polish and Spanish translations"
            }
            SectionHeader {
                text: "Picross v2.3 (17.12.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
"- What's new page added in About page
- Keypad hint added
- Dragging difficulty bar handled correctly
- Add indicator for saved level
- Fix level loading indicator
- Fix keypad cursor wrapping
- Less opaque grid in application cover
- Cross made shorter and bolder (again)
- Added version and date to About page
- Level select dialog uses SQLite more effectively
- Code cleanup, reorganisation and clarification"
            }
            SectionHeader {
                text: "Picross v2.2 (09.12.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
"- On-screen keypad
- Disable cover action if already on level select
- Code reorganisation
- Make flash animation weaker and shorter
- Reseting settings actually works now
- Fix stuttering level selection
- Add loading indicator to main page
- Auto save when entering level select"
            }
            SectionHeader {
                text: "Picross v2.1 (07.12.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
"- Don't start next levels game timer in winning screen"
            }
            SectionHeader {
                text: "Picross v2.0 (29.11.2018)"
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                width: parent.width
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                text:
"- Fix: level selection empty
- QML-only application, fix QML warnings
- Finnish translation
- Fixed level selection layout
- Redesign many UI elements
- Many parts rewritten or revised
- Retouched zoom levels
- Option for automatic grid size
- Update icons
" // Newline intentional
            }
        }
    }
}
