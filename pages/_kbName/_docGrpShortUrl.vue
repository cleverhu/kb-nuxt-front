<template>

  <div>2222
    {{kbInfo.docShortUrl}}
    {{kbInfo.docShortUrl}}
    {{kbInfo.kbName}}
    <nuxt-child/>
  </div>
</template>

<script>
export default {
  name: "docGrpShortUrl",
  data() {
    return {

      kbInfo: {kbName: "", docGrpShortUrl: "", docShortUrl: "", grpName: "", docName: ""},
      docInfo: [],

    };
  },
  created() {
    this.kbInfo.docShortUrl = this.$route.params.docShortUrl
    this.kbInfo.docGrpShortUrl = this.$route.params.docGrpShortUrl
    this.kbInfo.kbName = this.$route.params.kbName
  },
  mounted() {

  },
  methods: {}
}
</script>

<style>

.is-current > .el-tree-node__content {
  color: orange !important;
}

</style>
