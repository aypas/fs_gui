<template>
  <div id="container" v-bind:style="{'margin-left': (depth*4) +'%'}">   
    <div id="dick" v-for="(value, key) in folder" v-bind:key="key">
      <span id="line" v-if="!value.isDir" v-show="!value.hidden">
        <b-icon-file-earmark-richtext></b-icon-file-earmark-richtext>
        {{value.name}}
        
      </span>

      <div id="lines" v-else>
        <span v-bind:style="{margin: 0}">
          <b-icon-arrow-left-short class="p-0 m-0" v-if="value.hidden" rotate="180"></b-icon-arrow-left-short>
          <b-icon-arrow-left-short class="p-0 m-0" v-else rotate="270"></b-icon-arrow-left-short>
          <span @click="value.hidden = !value.hidden">{{value.name}} </span>
        </span>
        <folder v-bind:folder="value.files" v-bind:hidden="true" v-bind:depth="depth+1" v-show="!value.hidden"></folder>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "folder",
  props: {
    folder: Array,
    hidden: Boolean,
    depth: Number
  },


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

#dick:hover {
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