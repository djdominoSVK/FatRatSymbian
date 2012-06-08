import QtQuick 1.0
import com.nokia.symbian 1.1


Page {

    id: proxyPage
    orientationLock: PageOrientation.LockPortrait
    state: settingsMethods.isProxyEnabled() ? "enabled" : "disabled"
    CheckBox{
        id: enabledCheckBox
        anchors.top: headerLabel.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 20
        checked: settingsMethods.isProxyEnabled()
        onClicked: {
            if(checked){
                parent.state= "enabled"
            }
            else{
                parent.state= "disabled"
            }
        }
    }
    Label {
        id : checkBoxLabel
        anchors.top: headerLabel.bottom
        anchors.left: enabledCheckBox.right
        anchors.leftMargin: 10
        anchors.topMargin: 27
        text:  "Enable proxy"
        font.pixelSize: 18
        color: "white"
    }

    Item {
        id: proxyField
        anchors.fill: parent
     Text {
         id: nameText
         anchors.top: parent.top
         anchors.left: parent.left
         anchors.leftMargin: 10
         anchors.topMargin: 150
         font.pixelSize: 18
         text: "Proxy name: "
         color: "white"

     }
     TextField {
         id: nameTextEdit
         anchors.bottom: ipTextEdit.top
         anchors.right: parent.right
         anchors.rightMargin: 35
         anchors.bottomMargin: 10
         text: settingsMethods.getProxyName()
         width: 170
     }
     Text {
         id: ipText
         anchors.top: nameText.bottom
         anchors.left: parent.left
         anchors.leftMargin: 10
         anchors.topMargin: 28
         font.pixelSize: 18
         text: "Proxy IP: "
         color: "white"
     }
     TextField {
         id: ipTextEdit
         anchors.top: nameText.bottom
         anchors.right: parent.right
         anchors.rightMargin: 35
         anchors.topMargin: 20
         text: settingsMethods.getIp()
         width: 170
     }
     Text {
         id: portText
         anchors.top: ipText.bottom
         anchors.left: parent.left
         anchors.leftMargin: 10
         anchors.topMargin: 28
         font.pixelSize: 18
         text: "Proxy port: "
         color: "white"
     }
     TextField {
         id: portTextEdit
         anchors.top: ipText.bottom
         anchors.right: parent.right
         anchors.rightMargin: 35
         anchors.topMargin: 20
         text: (settingsMethods.getPort() === "") ? "80" : settingsMethods.getPort()
         width: 170
     }
     Text {
         id: userText
         anchors.top: portText.bottom
         anchors.left: parent.left
         anchors.leftMargin: 10
         anchors.topMargin: 28
         font.pixelSize: 18
         text: "Proxy user: "
         color: "white"
     }
     TextField {
         id: userTextEdit
         anchors.top: portText.bottom
         anchors.right: parent.right
         anchors.rightMargin: 35
         anchors.topMargin: 20
         text: settingsMethods.getUser()
         width: 170
     }
     Text {
         id: passwordText
         anchors.top: userText.bottom
         anchors.left: parent.left
         anchors.leftMargin: 10
         anchors.topMargin: 28
         font.pixelSize: 18
         text: "Proxy password: "
         color: "white"
     }
     TextField {
         id: passwordTextEdit
         anchors.top: userText.bottom
         anchors.right: parent.right
         anchors.rightMargin: 35
         anchors.topMargin: 20
         echoMode: TextInput.Password
         text: settingsMethods.getPassword()
         width: 170
     }

     CheckBox{
         id: passCheckBox
         anchors.top: passwordTextEdit.bottom
         anchors.left: parent.left
         anchors.leftMargin: 10
         anchors.topMargin: 28
         checked: false
         onClicked: {
             if(checked){
                 passwordTextEdit.echoMode = TextInput.Normal
             }
             else{
                 passwordTextEdit.echoMode = TextInput.Password
             }
         }
     }
     Label {
         id : passCheckBoxLabel
         anchors.left: passCheckBox.right
         anchors.margins: 10
         anchors.top: passwordTextEdit.bottom
         anchors.topMargin: 35
         text:  "Visible password"
         font.pixelSize: 18
     }


    Text {
        id: proxyType
        anchors.top: passCheckBox.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.topMargin: 20
        font.pixelSize: 18
        text: "Proxy type: "
        color: "white"

    }


    Button {
        id: proxyTypeSingleSelectionDialogButton
        anchors.top: passCheckBox.bottom
        anchors.topMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 25
        text: (ett.getType() === 0) ? "HTTP" : "SOCKS 5"
        width: 150
        onClicked: {
            proxyTypeSingleSelectionDialog.open();
        }
    }
}


    SelectionDialog {
        id: proxyTypeSingleSelectionDialog
        titleText: "Download as:"
        selectedIndex: settingsMethods.getType()
        model: ListModel {
            ListElement { name: "HTTP"}
            ListElement { name: "SOCKS 5" }
        }
        onSelectedIndexChanged: {
            proxyTypeSingleSelectionDialogButton.text =
                    proxyTypeSingleSelectionDialog.model.get(proxyTypeSingleSelectionDialog.selectedIndex).name
        }

    }


    tools: ToolBarLayout {
        id: pageSpecificTools
        ToolButton {
            anchors.right: parent.right
            anchors.rightMargin: 5;
            iconSource: "toolbar-back"
            onClicked: appWindow.pageStack.pop();
        }
        ToolButton{
            anchors.left: parent.left
            anchors.leftMargin: 5;
            text: "Save"
            onClicked: { settingsMethods.saveProxy(proxyTypeSingleSelectionDialog.selectedIndex,nameTextEdit.text,
                                                 ipTextEdit.text,portTextEdit.text,userTextEdit.text,passwordTextEdit.text,
                                                 enabledCheckBox.checked)
                         appWindow.pageStack.pop()
                       }
        }
    }

    Rectangle {
        id: headerLabel
        width: parent ? parent.width : 480;
        height: 80
        color: "#4D4D4D"
        Image {
            id: icon
            width: 80

            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
                margins: 3
            }

            smooth: true
            source: "images/FatRatMobile80.png"
            fillMode: Image.PreserveAspectFit
        }
        Text {
            id:title
            anchors {
                left: icon.right
                verticalCenter: parent.verticalCenter
                leftMargin: 0
            }
            color: "white"
            elide: Text.ElideRight

            font.pixelSize: 26
            text: "Proxy server"
        }
    }

    states: [
        State {name: "disabled"
            PropertyChanges {target: proxyField; visible: false }
        },
        State {name: "enabled"
            PropertyChanges {target: proxyField; visible: true }
        }

    ]

}
