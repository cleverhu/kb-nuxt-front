<template>

  <div>
    <el-container style="margin-left:320px">
      <el-main>
        <h1 style="font-size: 30px;margin-bottom: 10px">123123{{ docDetail.title }}</h1>
        <div v-html="docDetail.content"></div>
      </el-main>
      <el-footer>
        <div>
          <span style="display:block;text-align:center;"> footer</span>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "docShortUrl",

  data() {
    return {
      docShortUrl: "",
      docDetail: {title: "", content: ""}
    };
  },
  created() {

  },
  methods: {
    getDocDetail:function (){

    }
  },
  watch: {
    $route: {
      handler(val) {
        this.docShortUrl = val.params.docShortUrl
        this.$forceUpdate()
      },
      // 深度观察监听
      deep: true
    }
  }
}
</script>

<style>

</style>
