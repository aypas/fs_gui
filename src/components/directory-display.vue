<template>
  <div id="cccontainer">

  <div id="ppb">
    <div id="buttons">
      <button class="tab" @click="folderName='send'" :class="folderName == 'send' ? 'display' : ''">Send</button>
      <div style="width: 3px"></div>
      <button class="tab" @click="folderName='receive'" :class="folderName == 'receive' ? 'display' : ''">Receive</button>
    </div>
  </div>


  
  <div id="content-directory">
    <div id="ccontent" v-for="(value, key) in topLevelFolders" v-bind:key="key">
      <div>
        <div id="directory" @click="value.hidden=!value.hidden" @click.right="right(value)">
          <b-icon-arrow-left-short v-if="value.hidden" rotate="180"></b-icon-arrow-left-short>
          <b-icon-arrow-left-short v-else rotate="270"></b-icon-arrow-left-short>
          <span >{{value.name}}</span>
        </div>
        <folder v-bind:folder="value.files" v-bind:hidden="true" v-bind:depth="1" v-show="!value.hidden"></folder>
      </div>
    </div>
    <!-- <button @click="refresh">pp</button> -->
  </div>
  </div>
</template>


<script>
import { ipcRenderer } from "electron"
import folder from "./recursive-folders.vue";
export default {
  data() {
    return {
      folderName: "send"
    }
  },

  methods: {
    refresh() {
      // temp
      // this.$store.commit("files/clearState")
      console.log("kaka")
      this.$store.dispatch("files/topLevelFolders", this.folderName)
        .then(() => {
          console.log("adfojsdfoijdsfosdjf")
          this.$store.dispatch("files/traverseDirectoryWrapper", this.folderName)
        })
    },

    right(value) {
      ipcRenderer.send('directory-right-click', {value, folder: this.folderName})
    }
  },

  computed: {
    topLevelFolders() {
      console.log(this.$store.state.files)
      return this.$store.state.files.topLevelFolders[this.folderName]
    }
  },

  mounted() {
    if (this.$store.state.files.topLevelFolders !== null) {
      return null
    }
    this.$store.dispatch("files/topLevelFolders", this.folderName)
      .then(() => {
        console.log("adfojsdfoijdsfosdjf")
        this.$store.dispatch("files/traverseDirectoryWrapper", this.folderName)
      })
  },

  components: {
    folder
  }
}
</script>


<style scoped>

#buttons {
  display: flex;
  justify-content: center;
  border-bottom: 3px solid #2c3e50;
}

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



#content-directory {
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
  width: max-content;
  padding-left: 5%;
  text-align: left;
  width: 100%;

}

:hover {
  cursor: pointer;
}

#ccontent {
  width: 100%;
}

/* #directory {
  width:100%;
  left: 0;
  align-items:center;
} */

#directory:hover {
  background-color: #616161;
  padding-left: 0px !important
}

#ppb {
  padding-left: 5%;
  padding-right: 5%;
  margin-bottom: 5%;
}


::selection {
    color: none;
    background: none;
}
</style>