<template>
  <div class="body" tabindex="-1">
    <textarea spellcheck="false" id="text" cols="100%" rows="10" v-bind:value="fileData" @input="data = $event.target.value"></textarea>
  </div>
</template>

<script>
export default {
  data() {
    return {
      open: false,
      data: ""
    }
  },

  computed: {
    fileData() {
      return this.$store.state.editor.fileData;
    }
  },

  mounted() {
    let el = document.getElementById("text")
    el.addEventListener("keypress", (event) => {
      if (event.ctrlKey && event.code === "KeyS") {
        this.$store.dispatch("editor/save", this.data)
      }
    })
    // cant get tab indentation to work
    // also, if you want to catch the press of a tab button, you must listen to keydown event
  }
}
</script>

<style >
.body {
  color:white;
  width: 100%;
  margin-left: 1%;
}
textarea {
  width: 100%;
  height: 100%;
  background-color: #2c3e50;
  color:white;
  border: none;
}

textarea:focus, input:focus{
  outline: none;
}
</style>