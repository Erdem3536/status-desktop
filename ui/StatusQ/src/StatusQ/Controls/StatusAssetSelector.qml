import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1
import StatusQ.Controls 0.1
import StatusQ.Components 0.1

Item {
    id: root
    property var assets
    property var selectedAsset
    property var tokenAssetSourceFn: function (symbol) {
        return ""
    }
    property var assetGetterFn: function (index, field) {
        // This is merely to make the component work with nim model data
        // as well as static QML ListModel data
        if (typeof assets.get === "function") {
            return assets.get(index)[field]
        }
        return assets.rowData(index, field)
    }
    implicitWidth: 86
    implicitHeight: 32

    function resetInternal() {
        assets = null
        selectedAsset = null
    }

    onSelectedAssetChanged: {
        if (selectedAsset && selectedAsset.symbol) {
            iconImg.image.source = tokenAssetSourceFn(selectedAsset.symbol.toUpperCase())
            selectedTextField.text = selectedAsset.symbol.toUpperCase()
        }
    }

    onAssetsChanged: {
        if (!assets) {
            return
        }
        selectedAsset = {
            name: assetGetterFn(0, "name"),
            symbol: assetGetterFn(0, "symbol"),
            value: assetGetterFn(0, "value"),
            fiatBalanceDisplay: assetGetterFn(0, "fiatBalanceDisplay"),
            address: assetGetterFn(0, "address"),
            fiatBalance: assetGetterFn(0, "fiatBalance")
        }
    }

    StatusSelect {
        id: select
        width: parent.width
        bgColor: "transparent"
        bgColorHover: Theme.palette.directColor8
        model: root.assets
        caretRightMargin: 0
        select.radius: 6
        select.height: root.height
        selectMenu.width: 342
        selectedItemComponent: Item {
            anchors.fill: parent
            StatusRoundedImage {
                id: iconImg
                anchors.left: parent.left
                anchors.leftMargin: 4
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
            }
            StatusBaseText {
                id: selectedTextField
                anchors.left: iconImg.right
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 15
                height: 22
                verticalAlignment: Text.AlignVCenter
                color: Theme.palette.directColor1
            }
        }
        selectMenu.delegate: menuItem
    }

    Component {
        id: menuItem
        MenuItem {
            id: itemContainer
            property bool isFirstItem: index === 0
            property bool isLastItem: index === assets.rowCount() - 1

            width: parent.width
            height: 72
            StatusRoundedImage {
                id: iconImg
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                image.source: root.tokenAssetSourceFn(symbol.toUpperCase())
            }
            Column {
                anchors.left: iconImg.right
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter

                StatusBaseText {
                    text: symbol.toUpperCase()
                    font.pixelSize: 15
                    color: Theme.palette.directColor1
                }

                StatusBaseText {
                    text: name
                    color: Theme.palette.baseColor1
                    font.pixelSize: 15
                }
            }
            Column {
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                StatusBaseText {
                    font.pixelSize: 15
                    text: parseFloat(value).toFixed(4) + " " + symbol
                }
                StatusBaseText {
                    font.pixelSize: 15
                    anchors.right: parent.right
                    text: fiatBalanceDisplay.toUpperCase()
                    color: Theme.palette.baseColor1
                }
            }
            background: Rectangle {
                color: itemContainer.highlighted ? Theme.palette.statusSelect.menuItemHoverBackgroundColor : Theme.palette.statusSelect.menuItemBackgroundColor
            }
            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: itemContainer
                onClicked: {
                    root.selectedAsset = { address, name, value, symbol, fiatBalance, fiatBalanceDisplay }
                    select.selectMenu.close()
                }
            }
        }
    }
}