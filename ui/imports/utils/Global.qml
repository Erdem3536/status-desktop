pragma Singleton

import QtQuick 2.13
import "../../app/AppLayouts/Chat/popups"

QtObject {
    id: root

    property var applicationWindow
    property var appMain
    property bool popupOpened: false
    property int settingsSubsection: Constants.settingsSubsection.profile
    property var errorSound

    property var mainModuleInst
    property var toastMessage
    property bool profilePopupOpened: false
    property string currentNetworkId: ""
    property bool networkGuarded: root.currentNetworkId === Constants.networkMainnet ||
        (root.currentNetworkId === Constants.networkRopsten && localAccountSensitiveSettings.stickersEnsRopsten)

    signal openImagePopup(var image, var contextMenu)
    signal openLinkInBrowser(string link)
    signal openChooseBrowserPopup(string link)
    signal openPopupRequested(var popupComponent, var params)
    signal openDownloadModalRequested()
    signal settingsLoaded()
    signal openBackUpSeedPopup()

    signal openProfilePopupRequested(string publicKey, var parentPopup)
    signal openChangeProfilePicPopup()

    function openProfilePopup(publicKey, parentPopup){
        openProfilePopupRequested(publicKey, parentPopup);
    }

    function openPopup(popupComponent, params = {}) {
        root.openPopupRequested(popupComponent, params);
    }

    function openDownloadModal(){
        openDownloadModalRequested();
    }

    function changeAppSectionBySectionType(sectionType, subsection = 0) {
        if(!root.mainModuleInst)
            return

        mainModuleInst.setActiveSectionBySectionType(sectionType)
        if (sectionType === Constants.appSection.profile) {
            settingsSubsection = subsection;
        }
    }

    function getProfileImage(pubkey, isCurrentUser, useLargeImage) {
        if (isCurrentUser || (isCurrentUser === undefined && pubkey === userProfile.pubKey)) {
            return userProfile.icon;
        }

        let contactDetails = Utils.getContactDetailsAsJson(pubkey)
        if (localAccountSensitiveSettings.onlyShowContactsProfilePics && !contactDetails.isContact) {
            return;
        }

        return contactDetails.displayIcon
    }

    function openLink(link) {
        if (localAccountSensitiveSettings.showBrowserSelector) {
            openChooseBrowserPopup(link);
        } else {
            if (localAccountSensitiveSettings.openLinksInStatus) {
                changeAppSectionBySectionType(Constants.appSection.browser);
                openLinkInBrowser(link);
            } else {
                Qt.openUrlExternally(link);
            }
        }
    }

    function playErrorSound() {
        if(errorSound)
            errorSound.play();
    }

    function settingsHasLoaded() {
        settingsLoaded()
    }
}
