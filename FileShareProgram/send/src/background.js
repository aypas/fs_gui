'use strict'

import installExtension, { VUEJS_DEVTOOLS } from 'electron-devtools-installer'
import { app, protocol, BrowserWindow, Menu, ipcMain } from 'electron'
import { createProtocol } from 'vue-cli-plugin-electron-builder/lib'
import { menuItems } from './menuItems.js'
import { spawn } from 'child_process'
import store from "./store/store.js"
import './store/store.js'

const isDevelopment = process.env.NODE_ENV !== 'production'

// Scheme must be registered before the app is ready
protocol.registerSchemesAsPrivileged([
  { scheme: 'app', privileges: { secure: true, standard: true } }
])

async function createWindow() {
  // Create the browser window.
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      
      // Use pluginOptions.nodeIntegration, leave this alone
      // See nklayman.github.io/vue-cli-plugin-electron-builder/guide/security.html#node-integration for more info
      nodeIntegration: process.env.ELECTRON_NODE_INTEGRATION,

      enableRemoteModule: true
    }
  })

  if (process.env.WEBPACK_DEV_SERVER_URL) {
    // Load the url of the dev server if in development mode
    await win.loadURL(process.env.WEBPACK_DEV_SERVER_URL)
    if (!process.env.IS_TEST) win.webContents.openDevTools()
  } else {
    createProtocol('app')
    // Load the index.html when not in development
    win.loadURL('app://./index.html')
  }
  Menu.setApplicationMenu(menuItems)
  //dialog.showOpenDialog({ properties: ['openFile', 'multiSelections'] })
}

// Quit when all windows are closed.
app.on('window-all-closed', () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (BrowserWindow.getAllWindows().length === 0) createWindow()
})

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', async () => {
  if (isDevelopment && !process.env.IS_TEST) {
    // Install Vue Devtools
    try {
      await installExtension(VUEJS_DEVTOOLS)
    } catch (e) {
      console.error('Vue Devtools failed to install:', e.toString())
    }
  }
  createWindow()
})

// Exit cleanly on request from parent process in development mode.
if (isDevelopment) {
  if (process.platform === 'win32') {
    process.on('message', (data) => {
      if (data === 'graceful-exit') {
        app.quit()
      }
    })
  } else {
    process.on('SIGTERM', () => {
      app.quit()
    })
  }
}


// events

// start listening
ipcMain.on('start-listening', (event, args) => {
  // really weird behavior: port is available when app starts but fileShare is not listening before this process starts.
  // hence, when a client sends a file to a machine that's not listening, the client believes the data's been sent
  // the only real solution to this is if I make the listener send back a code confirming the reception
  // on end of message...


  console.log(process.cwd(), event, args)
  let exe;
  if (process.platform.includes("win")) {
    exe = "fileShare.exe";
  } else {
    exe = "fileShare";
  }
  console.log(args, args.port, exe, typeof args)
  // --port argument has been fixed. omit the address from port after next fileShare commit.
  let proc = spawn(`${exe}`, 
                  [`--port=127.0.0.1:${args.port}`, `--key=${args.password}`, '--details=false', `listen`], 
                  {cwd: process.cwd()+"/FileShareProgram"})
  
  proc.stdout.on('data', (data) => {
    event.reply('output-listen', data.toString("utf-8"))
    console.log(data.toString('utf-8'))
  })

  ipcMain.once('close-listener', (event, data) => {
    console.log("killing")
    let f = proc.kill('SIGKILL');
    console.log(f)
    event.reply("listener-closed");
  })

  // proc.once('listener-closed') ... 
  // listen for the process closing (this is one you'd have to mutate on your own) and make sure close-listener doesnt trigger it
})


ipcMain.on('directory-right-click', (event, data) => {
  console.log(data)
  const template = [
    {
      label: 'Delete',
      click: () => { event.sender.send('context-menu-command', 'menu-item-1') }
    },
    { label: 'Menu Item 2', type: 'checkbox', checked: true }
  ]
  const menu = Menu.buildFromTemplate(template)
  menu.popup(BrowserWindow.fromWebContents(event.sender))
})