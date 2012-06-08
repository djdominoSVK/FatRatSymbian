import QtQuick 1.1
import com.nokia.symbian 1.1


Page {
    property string source
    id: newTransferPage
    orientationLock: PageOrientation.LockPortrait


    function openFile() {
        var component = Qt.createComponent("FileDialog.qml");
        var dialog = component.createObject(newTransferPage);
        if( dialog !== null ) {
            dialog.dirMode = false;
            dialog.fileSelected.connect(fileSelected);
            dialog.open();
        }
    }

    function openLinksFromFile() {
        var component = Qt.createComponent("FileDialog.qml");
        var dialog = component.createObject(newTransferPage);
        if( dialog !== null ) {
            dialog.dirMode = false;
            dialog.fileSelected.connect(linksFromFile);
            dialog.open();
        }
    }

    function openDirectory() {
        var component = Qt.createComponent("FileDialog.qml");
        var dialog = component.createObject(newTransferPage);
        if( dialog !== null ) {
            dialog.dirMode = true;
            dialog.directorySelected.connect(directorySelected);
            dialog.open();
        }
    }

    function fileSelected( filePath ) {
        sourceInput.text = filePath
    }
    function directorySelected( filePath ) {
        destinationTextInput.text = filePath
    }
    function linksFromFile( filePath ) {
        sourceInput.text = newTransfer.getLinksFromFile(filePath)
    }




        Row {
            id: row
            anchors.top: headerLabel.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 5
            spacing: 30
            RadioButton {
                id: radioButton_download
                text: "Download"

                checked: true
                onClicked: if (radioButton_upload.checked){
                               radioButton_upload.checked=false
                               radioButton_download.checked=true
                               newTransferPage.state = "download"
                           }
            }

            RadioButton {
                id: radioButton_upload
                checked: false
                text: "Upload"
                onClicked: if (radioButton_download.checked){
                               radioButton_upload.checked=true
                               radioButton_download.checked=false
                               newTransferPage.state = "upload"
                           }
            }
        }


        Rectangle {
            id: authButton
            height: 40
            width: 40
            anchors.top: row.bottom
            anchors.topMargin: -4
            anchors.right: parent.right
            anchors.rightMargin: 10
            color: "transparent"
            Image {
                anchors.fill: parent
                source:"images/auth.png"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: userAuthDialog.open()
            }

        }

        Label {
            id: sourceText
            anchors.top: row.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 12
            font.pixelSize: 18

        }

        TextArea {
            anchors.top: sourceText.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            height: Math.max (100, implicitHeight)
            id: sourceInput
            font.pixelSize: 18
        }

        Button {
            id: addFilesSingleDialogButton
            anchors.top: sourceInput.bottom
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.topMargin: 5
        }

        Label {
            id: destinationText
            anchors.top: addFilesSingleDialogButton.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 5
            font.pixelSize: 18

            text: "Destination: "
        }
        TextField {
            id: destinationTextInput
            anchors.top: destinationText.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 5
            width: 200
            height: 40
            font.pixelSize: 18
        }

        Button{
            id: browseButton
            width: 120
            anchors.top: destinationText.bottom
            //  anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.topMargin: 5
            text: "Browse"
            onClicked:  openDirectory()
        }

        Label {
            id: transferType
            anchors.top: destinationTextInput.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 14
            height: 40

            text: "Download as: "
            font.pixelSize: 18
        }


        Button {
            id: transferDownloadSingleSelectionDialogButton
            anchors.top: destinationTextInput.bottom
            anchors.topMargin: 5
            anchors.left: transferType.right
            anchors.leftMargin: 5
            text: "Auto detect"
            width: 150
            onClicked: {
                transferDownloadSingleSelectionDialog.open();
            }
        }

        Label {
            id: minSpeed
            anchors.top: transferType.bottom
            anchors.topMargin: 12
            anchors.left: parent.left
            anchors.leftMargin: 10

            text: qsTr("Down speed limit (kB/s): ")
            font.pixelSize: 18
        }

        TextField {
            id: minSpeedInput
            anchors.right: parent.right
            anchors.top: minSpeed.top
            anchors.topMargin: -12
            anchors.rightMargin: 5
            width: 120
            height: 40
            font.pixelSize: 18
        }
        Label {
            id: maxSpeed
            anchors.top: minSpeed.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: qsTr("Up speed limit (kB/s):  ")

            font.pixelSize: 18
        }

        TextField {
            id: maxSpeedInput
            anchors.top: maxSpeed.top
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: 120
            height: 40
            font.pixelSize: 18
        }


        CheckBox{
            id: pauseCheckBox
            text: "Paused"
            anchors.top: maxSpeed.bottom
            anchors.topMargin: 4
            anchors.left: parent.left
            anchors.leftMargin: 10
            checked: false
        }


        UserAuthDialog{
            id: userAuthDialog
        }


        SelectionDialog {
            id: addFilesSingleSelectionDialog
            titleText: "Add Special"
            selectedIndex: -1
            model: ListModel {
                ListElement { name: "Add local files.."}
                ListElement { name: "Add contents of text file" }
            }
            onSelectedIndexChanged: {
                addFilesSingleSelectionDialog.close()
                if(selectedIndex==0){
                    //sourceInput.text = newTransfer.browse2;
                    test=newTransfer.browse2
                }
                if(selectedIndex==1){
                    //sourceInput.text = newTransfer.browse2;
                    test=newTransfer.addTextFile
                    sourceInput.text = test
                }
                selectedIndex= -1;

            }
        }
        SelectionDialog {
            id: transferDownloadSingleSelectionDialog
            titleText: "Download as:"
            selectedIndex: -1
            model: ListModel {
                ListElement { name: "Auto detect"}
                ListElement { name: "HTTP(S)/FTP download" }
            }
            onSelectedIndexChanged: {
                transferDownloadSingleSelectionDialogButton.text =
                        transferDownloadSingleSelectionDialog.model.get(transferDownloadSingleSelectionDialog.selectedIndex).name
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
                text: "New transfer"
            }
        }




    tools: ToolBarLayout {
        id: pageSpecificTools
        ToolButton {
            anchors.right: parent.right
            anchors.rightMargin: 5;
            iconSource:  "toolbar-back"
            onClicked: appWindow.pageStack.pop();
        }
        ToolButton{
            anchors.left: parent.left
            anchors.leftMargin: 5;
            text: "Add to queue"
            onClicked: if (sourceInput.text!== "") {
                           newTransfer.createTransfer(sourceInput.text,
                                                      radioButton_download.checked,
                                                      -1,
                                                      destinationTextInput.text,
                                                      (parseInt(minSpeedInput.text)*1024),
                                                      (parseInt(maxSpeedInput.text)*1024),
                                                      pauseCheckBox.checked)
                           appWindow.pageStack.pop()
                       }
        }
    }
    states: [
        State {
            name: "download"
            PropertyChanges {target: sourceText; text:"Files to download: " }
            PropertyChanges {target: addFilesSingleDialogButton ; text:"Add links from text file"; onClicked: {
                    openLinksFromFile()}}
            PropertyChanges {target: transferDownloadSingleSelectionDialogButton; visible: true }
            PropertyChanges {target: transferDownloadSingleSelectionDialog; visible: true }
            PropertyChanges {target: transferType; visible: true }
            PropertyChanges {target: destinationTextInput; text: "/home/user/MyDocs/Downloads"}
            PropertyChanges {target: browseButton; visible: true }
        },
        State {
            name: "upload"
            PropertyChanges {target: destinationTextInput; text: ""; width:newTransferPage.width - 20 }
            PropertyChanges {target: sourceText; text:"Files to upload: " }
            PropertyChanges {target: addFilesSingleDialogButton; text:"Add files to upload "; onClicked: {
                    openFile()}}
            PropertyChanges {target: transferType; visible: false }
            PropertyChanges {target: transferDownloadSingleSelectionDialogButton; visible: false }
            PropertyChanges {target: transferDownloadSingleSelectionDialog; visible: false }
            PropertyChanges {target: browseButton; visible: false }
        }



    ]
}
