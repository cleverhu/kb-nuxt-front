<template>

  <div>
    <el-container style="margin-left:320px">
      <el-main>
        <div id="doc_content" style=" overflow:scroll;height: calc(80vh);">
          <span style="font-size: 30px;font-weight: bold;margin-left: 10%;">{{ docDetail.doc_title }}</span>
          <div v-html="docDetail.doc_content" style="margin-left: 10%;margin-right: 15%"></div>
        </div>

      </el-main>
      <el-footer>
        <div>
          <span style="display:block;text-align:center;"> i'm footer</span>
        </div>
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "docShortUrl",

  data() {
    return {
      docShortUrl: "",
      docDetail: {doc_title: "", doc_content: ""}
    };
  },
  created() {
    this.docShortUrl = this.$route.params.docShortUrl
    this.getDocDetail()
  },
  methods: {
    getDocDetail: function () {
      if (this.docShortUrl !== undefined && this.docShortUrl !== "") {
        axios.get("http://nuxt-back.deeplythink.com/doc/" + this.docShortUrl)
          .then(res => {
            this.docDetail = res.data.result
          })
      }
    }
  },
  watch: {
    $route: {
      handler(val) {
        this.docShortUrl = val.params.docShortUrl
        this.getDocDetail()
      },
    }
  }
}
</script>

<style>

</style>
