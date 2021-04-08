const fsPromises = require("fs").promises

// recursive
const traverseDirectory = async (path, obj) => {
  await fsPromises.readdir(path, {withFileTypes: true})
    .then(async (files) => {
      for (let i=0; i<files.length; i++) {
        if (files[i].isDirectory() === true) {
          if (files[i].name === "." || files[i].name === "..") {
            continue
          }
          let struct = {name: files[i].name, isDir: true, hidden: true, path: path+"/"+files[i].name, files: []}
          await traverseDirectory(path+"/"+files[i].name, struct)
          if (typeof obj.files !== "object") {
            console.log("REEEE", obj)
          }
          obj.files.push(struct)
          continue
        }
        obj.files.push({name: files[i].name, isDir: false, path: path+"/"+files[i].name})
      }
    })
    .catch((err) => {
      console.log("couldn't read file... major error", err)
    })
}


// folder struct = {name: str, isDir: bool, files: []files/folders, path: str}
// files struct = {name: str, isDir, path: str}
const initialState = {
  // topLevelFolders will contain all.
  // it is an object. key will be name of top level folders.
  // each value will be an object containing 
  // {path: str, isDir: bool, files: [array of objects where dirs and files are distinguised by isDir attribute]}
  topLevelFolders: {},
}


const actions = {
  // get top level folders
  async topLevelFolders(store, folderName) {
    const tl = {}
    await fsPromises.readdir("FileShareProgram/"+folderName, {withFileTypes: true})
      .then( (files) => {
        
        for (let i = 0; i < files.length; i++) {
          tl[files[i].name] = {name: files[i].name, isDir: true, hidden: true, files: []}
        }
        console.log("1st", tl)
        store.commit("commitTopLevel", {key:folderName, folders:tl})
    })
  },

  async traverseDirectoryWrapper(store, folderName) {
    store.state.topLevelFolders[folderName]
    for (let key in store.state.topLevelFolders[folderName]) {
      console.log(key)
      await traverseDirectory(`FileShareProgram/${folderName}/${key}`, store.state.topLevelFolders[folderName][key])
    }
    //console.log("idd", store.state.topLevelFolders[folderName])
    console.log("psodf")
    store.commit("commitTopLevel", {key: folderName, folders: store.state.topLevelFolders[folderName]})
  }
}


const mutations = {
  clearState(state) {
    console.log("hole")
    Object.keys(initialState).forEach((key) => { 
      state[key] = initialState[key]
    })
  },

  commitTopLevel(state, {key, folders}) {
    console.log("in here f",key)
    //console.log(key, folders)
    console.log("tried")
    state.topLevelFolders[key] = folders
    console.log("tried and true h")
    //console.log("ppb",state.topLevelFolders.send.assignment1.name)
  }
}

export const files = {
  namespaced: true,
  state: initialState,
  mutations,
  actions
}