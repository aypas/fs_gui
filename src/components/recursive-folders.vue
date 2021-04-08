<template>
  <div id="container" v-bind:style="{'margin-left': (depth*4) +'%'}">   
    <div v-for="(value, key) in folder" v-bind:key="key"> <!-- deleted id dick -->
      <div 
        class="hover-class" 
        id="line"
        v-bind:class="{active: path==value.path}" 
        @click="open(value)" 
        @click.right="right(value)" 
        v-if="!value.isDir" 
        v-show="!value.hidden">
        
        <b-icon-file-earmark-richtext></b-icon-file-earmark-richtext>
        {{value.name}}
      </div>

      <div id="lines" v-else>
        <div class="hover-class" @click="value.hidden = !value.hidden" v-bind:style="{margin: 0}">
          <b-icon-arrow-left-short class="p-0 m-0" v-if="value.hidden" rotate="180"></b-icon-arrow-left-short>
          <b-icon-arrow-left-short class="p-0 m-0" v-else rotate="270"></b-icon-arrow-left-short>
          <span >{{value.name}} </span>
        </div>
        <folder 
          v-bind:folder="value.files" 
          v-bind:hidden="true" 
          v-bind:depth="depth+1"  
          v-bind:folder-name="folderName"
          v-show="!value.hidden">
        </folder>
      </div>
    </div>
  </div>
</template>

<script>
import { ipcRenderer } from "electron"
export default {
  name: "folder",
  props: {
    folder: Array,
    hidden: Boolean,
    depth: Number,
    folderName: String
  },
  computed: {
    path() {
      return this.$store.state.editor.fileDetails.path
    }
  },
  methods: {
    right(value) {
      console.log(value)
      ipcRenderer.send('directory-right-click', {value, folder: this.folderName, topLevel: false})
    },

    open(value) {
      console.log(value)
      this.$store.dispatch("editor/addFileDetails", value)
    }
  }
};
</script>

<style scoped>
#container {
  flex-direction: column;
  flex-grow: 1;
  text-align: left;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.active {
  background-color: #616161;
}
.hover-class:hover {
  background-color: #616161;
  padding-left: 0px !important
}

#line #lines {
  position: absolute;
  width:100%;
  left: 0;
  display:flex;
  justify-content: flex-start;
  flex-grow: 1;
  align-items:center;
}

#lines {
  width: 100%;
}

#line {
  width: 100%;
}

::selection {
    color: none;
    background: none;
}
</style>