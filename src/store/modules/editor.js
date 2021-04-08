const fs = require("fs");

const state = {
  fileDetails: null,
  fileData: null
}

const mutations = {

  open(state) {
    // must be called after fileDetails
    fs.readFile(state.fileDetails.path, {encoding: 'utf-8'}, (err, data) => {
      if (err !== null) {
        console.log(err, "couldnt read file");
        return null;
      }
      state.fileData = data; 
    })
  },

  save(state, data) {
    fs.writeFile(state.fileDetails.path, data, {encoding: 'utf-8'}, (err) => {
      console.log(err, "callback")
      if (err !== null) {
        console.log("couldnt save", err);
      }
    })
    console.log("ran saved")
  },

  fileDetails(state, fileDetails) {
    console.log("pp")
    state.fileDetails = fileDetails;
  }
}

const actions = {
  open(store) {
    store.commit('open');
  },

  save(store, data) {
    console.log("saved!")
    store.commit('save', data);
  },

  addFileDetails(context, data) {
    // data is an object containing fileDetails
    console.log(context)
    context.commit('fileDetails', data)
    context.dispatch('open').then(() => {console.log("pooppppp")})
  },

  fuckingPrint(store) {
    console.log("priiiint")
    return Promise.resolve(10)
  }
}


export const editor = {
  namespaced: true,
  state,
  mutations,
  actions
}