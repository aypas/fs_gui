<template>
  <div id="app">

    <!-- iconbar: place to select component to display in sidebar  -->
    <div id="iconbar">
      <div>
        <div id="icon" @click="switchOn('folders')" v-bind:class="{active: sidebarView == 'folders'}"><b-icon-folder variant="light"></b-icon-folder></div>

        <div id="icon" @click="switchOn('server')" v-bind:class="{active: sidebarView == 'server'}">
          <b-icon-power :variant="listening ? 'success' : 'light'"></b-icon-power>
        </div>

        <div id="icon" v-bind:class="{active: sidebarView == 'send'}">
          <b-icon-arrow-down-right @click="switchOn('send')" variant="light" rotate="270"></b-icon-arrow-down-right>
        </div>

        <!-- <div id="icon" @click="switchOn('')"><b-icon-arrow-up-right variant="light"></b-icon-arrow-up-right></div> -->

        <div id="icon" @click="switchOn('contacts')" v-bind:class="{active: sidebarView == 'contacts'}">
          <b-icon-people variant="light"></b-icon-people>
        </div>

        <div id="icon" @click="switchOn('info')" v-bind:class="{active: sidebarView == 'info'}">
          <b-icon-info-circle variant="light"></b-icon-info-circle>
        </div>
      </div>
    </div>

    <!-- sidebar: there will be a nested if else thing with some components -->
    <div id="sidebar" v-if="!sidebarHidden" v-bind:class="{hidden: sidebarHidden === true}" v-bind:style="{width: sidebarWidth + 'px'}">
      <div id="close-btn" @click="sidebarHidden = !sidebarHidden" >   
        <img src="./assets/close.png" >
      </div>

      <div id="cunt">
        <keep-alive><directory v-if="sidebarView == 'folders'" /></keep-alive>
        <keep-alive><server v-if="sidebarView == 'server'" v-on:receive-pass="receivePass($event)"/></keep-alive>
        <keep-alive><send v-if="sidebarView == 'send'" /></keep-alive>
        <keep-alive><contacts v-if="sidebarView == 'contacts'" /></keep-alive>
        <keep-alive><info v-if="sidebarView == 'info'" v-bind:receive-password="receivePassword" /></keep-alive>
      </div>
    </div>

    <div id="resize" v-show="!sidebarHidden"></div>
    
    <div id="content">
      <editor />
    </div>

  </div>
</template>

<script>
import directory from './components/directory-display.vue'
import contacts from './components/contacts.vue'
import editor from './components/editor.vue'
import server from './components/server.vue'
import send from './components/send.vue'
import info from './components/info.vue'

export default {
  name: 'App',
  data() {
    return {
      sidebarHidden: false,
      sidebarView: "folders",
      sidebarWidth: 200,

      receivePassword: "nopass"
    }
  },
  computed: {
    count() {
      return this.$store.state.count;
    },

    listening() {
      return this.$store.state.fileShare.listener.listening;
    }
  },
  methods: {
    switchOn(to) {
      this.sidebarView = to
      this.sidebarHidden = false
    },

    receivePass(e) {
      this.receivePassword = e;
    },

    dragControllerDev() {
      let data = this;
      let resize = document.getElementById("resize");
      resize.onmousedown = function(e) {
        // Color change reminder
        //resize.style.background = "#818181";
        let startX = e.clientX;
        resize.left = resize.offsetLeft;
        document.onmousemove = function(e) {
          // Calculate and apply displacement
          let endX = e.clientX;
          let moveLen = endX - startX;
          startX = endX;
          data.sidebarWidth += moveLen;
        };
        document.onmouseup = function() {
          // color restoration
          resize.style.background = "";
          document.onmousemove = null;
          document.onmouseup = null;
        };
        return false;
      };
    }
  },

  mounted() {
    this.dragControllerDev()
  },

  components: {
    info,
    send,
    server,
    editor,
    contacts,
    directory,
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
  width: 100%;
  display: flex;
  justify-content: center;
  flex-flow: row nowrap; 
}


#content {
  display: flex;
  justify-content: center;
  flex-flow: row nowrap;
  height: 100%;
  width: 100%;
  flex-grow: 1;
  background-color: #2c3e50;
  color: white;
}

#sidebar {
  background: #777;
  width: 30px;
  height: 100%;
  overflow-y: auto;
  flex-grow: 1;
  margin: 0;
  padding: 0;
  display: block;
}

#cunt {
  display: block;
}

#resize {
  width: 5px;
  height: 100%;
  cursor: w-resize;
}

#iconbar {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 42px;
  padding-top: 40px;
  background-color: #272e29;
  font-size: 2rem;
  float: left;
}

#icon {
  margin-bottom: 20px;
  border-radius: 25px;
}

.active {
  background-color: #303832;
}

#icon:hover {
  background-color: #303832;
}

.hidden {
  display: None;
}

#close-btn {
  display: flex; 
  justify-content: flex-end;
}

#close-btn:hover {
  cursor: pointer;
}


::-webkit-scrollbar {
  width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
  background: #f1f1f1; 
}
 
/* Handle */
::-webkit-scrollbar-thumb {
  background: #888; 
}
</style>