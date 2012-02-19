/******************************************************************************
 * This file is part of the Kanagram project
 * Copyright (C) 2012 Laszlo Papp <lpapp@kde.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0

Page {

    property int settingsPageMargins;

    QueryDialog {
        id: userGuideDialog;
        message: "Kanagram 0.1.1.<br><br>(C) 2012 Laszlo Papp<br>lpapp@kde.org"
    }

    function pushPage(file) {
        var component = Qt.createComponent(file)
        if (component.status == Component.Ready)
            pageStack.push(component);
        else
            console.log("Error loading component:", component.errorString());
    }

    MySelectionDialog {
        id: languageSelectionDialog;
        titleText: i18n("Select a language");
        selectedIndex: 0;

        model: kanagramEngineHelper.languageNames();

        onSelectedIndexChanged: {
            kanagramEngineHelper.dataLanguage = model[selectedIndex];
        }
    }

    Connections {
        target: kanagramEngineHelper;

        onHintHideTimeChanged: {
            hintAppearanceSlider.value = kanagramEngineHelper.hintHideTime;
        }

        onResolveTimeChanged: {
            resolveTimeSlider.value = kanagramEngineHelper.resolveTime;
        }

        onUseSoundsChanged: {
            soundsSwitch.checked = kanagramEngineHelper.useSounds;
        }
    }

    Component.onCompleted: {
        hintAppearanceSlider.value = kanagramEngineHelper.hintHideTime;
        resolveTimeSlider.value = kanagramEngineHelper.resolveTime;
        soundsSwitch.checked = kanagramEngineHelper.useSounds;
    }


    Rectangle {
        id: settingsPageMainRectangle;
        color: "black";
        anchors.fill: parent;

        Flickable {
            anchors {
                fill: parent;
                margins: settingsPageMargins;
            }

            contentWidth: settingsPageMainColumn.width;
            contentHeight: settingsPageMainColumn.height;

            Column {
                id: settingsPageMainColumn;
                width: settingsPageMainRectangle.width - 2*settingsPageMargins;

                spacing: 10;

                Label {
                    width: parent.width;
                    text: i18n("Kanagram Settings");
                    font.pixelSize: 32;
                }

                Image {
                    id: separator1;
                    width: parent.width;
                    height: 2;
                    fillMode: Image.TileHorizontally;
                    source: "separator.png";
                }

                Column {
                    width: parent.width;
                    spacing: 5;

                    Row {
                        Label {
                            id: hintAppearanceLabel;
                            anchors.left: parent.left;
                            text: i18n("Hint appearance in seconds");
                            font.bold: true;
                        }

                        ToolIcon {
                            iconSource: "icon-l-user-guide-main-view.png";

                            anchors {
                                right: parent.right;;
                            }

                            onClicked: {
                                userGuideDialog.open();
                            }
                        }
                    }

                    Slider {
                        id: hintAppearanceSlider;
                        width: parent.width - 10;
                        stepSize: 1;
                        valueIndicatorVisible: true;
                        minimumValue: 0;
                        maximumValue: 10;
                        anchors.horizontalCenter: parent.horizontalCenter;

                        onValueChanged: {
                            kanagramEngineHelper.hintHideTime = value;
                        }
                    }
                }

                Image {
                    id: separator2;
                    width: parent.width;
                    height: 2;
                    fillMode: Image.TileHorizontally;
                    source: "separator.png";
                }

                Column {
                    width: parent.width;
                    spacing: 5;

                    Row {
                        Label {
                            id: resolveTimeLabel;
                            anchors.left: parent.left;
                            text: i18n("Resolve time in seconds");
                            font.bold: true;
                        }

                        ToolIcon {
                            iconSource: "icon-l-user-guide-main-view.png";

                            anchors {
                                right: parent.right;;
                            }

                            onClicked: {
                                userGuideDialog.open();
                            }
                        }
                    }

                    Slider {
                        id: resolveTimeSlider;
                        width: parent.width - 10;
                        stepSize: 15;
                        valueIndicatorVisible: true;
                        minimumValue: 0;
                        maximumValue: 300;
                        anchors.horizontalCenter: parent.horizontalCenter;

                        onValueChanged: {
                            kanagramEngineHelper.resolveTime = value;
                        }
                    }
                }

                Image {
                    id: separator3;
                    width: parent.width;
                    height: 2;
                    fillMode: Image.TileHorizontally;
                    source: "separator.png";
                }

                Item {
                    width: parent.width;
                    height: childrenRect.height;

                    Label {
                        anchors.left: parent.left;
                        text: i18n("Sounds");
                        font.bold: true;
                    }

                    ToolIcon {
                        iconSource: "icon-l-user-guide-main-view.png";

                        anchors {
                            right: soundsSwitch.left;
                        }

                        onClicked: {
                            userGuideDialog.open();
                        }
                    }

                    Switch {
                        id: soundsSwitch;
                        anchors.right: parent.right;

                        onCheckedChanged: {
                            kanagramEngineHelper.useSounds = checked;
                        }
                    }
                }

                Image {
                    id: separator4;
                    width: parent.width;
                    height: 2;
                    fillMode: Image.TileHorizontally;
                    source: "separator.png";
                }

                ListItem {
                    iconSource: "preferences-desktop-locale.png";
                    titleText: i18n("Language");
                    subtitleText: kanagramEngineHelper.dataLanguage ?  kanagramEngineHelper.dataLanguage : "English";
                    iconId: "textinput-combobox-arrow";
                    iconVisible: true;
                    mousePressed: languageSelectionMouseArea.pressed;

                    MouseArea {
                        id: languageSelectionMouseArea;
                        anchors.fill: parent;
                        onClicked: {
                            languageSelectionDialog.open();
                       }
                    }
                }
            }
        }
    }

    tools: commonTools;
}
