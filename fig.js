const fsPromises = require("fs/promises")
const {execFile} = require("child_process")
// const fs = require("fs")

// folder struct = {name: str, isDir: bool, files: []files/folders, path: str}
// files struct = {name: str, isDir, path: str}
// tlf = {}

let root = {}

getTopLevel = async (tl) => {
  await fsPromises.readdir("FileShareProgram/send", {withFileTypes: true})
    .then( (files) => {
      //console.log("1st", files)
      for (let i = 0; i < files.length; i++) {
        tl[files[i].name] = {name: files[i].name, isDir: true, files: []}
      }
      //console.log("1st end",f)
    })
}


traverseDirectory = async (path, obj) => {
  await fsPromises.readdir(path, {withFileTypes: true})
    .then(async (files) => {
      for (let i=0; i<files.length; i++) {
        if (files[i].isDirectory() === true) {
          let struct = {name: files[i].name, isDir: true, files: []}
          await traverseDirectory(path+"/"+files[i].name, struct)
          obj.files.push(struct)
          continue
        }
        obj.files.push({name: files[i].name, isDir: false, path: path+"/"+files[i].name})
      }
      console.log("2nd end")
    })
    .catch((err) => {
      console.log(err)
    })
}

let main = async () => {
  let f = {}
  await getTopLevel(f)
  console.log(f)

  for (key in f) {
    await traverseDirectory("FileShareProgram/send/"+f[key].name, f[key])
  }
  console.log(f)

  for (let i=0; i<f["fs"].files.length; i++) {
    console.log(f["fs"].files[i])
  }
}

//main()



let getIP = () => {
  execFile("./fileShare.exe", ["listen"], {cwd: process.cwd()+"/FileShareProgram"},  (err, stdout, stderr) => {
  if (err !== null) {
    console.log("coudln't execute", err)
    return null
  }
  if (stderr === null) {
    console.log("stderr:", stderr)
    return null 
  }
  console.log(stdout.split("\n")[0])
  })
}

const spawn = require("child_process").spawn

let proc = spawn("FileShareProgram/fileShare.exe", ["ip"], {cwd: process.cwd()})
proc.stdout.on('data', (data) => {
  console.log(data.toString("utf-8"))
})

proc.stderr.on("data", (data) => {
  console.log(data)
})

proc.on('error', (code) => {
  console.log(code, "dick")
})


