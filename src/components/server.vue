<template>
  <div>
    <!-- <div id="buttons">
      <button class="tab" @click="display='listen'" :class="display == 'listen' ? 'display' : ''">Listen</button>
      <div style="width: 3px"></div>
      <button class="tab" @click="display='send'" :class="display == 'send' ? 'display' : ''">Send</button>
    </div> -->

    <div v-if="display == 'listen'" class="form">
      <div style="display: flex; justify-content: center">
         <b-alert show v-if="errors.length !== 0" variant="dark"> {{errors}} </b-alert>
      </div>


      <div style="display: flex; justify-content: space-between">
        <!-- <label for="port">port</label> -->
        <p style="color: white; font-size: 150%">Port:</p>
        <div style="margin: 2%"></div>
        <b-form-input :id="'port'" v-model="listenDetails.port"></b-form-input>
      </div>

      <div style="display: flex; justify-content: space-between">
        <!-- <label for="port">port</label> -->
        <p style="color: white; font-size: 150%">Password:</p>
        <div style="margin: 2%"></div>
        <b-form-input :id="'port'" v-model="listenDetails.password" type="password"></b-form-input>
      </div>

      <div style="display: flex; justify-content: space-between">
        <!-- <label for="port">port</label> -->
        <p style="color: white; font-size: 150%">Password:</p>
        <div style="margin: 2%"></div>
        <b-form-input :id="'port'" v-model="listenDetails.p2" type="password"></b-form-input>
      </div>

      <div style="display: flex; justify-content: space-between">
        <!-- <label for="port">port</label> -->
        <p style="color: white; font-size: 150%">Limit(mins):</p>
        <div style="margin: 2%"></div>
        <b-form-input :id="'port'" v-model="listenDetails.timeLimit" type="number"></b-form-input>
      </div>

      <div>
        <p>{{ listening ? 'cunt' : 'gu'}} sdf</p>
        <button v-if="!listening" class="do" @click="listen">Start Listening</button>
        <button v-else-if="listening" class="do" @click="stopListening">Stop Listening</button>
      </div>
    </div>



  </div>
</template>


<script>
const { ipcRenderer } = require("electron")
export default {
  data() {
    return {
      display: "listen",
      sendDetails: {name: "noname", folder: null, port: 8080, password: "nopass", ip: null},
      listenDetails: {port: 8080, password: "nopass", p2: "nopass", timeLimit: 0},
      errors: ""
    }
  },

  computed: {
    listening() {
      return this.$store.state.fileShare.listener.listening;
    }
  },

  methods: {
    listen() {
      //ipcRenderer.send('start-listening')
      console.log("ppp")
      if (this.listenDetails.password !== this.listenDetails.p2) {
        this.errors = "Passwords Do Not Match"
        return
      }
      let port = parseInt(this.listenDetails.port)
      if (Number.isNaN(port) || port > 9999) {
        this.errors = "Port Must Be a Number Less Than 10000"
        return
      }
      this.errors = ""
      this.listenDetails.port = port
      if (!this.listening) {
        ipcRenderer.send('start-listening', this.listenDetails)
      } else {
        console.log("already listening")
      }
    },

    stopListening() {
      ipcRenderer.send('close-listener')
    },

    listenerMsg(code) {

      switch (code) {
        case 205:
          this.$store.dispatch('fileShare/appendLog', {line: `205 -- Server Started on ${this.listenDetails.port}`, type: 'listener'})
          this.$store.dispatch('fileShare/changeListenerState')
          break;
        case 200:
          this.$store.dispatch('fileShare/appendLog', {line: `200 -- Received Files`, type: 'listener'})
          break;
      }
    }
  },

  mounted() {
    ipcRenderer.on('output-listen', (ev,data) => { 
      let code = parseInt(data)
      if (Number.isNaN(code)) {
        //console.warn(ev); // ill fix the no unused vars later
        console.log("couldn't parse", data)
        return
      }
      console.log(code)
      this.listenerMsg(code)
    })

    ipcRenderer.on('listener-closed', (ev, data) => {
      //console.log(ev, data) // delete later
      console.log('kakakakak')
      this.$store.dispatch('fileShare/appendLog', {line: `400 -- Server Stopped on ${this.listenDetails.port}`, type: 'listener'})
      this.$store.dispatch('fileShare/changeListenerState')
    })
  },

  beforeDestroy() {
    ipcRenderer.removeAllListeners('listener-closed')
    ipcRenderer.removeAllListeners('output-listen')
  }
}
</script>

<style>

.tab {
  display: inline-block;
  padding: 8px 16px;
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
  background-color: #2c3e50;
  color: white;
  border: none;
}

.display {
  padding: 8px 16px;
  background-color: #455f79;
  border-top: 2px solid #6a7a8a;
  border-left: 2px solid #6a7a8a;
  border-right: 2px solid #6a7a8a;
}

#buttons {
  display: flex;
  justify-content: center;
  border-bottom: 3px solid #2c3e50;
  
}

.form {
  margin-top: 5%;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-content: center;
  padding: 0 10% 0 10%;
}

.do {
  padding: 10px 10px;
  border-radius: 10px;
  border: none;
  background-color: #2c3e50;
  color: white;
}
</style>