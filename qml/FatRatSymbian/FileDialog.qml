// source https://gitorious.org/kunaltest/kunaltest/blobs/master/filedialog/

import QtQuick 1.1
import com.nokia.symbian 1.1

Dialog {
  id: filedialog
  property int screenWidth: (screen.rotation === 0 || screen.rotation === 180 ? screen.displayWidth : screen.displayHeight) - 32
  property int screenHeight: (screen.rotation === 0 || screen.rotation === 180 ? screen.displayHeight : screen.displayWidth) - 32
  property bool dirMode :false;

  signal fileSelected(variant filePath);
  signal directorySelected(variant dirPath);

  title: Item {
    id: titlebar
    x: 16 - platformStyle.leftMargin
    height: 50
    width: screenWidth
    Label {
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      font.capitalization: Font.MixedCase
      font.pixelSize: platformStyle.fontSizeLarge
      color: "white"
      text:  dirMode ? " Choose Directory" : " Choose File" ;
    }
    Image {
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
      source: "images/icon-m-common-dialog-close.png"
      MouseArea {
        anchors.fill: parent
        onClicked:  { filedialog.reject(); }
      }
    }
  }

  content: [
    Column {
      //anchors.topMargin: 20
      x: titlebar.x + 8
      width: screenWidth
      height: screenHeight - 125
      spacing: 5

      Item{
          width:parent.width; height:5;
      }


      Row {
          height:upButton.height
          width: parent.width
          Button {
            id: upButton
            text: 'Up'
            width: 70
            height: parent.height
            enabled: fileModel.canGoUp
            onClicked: fileModel.goUp()
          }
          Button {
            id: dirButton
            text: fileModel.directory;
            width: parent.width - upButton.width
            height: parent.height
            onClicked: {
                if( dirMode ) {
                    console.log("Directory selected: " + fileModel.currentDirectory() );
                    filedialog.directorySelected(fileModel.currentDirectory());
                    filedialog.accept();
                }
            }
          }
      }

      Item {
          width: parent.width
          height: screenHeight - 220

          ListView {
            id: entries
            model: fileModel
            clip: true
            width:parent.width; height:parent.height

            delegate: ListItem {
                     id:container
                     height: 50
                     subItemIndicator: true

                     Row {
                         spacing:8
                         Image {
                             id:fileIcon
                             source: icon ? "images/folder.svg" :"images/file.svg"
                         }

                         ListItemText {
                             mode: container.mode
                             role: "Title"
                             clip: true
                             wrapMode: Text.NoWrap
                             anchors.verticalCenter: parent.verticalCenter
                             id: mainText
                             text: caption
                             width: container.width - fileIcon.width - 25
                         }
                     }

                     onClicked: {
                         var isDir = fileModel.isDir(index);

                         if( isDir) {
                             fileModel.openDirectory(index);
                         } else {
                             if ( dirMode == false ) {
                                 console.log("File Selected:" + fileModel.currentDirectory() + '/' + caption);
                                 filedialog.fileSelected(fileModel.currentDirectory() + '/' + caption);
                                 filedialog.accept();
                             }
                         }
                     }
                }
            }

          Item {
              id:emptyList
              width:parent.width;height:parent.height
              visible: false
              Connections {
                target: fileModel;
                onShowEmptyDir:{
                    console.debug("Empty list visible:"+ show);
                    emptyList.visible = show;
                }
              }

              Label{
                  anchors.centerIn: parent
                  color:"white"
                  text:"<h2>No files or folder</h2>"
              }
          }
      }
    }
  ]
  onAccepted: { filedialog.destroy() }
  onRejected: { filedialog.destroy() }
}
