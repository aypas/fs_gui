import Vue from "vue"
import Vuex from "vuex"
import { files } from "./modules/files.js"
import { fileShare } from "./modules/fileShare.js"
import { createPersistedState, createSharedMutations } from "vuex-electron"

Vue.use(Vuex)

export default new Vuex.Store({
  plugins: [
    createPersistedState(),
    createSharedMutations()
  ],

  modules: {
    files: files,
    fileShare: fileShare
  }
})