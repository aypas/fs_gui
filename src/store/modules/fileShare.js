const emptyState = {
  listener: {
    log: [],
    listening: false
  },

  sender: {
    log: []
  }
}

const actions = {
  appendLog(store, {line, type}) {
    store.commit('appendLog', {line, type});
  },

  changeListenerState(store) {
    store.commit('changeListenerState');
  },

  clearAll(store) {
    store.commit('clearAll');
  }
}

const mutations = {
  clearAll(state) {
    console.log('aaa')
    Object.keys(emptyState).forEach((el) => { state[el] = emptyState[el]});
  },

  appendLog(state, {line, type}) {
    state[type].log.push(line);
  },

  changeListenerState(state) {
    console.log("changing...")
    state.listener.listening = !state.listener.listening;
  }
}

export const fileShare = {
  namespaced: true,
  state: emptyState,
  actions,
  mutations
}