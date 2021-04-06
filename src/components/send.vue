<template>
    <div class="form">
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
      msg:"pp",
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
      ipcRenderer.send('send', this.args)
    }
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