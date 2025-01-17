import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

ColumnLayout {
    property alias loadAsynchronously: loadAsyncCheckBox.checked
    property alias figmaToken: figmaTokenTextInput.text

    CheckBox {
        id: loadAsyncCheckBox

        Layout.fillWidth: true

        text: "Load pages asynchronously"
    }

    GroupBox {
        Layout.fillWidth: true

        title: "Figma token"

        ColumnLayout {
            anchors.fill: parent

            Label {
                Layout.fillWidth: true

                text: `Figma token can be obtained <a href=\"https://www.figma.com/developers/api#access-tokens\">here</a>
                by clicking \"Get personal access token\". It's necessary to fetch figma data via Figma API.`

                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Text.Wrap
            }

            TextField {
                id: figmaTokenTextInput

                Layout.fillWidth: true

                placeholderText: "Figma personal access token"
            }
        }
    }
}
