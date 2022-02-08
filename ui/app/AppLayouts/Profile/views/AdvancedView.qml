import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.13

import utils 1.0
import shared 1.0
import shared.panels 1.0
import shared.popups 1.0
import shared.status 1.0

import "../stores"
import "../controls"
import "../popups"
import "../panels"

ScrollView {
    id: root

    property int profileContentWidth

    height: parent.height
    width: parent.width
    contentHeight: advancedContainer.height + 100
    clip: true

    property AdvancedStore advancedStore

    Item {
        id: advancedContainer
        width: profileContentWidth
        anchors.horizontalCenter: parent.horizontalCenter
        height: generalColumn.height

        Column {
            id: generalColumn
            anchors.top: parent.top
            anchors.topMargin: 64
            anchors.left: parent.left
            anchors.right: parent.right

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Network"
                text: qsTrId("network")
                visible: !localAccountSensitiveSettings.isMultiNetworkEnabled
                currentValue: root.advancedStore.currentNetworkName
                onClicked: networksModal.open()
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Fleet"
                text: qsTrId("fleet")
                currentValue: root.advancedStore.fleet
                onClicked: fleetModal.open()
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Minimize on close"
                text: qsTrId("minimize-on-close")
                isSwitch: true
                switchChecked: !localAccountSensitiveSettings.quitOnClose
                onClicked: function (checked) {
                    localAccountSensitiveSettings.quitOnClose = !checked
                }
            }

            // TODO: replace with StatusQ component
            StyledText {
                //% "Application Logs"
                text: qsTr("Application Logs")
                font.pixelSize: 15
                font.underline: mouseArea.containsMouse
                color: Style.current.blue
                topPadding: 23

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        Qt.openUrlExternally(root.advancedStore.logDir())
                    }
                }
            }

            Item {
                id: spacer1
                height: Style.current.bigPadding
                width: parent.width
            }

            Separator {
                anchors.topMargin: Style.current.bigPadding
                anchors.left: parent.left
                anchors.leftMargin: -Style.current.padding
                anchors.right: parent.right
                anchors.rightMargin: -Style.current.padding
            }

            StatusSectionHeadline {
                //% "Experimental features"
                text: qsTrId("experimental-features")
                topPadding: Style.current.bigPadding
                bottomPadding: Style.current.padding
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Wallet"
                text: qsTrId("wallet")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.isWalletEnabled
                onClicked: {
                    if (!localAccountSensitiveSettings.isWalletEnabled) {
                        confirmationPopup.experimentalFeature = root.advancedStore.experimentalFeatures.wallet
                        confirmationPopup.open()
                    } else {
                        root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.wallet)
                    }
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Dapp Browser"
                text: qsTrId("dapp-browser")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.isBrowserEnabled
                onClicked: {
                    if (!localAccountSensitiveSettings.isBrowserEnabled) {
                        confirmationPopup.experimentalFeature = root.advancedStore.experimentalFeatures.browser
                        confirmationPopup.open()
                    } else {
                        root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.browser)
                    }
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Communities"
                text: qsTrId("communities")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.communitiesEnabled
                onClicked: {
                    if (!localAccountSensitiveSettings.communitiesEnabled) {
                        confirmationPopup.experimentalFeature = root.advancedStore.experimentalFeatures.communities
                        confirmationPopup.open()
                    } else {
                        root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.communities)
                    }
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Activity Center"
                text: qsTrId("activity-center")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.isActivityCenterEnabled
                onClicked: {
                    if (!localAccountSensitiveSettings.isActivityCenterEnabled) {
                        confirmationPopup.experimentalFeature = root.advancedStore.experimentalFeatures.activityCenter
                        confirmationPopup.open()
                    } else {
                        root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.activityCenter)
                    }
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Node Management"
                text: qsTrId("node-management")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.nodeManagementEnabled
                onClicked: {
                    if (!localAccountSensitiveSettings.nodeManagementEnabled) {
                        confirmationPopup.experimentalFeature = root.advancedStore.experimentalFeatures.nodeManagement
                        confirmationPopup.open()
                    } else {
                        root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.nodeManagement)
                    }
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                id: onlineUsers
                //% "Online users"
                text: qsTrId("online-users")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.showOnlineUsers
                onClicked: {
                    root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.onlineUsers)
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "GIF Widget"
                text: qsTrId("gif-widget")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.isGifWidgetEnabled
                onClicked: {
                    root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.gifWidget)
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                text: qsTr("Multi network")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.isMultiNetworkEnabled
                onClicked: {
                    if (localAccountSensitiveSettings.isMultiNetworkEnabled) {
                        root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.multiNetwork)
                    } else {
                        confirmationPopup.experimentalFeature = root.advancedStore.experimentalFeatures.multiNetwork
                        confirmationPopup.open()
                    }
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                //% "Keycard"
                text: qsTr("Keycard")
                isSwitch: true
                switchChecked: localAccountSettings.isKeycardEnabled
                onClicked: {
                    root.advancedStore.toggleExperimentalFeature(root.advancedStore.experimentalFeatures.keycard)
                }
            }

            StatusSectionHeadline {
                visible: !root.advancedStore.isWakuV2
                //% "Bloom filter level"
                text: qsTrId("bloom-filter-level")
                topPadding: Style.current.bigPadding
                bottomPadding: Style.current.padding
            }

            Row {
                visible: !root.advancedStore.isWakuV2
                spacing: 11

                Component {
                    id: bloomConfirmationDialogComponent
                    ConfirmationDialog {
                        property string mode: "normal"

                        id: confirmDialog
                        //% "Warning!"
                        header.title: qsTrId("close-app-title")
                        //% "The account will be logged out. When you login again, the selected mode will be enabled"
                        confirmationText: qsTrId("the-account-will-be-logged-out--when-you-login-again--the-selected-mode-will-be-enabled")
                        onConfirmButtonClicked: {
                            root.advancedStore.setBloomLevel(mode)
                        }
                        onClosed: {
                            switch(root.advancedStore.bloomLevel){
                                case "light":  btnBloomLight.click(); break;
                                case "normal":  btnBloomNormal.click(); break;
                                case "full":  btnBloomFull.click(); break;
                            }
                            destroy()
                        }
                    }
                }

                ButtonGroup {
                    id: bloomGroup
                }

                BloomSelectorButton {
                    id: btnBloomLight
                    buttonGroup: bloomGroup
                    checkedByDefault: root.advancedStore.bloomLevel == "light"
                    //% "Light Node"
                    btnText: qsTrId("light-node")
                    onToggled: {
                        if (root.advancedStore.bloomLevel != "light") {
                            Global.openPopup(bloomConfirmationDialogComponent, {mode: "light"})
                        } else {
                            btnBloomLight.click()
                        }
                    }
                }

                BloomSelectorButton {
                    id: btnBloomNormal
                    buttonGroup: bloomGroup
                    checkedByDefault: root.advancedStore.bloomLevel == "normal"
                    //% "Normal"
                    btnText: qsTrId("normal")
                    onToggled: {
                        if (root.advancedStore.bloomLevel != "normal") {
                            Global.openPopup(bloomConfirmationDialogComponent, {mode: "normal"})
                        } else {
                            btnBloomNormal.click()
                        }
                    }
                }

                BloomSelectorButton {
                    id: btnBloomFull
                    buttonGroup: bloomGroup
                    checkedByDefault: root.advancedStore.bloomLevel == "full"
                    //% "Full Node"
                    btnText: qsTrId("full-node")
                    onToggled: {
                        if (root.advancedStore.bloomLevel != "full") {
                            Global.openPopup(bloomConfirmationDialogComponent, {mode: "full"})
                        } else {
                            btnBloomFull.click()
                        }
                    }
                }
            }

            StatusSectionHeadline {
                visible: root.advancedStore.isWakuV2
                text: qsTr("WakuV2 mode")
                topPadding: Style.current.bigPadding
                bottomPadding: Style.current.padding
            }

            Row {
                spacing: 11
                visible: root.advancedStore.isWakuV2
                Component {
                    id: wakuV2ModeConfirmationDialogComponent
                    ConfirmationDialog {
                        property bool mode: false

                        id: confirmDialog
                        //% "The account will be logged out. When you login again, the selected mode will be enabled"
                        confirmationText: qsTrId("the-account-will-be-logged-out--when-you-login-again--the-selected-mode-will-be-enabled")
                        onConfirmButtonClicked: {
                            root.advancedStore.setWakuV2LightClientEnabled(mode)
                        }
                        onClosed: {
                            if(root.advancedStore.wakuV2LightClientEnabled){
                                btnWakuV2Light.click()
                            } else {
                                btnWakuV2Full.click();
                            }
                            destroy()
                        }
                    }
                }

                ButtonGroup {
                    id: wakuV2Group
                }

                BloomSelectorButton {
                    id: btnWakuV2Light
                    buttonGroup: wakuV2Group
                    checkedByDefault: root.advancedStore.wakuV2LightClientEnabled
                    //% "Light Node"
                    btnText: qsTrId("light-node")
                    onToggled: {
                        if (!root.advancedStore.wakuV2LightClientEnabled) {
                            Global.openPopup(wakuV2ModeConfirmationDialogComponent, {mode: true})
                        } else {
                            btnWakuV2Light.click()
                        }
                    }
                }

                BloomSelectorButton {
                    id: btnWakuV2Full
                    buttonGroup: wakuV2Group
                    checkedByDefault: !root.advancedStore.wakuV2LightClientEnabled
                    //% "Full Node"
                    btnText: qsTrId("full-node")
                    onToggled: {
                        if (root.advancedStore.wakuV2LightClientEnabled) {
                            Global.openPopup(wakuV2ModeConfirmationDialogComponent, {mode: false})
                        } else {
                            btnWakuV2Full.click()
                        }
                    }
                }
            }

             StatusSectionHeadline {
                text: qsTr("Developer features")
                topPadding: Style.current.bigPadding
                bottomPadding: Style.current.padding
            }

            Separator {
                anchors.topMargin: Style.current.bigPadding
                anchors.left: parent.left
                anchors.leftMargin: -Style.current.padding
                anchors.right: parent.right
                anchors.rightMargin: -Style.current.padding
            }

            StatusSettingsLineButton {
                text: qsTr("Full developer mode")
                isEnabled: {
                    return !localAccountSensitiveSettings.downloadChannelMessagesEnabled ||
                        !root.advancedStore.isTelemetryEnabled ||
                        !root.advancedStore.isDebugEnabled ||
                        !root.advancedStore.isAutoMessageEnabled
                }
                onClicked: {
                    Global.openPopup(enableDeveloperFeaturesConfirmationDialogComponent)
                }
            }

            Separator {
                anchors.topMargin: Style.current.bigPadding
                anchors.left: parent.left
                anchors.leftMargin: -Style.current.padding
                anchors.right: parent.right
                anchors.rightMargin: -Style.current.padding
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                text: qsTr("Download messages")
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.downloadChannelMessagesEnabled
                onClicked: {
                    localAccountSensitiveSettings.downloadChannelMessagesEnabled = !localAccountSensitiveSettings.downloadChannelMessagesEnabled
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                text: qsTr("Telemetry")
                isSwitch: true
                switchChecked: root.advancedStore.isTelemetryEnabled
                onClicked: {
                    Global.openPopup(enableTelemetryConfirmationDialogComponent)
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                text: qsTr("Debug")
                isSwitch: true
                switchChecked: root.advancedStore.isDebugEnabled
                onClicked: {
                    Global.openPopup(enableDebugComponent)
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                text: qsTr("Auto message")
                isSwitch: true
                switchChecked: root.advancedStore.isAutoMessageEnabled
                onClicked: {
                    Global.openPopup(enableAutoMessageConfirmationDialogComponent)
                }
            }

            // TODO: replace with StatusQ component
            StatusSettingsLineButton {
                text: qsTr("Stickers/ENS on ropsten")
                visible: root.advancedStore.currentNetworkId === Constants.networkRopsten
                isSwitch: true
                switchChecked: localAccountSensitiveSettings.stickersEnsRopsten
                onClicked: {
                    localAccountSensitiveSettings.stickersEnsRopsten = !localAccountSensitiveSettings.stickersEnsRopsten
                }
            }
        }

        NetworksModal {
            id: networksModal
            advancedStore: root.advancedStore
        }

        FleetsModal {
            id: fleetModal
            advancedStore: root.advancedStore
        }

        Component {
            id: enableDeveloperFeaturesConfirmationDialogComponent
            ConfirmationDialog {
                property bool mode: false

                id: confirmDialog
                showCancelButton: true
                confirmationText: qsTr("Are you sure you want to enable all the develoer features? The app will be restarted.")
                onConfirmButtonClicked: {
                    localAccountSensitiveSettings.downloadChannelMessagesEnabled = true
                    Qt.callLater(root.advancedStore.enableDeveloperFeatures)
                    close()
                }
                onCancelButtonClicked: {
                    close()
                }
            }
        }

        Component {
            id: enableTelemetryConfirmationDialogComponent
            ConfirmationDialog {
                property bool mode: false

                id: confirmDialog
                showCancelButton: true
                confirmationText: qsTr("Are you sure you want to enable telemetry? This will reduce your privacy level while using Status. You need to restart the app for this change to take effect.")
                onConfirmButtonClicked: {
                    root.advancedStore.toggleTelemetry()
                    close()
                }
                onCancelButtonClicked: {
                    close()
                }
            }
        }

        Component {
            id: enableAutoMessageConfirmationDialogComponent
            ConfirmationDialog {
                property bool mode: false

                id: confirmDialog
                showCancelButton: true
                confirmationText: qsTr("Are you sure you want to enable auto message? You need to restart the app for this change to take effect.")
                onConfirmButtonClicked: {
                    root.advancedStore.toggleAutoMessage()
                    close()
                }
                onCancelButtonClicked: {
                    close()
                }
            }
        }

        Component {
            id: enableDebugComponent
            ConfirmationDialog {
                property bool mode: false

                id: confirmDialog
                showCancelButton: true
                confirmationText: qsTr("Are you sure you want to %1 debug mode? You need to restart the app for this change to take effect.").arg(root.advancedStore.isDebugEnabled ?
                    qsTr("disable") :
                    qsTr("enable"))
                onConfirmButtonClicked: {
                    root.advancedStore.toggleDebug()
                    close()
                }
                onCancelButtonClicked: {
                    close()
                }
            }
        }

        ConfirmationDialog {
            id: confirmationPopup
            property string experimentalFeature: ""
            showCancelButton: true
            //% "This feature is experimental and is meant for testing purposes by core contributors and the community. It's not meant for real use and makes no claims of security or integrity of funds or data. Use at your own risk."
            confirmationText: qsTrId("this-feature-is-experimental-and-is-meant-for-testing-purposes-by-core-contributors-and-the-community--it-s-not-meant-for-real-use-and-makes-no-claims-of-security-or-integrity-of-funds-or-data--use-at-your-own-risk-")
            //% "I understand"
            confirmButtonLabel: qsTrId("i-understand")
            onConfirmButtonClicked: {
                root.advancedStore.toggleExperimentalFeature(experimentalFeature)
                experimentalFeature = ""
                close()
            }

            onCancelButtonClicked: {
                close()
            }
        }
    }
}
