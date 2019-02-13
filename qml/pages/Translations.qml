import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    allowedOrientations: Orientation.All

    SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: header.height + column.height + Theme.paddingLarge

        VerticalScrollDecorator { flickable: flick }

        PageHeader {
            id: header
            title: qsTr("Translations")
        }

        Column {
            id: column
            anchors.top: header.bottom
            x: Theme.paddingLarge
            width: parent.width - 2*x

            SectionHeader { text: "English (275/275)" }
            Label { text: "Baspar\n"
                          +"Matti Viljanen (direc85)" }

            SectionHeader { text: "Finnish (275/275)" }
            Label { text: "Matti Viljanen (direc85)\n"
                          +"Joikkeli"  }

            SectionHeader { text: "French (261/275)" }
            Label { text: "Baspar" }

            SectionHeader { text: "Italian (253/275)" }
            Label { text: "Tichy" }

            SectionHeader { text: "Polish (241/275)" }
            Label { text: "atlochowski" }

            SectionHeader { text: "Spanish (275/275)" }
            Label { text: "Carmen F. B. (carmenfdezb)" }
        }
    }
}
