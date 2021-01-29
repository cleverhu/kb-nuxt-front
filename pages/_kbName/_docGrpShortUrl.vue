<template>
<div>
  <nuxt-child></nuxt-child>
</div>
</template>

<script>
export default {
  name: "docGrpShortUrl",
  watch: {
    $route: {
      handler(val) {
        //alert(val.path)
        this.$forceUpdate()
      },
      // 深度观察监听
      deep: true
    }
  }
}
</script>

<style scoped>

</style>
