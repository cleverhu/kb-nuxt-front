<template>
  <div>
    <el-button @click="login(input)">Hello</el-button>
    <el-input v-model="input" placeholder="请输入内容"></el-input>

  </div>

</template>

<script>
export default {
  data() {
    return {
      input: ''
    }
  },
  methods: {
    login: function (a) {
      alert(a)
    }
  }
}
</script>


