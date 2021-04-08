<template>
  <div>
    <div id="info">  
      <h3>Information</h3>
      <p>Public IP: {{ip == null ? "x" : ip["Wi-Fi"][1].address}}</p>
      <p>Local IP(loopback): 127.0.0.1</p>
      <p>Current Receive Password: {{receivePassword}} </p>
      <p>fileShare version: 1.0</p>
    </div>
    <p><b-btn variant="dark">Open Receive Logs</b-btn></p>
    <b-btn variant="dark">Open Send Logs</b-btn>
  </div>
</template>

<script>
import { networkInterfaces } from "os"
export default {
  data() {
    return {
      ip: null
    }
  },
  mounted() {
    this.ip = networkInterfaces()
  },
  props: {
    receivePassword: String
  }
}
</script>

<style scoped>
div#info {
  margin-left: 1%;
  text-align: left;
}
</style>