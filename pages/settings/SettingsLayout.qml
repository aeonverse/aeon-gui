// Copyright (c) 2014-2018, The Monero Project
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
// 
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other
//    materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific
//    prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

import "../../js/Utils.js" as Utils
import "../../js/Windows.js" as Windows
import "../../components" as MoneroComponents

Rectangle {
    color: "transparent"
    Layout.fillWidth: true
    property alias layoutHeight: settingsUI.height

    ColumnLayout {
        id: settingsUI
        property int itemHeight: 60
        Layout.fillWidth: true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        anchors.topMargin: 0
        spacing: 6

        MoneroComponents.CheckBox {
            id: customDecorationsCheckBox
            checked: persistentSettings.customDecorations
            onClicked: Windows.setCustomWindowDecorations(checked)
            text: qsTr("Custom decorations") + translationManager.emptyString
        }

        MoneroComponents.CheckBox {
            id: checkForUpdatesCheckBox
            enabled: !disableCheckUpdatesFlag
            checked: persistentSettings.checkForUpdates && !disableCheckUpdatesFlag
            onClicked: persistentSettings.checkForUpdates = !persistentSettings.checkForUpdates
            text: qsTr("Check for updates periodically") + translationManager.emptyString
        }

        MoneroComponents.CheckBox {
            checked: persistentSettings.displayWalletNameInTitleBar
            onClicked: persistentSettings.displayWalletNameInTitleBar = !persistentSettings.displayWalletNameInTitleBar
            text: qsTr("Display wallet name in title bar") + translationManager.emptyString
        }

        MoneroComponents.CheckBox {
            id: hideBalanceCheckBox
            checked: persistentSettings.hideBalance
            onClicked: {
                persistentSettings.hideBalance = !persistentSettings.hideBalance
                appWindow.updateBalance();
            }
            text: qsTr("Hide balance") + translationManager.emptyString
        }

        MoneroComponents.CheckBox {
            id: themeCheckbox
            checked: !MoneroComponents.Style.blackTheme
            text: qsTr("Light theme") + translationManager.emptyString
            toggleOnClick: false
            onClicked: {
                MoneroComponents.Style.blackTheme = !MoneroComponents.Style.blackTheme;
            }
        }
        
        MoneroComponents.CheckBox {
            checked: persistentSettings.askPasswordBeforeSending
            text: qsTr("Ask for password before sending a transaction") + translationManager.emptyString
            toggleOnClick: false
            onClicked: {
                if (persistentSettings.askPasswordBeforeSending) {
                    passwordDialog.onAcceptedCallback = function() {
                        if (appWindow.walletPassword === passwordDialog.password){
                            persistentSettings.askPasswordBeforeSending = false;
                        } else {
                            passwordDialog.showError(qsTr("Wrong password"));
                        }
                    }
                    passwordDialog.onRejectedCallback = null;
                    passwordDialog.open()
                } else {
                    persistentSettings.askPasswordBeforeSending = true;
                }
            }
        }

        MoneroComponents.CheckBox {
            checked: persistentSettings.autosave
            onClicked: persistentSettings.autosave = !persistentSettings.autosave
            text: qsTr("Autosave") + translationManager.emptyString
        }

        MoneroComponents.Slider {
            Layout.fillWidth: true
            Layout.leftMargin: 35
            Layout.topMargin: 6
            visible: persistentSettings.autosave
            from: 1
            stepSize: 1
            to: 60
            value: persistentSettings.autosaveMinutes
            text: "%1 %2 %3".arg(qsTr("Every")).arg(value).arg(qsTr("minute(s)")) + translationManager.emptyString
            onMoved: persistentSettings.autosaveMinutes = value
        }

        MoneroComponents.CheckBox {
            id: userInActivityCheckbox
            checked: persistentSettings.lockOnUserInActivity
            onClicked: persistentSettings.lockOnUserInActivity = !persistentSettings.lockOnUserInActivity
            text: qsTr("Lock wallet on inactivity") + translationManager.emptyString
        }

        MoneroComponents.Slider {
            visible: userInActivityCheckbox.checked
            Layout.fillWidth: true
            Layout.topMargin: 6
            Layout.leftMargin: 35
            from: 1
            stepSize: 1
            to: 60
            value: persistentSettings.lockOnUserInActivityInterval
            text: {
                var minutes = value > 1 ? qsTr("minutes") : qsTr("minute");
                return qsTr("After ") + value + " " + minutes + translationManager.emptyString;
            }
            onMoved: persistentSettings.lockOnUserInActivityInterval = value
        }
}

