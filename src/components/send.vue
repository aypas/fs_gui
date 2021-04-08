<template>
  <div class="form">
    <b-alert show v-if="errors.length !== 0" variant="dark"> 
      {{errors}} 
      <b-btn @click="errors = ''">Got It</b-btn> 
    </b-alert>
    <b-alert show v-if="message.length !== 0" variant="dark"> 
      {{message}}
      <b-btn size="sm" @click="message = ''">Got It</b-btn> 
    </b-alert>
    <div style="display: flex;">
      <p style="color: white; font-size: 150%">To:</p>
      <div style="margin: 2%"></div>
      <b-form-input v-model="args.ip" type="text"></b-form-input>
    </div>

    <div style="display: flex;">
      <p style="color: white; font-size: 150%">Port:</p>
      <div style="margin: 2%"></div>
      <b-form-input v-model="args.port" type="number"></b-form-input>
    </div>


    <div style="display: flex;">
      <p style="color: white; font-size: 150%">Folder:</p>
      <div style="margin: 2%"></div>
      <b-form-select v-model="args.folder" :options="Object.keys(folders)" size="sm" class="mt-1"></b-form-select>
    </div>
    <div style="display: flex;">
      <p style="color: white; font-size: 150%">Password:</p>
      <div style="margin: 2%"></div>
      <b-form-input v-model="args.password" type="password"></b-form-input>
    </div>

    <div>
      <button class="do" @click="send">Send</button>
    </div>
  </div>
</template>

<script>
import { ipcRenderer } from 'electron'
export default {
  data() {
    return {
      errors:"",
      message: "",
      args: {port: 8080, ip: null, folder: '', password: "nopass"}
    }
  },

  computed: {
    folders() {
      return this.$store.state.files.topLevelFolders["send"]
    }
  },

  methods: {
    send() {
      // verify
      console.log("v")
      if (this.args.ip === null) {
        this.errors = "Must enter a valid IP";
        return null;
      }
      if (!this.validateIP()) {
        this.errors = "IP must have four numbers seperated by periods between 0 and 255";
        return null;
      }
      if(this.args.port > 40001) {
        this.errors = "Port must be between 1 and 400000";
        return null;
      }
      if (this.args.folder == '') {
        this.errors = "Must select a folder";
        return null;
      }
      this.errors = "";
      ipcRenderer.send('send', this.args);
    },

    validateIP() {
      console.log("validating ip")
      let ips = this.args.ip.split(".");
      if (ips.length !== 4) {
        return false;
      }
      for (let i = 0; i < ips.length; i++) {
        let num = parseInt(ips[i]);
        if (num < 0 || num > 255) {
          return false;
        }
      }
      return true;
    },

    msgParse(msg) {
      let num = parseInt(msg);
      switch (num) {
        case 200:
          this.message = "Folders Sent!";
          break;
        case 400:
          this.message = "Message Not Received(unspecified reason).";
          break;
        case 401:
          this.message = "File not found in send folder.";
          break;
        case 402:
          this.message = "Incorrect password.";
          break;
        case 403:
          this.message = "Unknown encryption error. You and your intended recipient might be using incompatible version of fileShare.";
          break;
        case 490:
          this.message = "Error on preparing folder data. Try again.";
          break;
        case 499:
          this.message = "Connection refused. Your intended recipient is not listening for incoming messages.";
          break;
      }
    }
  },

  mounted() {
    ipcRenderer.on('output-listen-sender', (ev, data) => {
      console.log(data);
      this.msgParse(data);
    })
  },

  beforeDestroy() {
    ipcRenderer.removeAllListeners('output-listen-sender')
  }
}

// ip, port, folder
</script>

<style>
.form {
  margin-top: 5%;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-content: center;
  padding: 0 10% 0 10%;
}

</style>