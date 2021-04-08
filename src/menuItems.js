import { Menu, dialog } from "electron";
import { exec } from "child_process";
import store from "./store/store.js";
import fs from "fs";



let readDir =  " FileShareProgram/send";
let commandMove;
let commandCopy
if (process.platform.includes("win")) {
  commandMove = "move ";
  commandCopy = "copy -r ";
} else {
  commandMove = "mv ";
  commandCopy = "cp -r ";
}

const fileToRead = (command, str) => {
  console.log(command, str, readDir, process.platform)
  exec(command + str + readDir, (err, stderr, stdout) => {
    if (err !== null || stderr.length !== 0) {
      console.log(err, stderr,"noooo")
    } else {
      console.log(stdout)
    }
  })
}


function selectFile(command) {
  return async () => {
    let folders = await dialog.showOpenDialog({"properties": ["openFile", "multiSelections", "openDirectory"]})
    console.log(folders)
    for (let i = 0; i < folders.filePaths.length; i++) {
      fileToRead(command, folders.filePaths[i])
    }
  }
}

function refreshFolder(type) {
  return () => {
    store.dispatch("files/topLevelFolders", type)
      .then(() => {
        console.log("adfojsdfoijdsfosdjf")
        store.dispatch("files/traverseDirectoryWrapper", type)
          .then(() => {console.log("anus")})
          .catch((err) => {
            console.log(err, "dis better be it")
          })
      })
      .catch((err) => {
        console.log("should never happen", err)
      })
  }
}

const items = [
  {
    label: "fileShare",
    submenu: [
      {label: "Move Folder to Send", click: selectFile(commandMove)},
      {label: "Copy Folder to Send", click: selectFile(commandCopy)},
      {label: "Refresh Send", click: refreshFolder("send")},
      {label: "Refresh Receive", click: refreshFolder("receive")},
      {role: "quit"}
    ]
  }
]

export const appMenuItems = Menu.buildFromTemplate(items)

const deleteFolder = (data) => {
  // path should include file name
  console.log("oo", data)
  if (data.topLevel === true) {
    fs.rmdir(`FileShareProgram/${data.folder}/${data.value.name}`, {recursive: true}, (err) => {
      if (err !== null) {
        console.log("didnt work", err)
        return null
      }
      refreshFolder(data.folder)()
    })
    return null
  } else {
    if (data.value.isDir) {
      fs.rmdir(data.value.path, {recursive: true}, (err) => {
        if (err !== null) {
          console.log(err, "failed on child dir")
          return null
        }
        refreshFolder(data.folder)()
      })
    } else {
      fs.rm(data.value.path, (err) => {
        if (err !== null) {
          console.log('didnt work child file', err);
        }
        refreshFolder(data.folder)();
      })
    }
  }
}

export const rightClickDirectoryMenu = (data) => {
  const template = [
    {
      label: 'Delete',
      click: () => { deleteFolder(data) }
    },

    {
      label: 'Refresh Send',
      click: refreshFolder("send")
    },

    {
      label: 'Refresh Receive',
      click: refreshFolder('receive')
    }
  ]
  return Menu.buildFromTemplate(template)
}