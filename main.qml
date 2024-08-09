import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 700





    title: qsTr("Business Inventory Management System")
    color: style.backgroundColor

    // Global styles
    QtObject {
        id: style
        property color primaryColor: "#007bff"
        property color secondaryColor: "#6c757d"
        property color accentColor: "#28a745"
        property color backgroundColor: "#f8f9fa"
        property color textColor: "#212529"
        property int defaultMargin: 10
        property int defaultFontSize: 14
        property int headerFontSize: 20
    }

    FontLoader { id: robotoFont; source: "qrc:/fonts/Roboto-Regular.ttf" }

    header: ToolBar {
        background: Rectangle {
            color: style.primaryColor
        }

        RowLayout {
            anchors.fill: parent
            spacing: style.defaultMargin

            Image {
                source: "qrc:/images/logo.png"
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                Layout.leftMargin: style.defaultMargin
            }

            Label {
                text: "BIMS"
                font.family: robotoFont.name
                font.pixelSize: style.headerFontSize
                font.bold: true
                color: "white"
            }

            Item { Layout.fillWidth: true }

            ToolButton {
                icon.source: "qrc:/images/settings.png"
                icon.color: "white"
                onClicked: settingsDialog.open()
            }

            ToolButton {
                icon.source: "qrc:/images/user.png"
                icon.color: "white"
                onClicked: userMenu.open()

                Menu {
                    id: userMenu
                    y: parent.height

                    MenuItem {
                        text: qsTr("Profile")
                        onTriggered: profileDialog.open()
                    }
                    MenuItem {
                        text: qsTr("Logout")
                        onTriggered: logoutConfirmDialog.open()
                    }
                }
            }
        }
    }

    TabBar {
        id: tabBar
        width: parent.width
        background: Rectangle {
            color: Qt.lighter(style.primaryColor, 1.5)
        }

        TabButton {
            text: qsTr("Dashboard")
            font.family: robotoFont.name
            font.pixelSize: style.defaultFontSize
        }
        TabButton {
            text: qsTr("Inventory")
            font.family: robotoFont.name
            font.pixelSize: style.defaultFontSize
        }
        TabButton {
            text: qsTr("Sales")
            font.family: robotoFont.name
            font.pixelSize: style.defaultFontSize
        }
        TabButton {
            text: qsTr("Reports")
            font.family: robotoFont.name
            font.pixelSize: style.defaultFontSize
        }
    }

    StackLayout {
        anchors.top: tabBar.bottom
        anchors.bottom: statusBar.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: style.defaultMargin
        currentIndex: tabBar.currentIndex


    }

    // footer: StatusBar {
    //     id: statusBar
    //     background: Rectangle {
    //         color: style.secondaryColor
    //     }

        RowLayout {
            anchors.fill: parent
            Label {
                text: qsTr("Connected to database")
                color: "white"
                font.family: robotoFont.name
                font.pixelSize: style.defaultFontSize - 2
            }
            Item { Layout.fillWidth: true }
            Label {
                text: Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
                color: "white"
                font.family: robotoFont.name
                font.pixelSize: style.defaultFontSize - 2
            }
        }
    }

//     Dialog {
//         id: settingsDialog
//         title: qsTr("Settings")
//         standardButtons: Dialog.Ok | Dialog.Cancel

//         ColumnLayout {
//             spacing: style.defaultMargin

//             CheckBox {
//                 text: qsTr("Dark Mode")
//                 onCheckedChanged: {
//                     // Implement dark mode logic
//                 }
//             }

//             ComboBox {
//                 model: ["English", "Spanish", "French"]
//                 Layout.fillWidth: true
//                 onCurrentIndexChanged: {
//                     // Implement language change logic
//                 }
//             }
//         }
//     }

//     Dialog {
//         id: profileDialog
//         title: qsTr("User Profile")
//         standardButtons: Dialog.Close

//         ColumnLayout {
//             spacing: style.defaultMargin

//             Label {
//                 text: qsTr("Username: Admin")
//                 font.bold: true
//             }

//             Label {
//                 text: qsTr("Role: Administrator")
//             }

//             Button {
//                 text: qsTr("Change Password")
//                 onClicked: {
//                         Dialog {
//     ?
// }

//                     // Implement change password logic
//                 }
//             }
//         }
//     }

//     Dialog {
//         id: logoutConfirmDialog
//         title: qsTr("Confirm Logout")
//         standardButtons: Dialog.Yes | Dialog.No

//         Label {
//             text: qsTr("Are you sure you want to logout?")
//         }

//         onAccepted: {
//             // Implement logout logic
//         }
//     }

//     Timer {
//         interval: 1000
//         running: true
//         repeat: true
//         onTriggered: {
//             var currentTime = new Date()
//             statusBar.children[0].children[2].text = Qt.formatDateTime(currentTime, "yyyy-MM-dd hh:mm:ss")
//         }
//     }

//     Component.onCompleted: {
//         // Set custom font for the entire application
//         font.family = robotoFont.name
//     }
// }
