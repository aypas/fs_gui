import Vue from "vue"
import Vuex from "vuex"
import { files } from "./modules/files.js"
import { fileShare } from "./modules/fileShare.js"
import { editor } from "./modules/editor.js"
import { createPersistedState, createSharedMutations } from "vuex-electron"

Vue.use(Vuex)

// plugin createSharedMutations makes it such that actions do not return promises to renderer components.
// you can only use returned promises in main thread or within the action definition.

// also, with createSharedMutations, you cannot call mutations in renderer components.

export default new Vuex.Store({
  plugins: [
    createPersistedState(),
    createSharedMutations()
  ],
  modules: {
    files: files,
    fileShare: fileShare,
    editor: editor
  }
});