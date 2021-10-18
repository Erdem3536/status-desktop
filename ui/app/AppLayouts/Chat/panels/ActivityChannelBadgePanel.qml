import QtQuick 2.13

import utils 1.0
import "../../../../shared"
import "../../../../shared/panels"
import "../../../../shared/controls"
import "../../../../shared/status"

import "../controls/activityCenter" as ActivityCenter

Rectangle {
    id: wrapper

    property string name: "channelName"
    property string identicon: ""
    property string chatId: ""
    property int realChatType: -1
    property string communityId
    property string channelName: ""
    property string communityName: ""
    property string communityColor: ""
    property string communityThumbnailImage: ""
    property int replyMessageIndex: -1
    property string repliedMessageContent: ""
    property int notificationType
    property string profileImage: ""

    property color textColor: Style.current.textColor

    signal communityNameClicked()
    signal channelNameClicked()

    height: visible ? 24 : 0
    width: childrenRect.width + 12
    color: Style.current.transparent
    border.color: Style.current.borderSecondary
    border.width: 1
    radius: 11

    Loader {
        active: true
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 4
        sourceComponent: {
            switch (wrapper.notificationType) {
            case Constants.activityCenterNotificationTypeMention: return wrapper.communityId ? communityBadgeComponent : channelBadgeComponent
            case Constants.activityCenterNotificationTypeReply: return replyComponent
            default: return wrapper.communityId ? communityBadgeComponent : channelBadgeComponent
            }
        }
    }

    ActivityCenter.ReplyComponent {
        id: replyComponent
        width: childrenRect.width
        height: parent.height
        replyMessageIndex: wrapper.replyMessageIndex
        repliedMessageContent: wrapper.repliedMessageContent
    }

    ActivityCenter.CommunityBadge {
        id: communityBadgeComponent
        width: childrenRect.width
        height: parent.height

        textColor: wrapper.textColor
        image: wrapper.communityThumbnailImage
        iconColor: wrapper.communityColor
        communityName: wrapper.communityName
        channelName: wrapper.channelName
        name: wrapper.name

        onCommunityNameClicked: communityNameClicked()
        onChannelNameClicked: channelNameClicked()
    }

    ActivityCenter.ChannelBadge {
        id: channelBadgeComponent
        width: childrenRect.width
        height: parent.height

        realChatType: wrapper.realChatType
        textColor: wrapper.textColor
        name: wrapper.name
        chatId: wrapper.chatId
        profileImage: wrapper.profileImage
        identicon: wrapper.identicon
    }
}