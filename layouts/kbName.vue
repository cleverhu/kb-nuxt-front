<template>

  <div>55555
    {{kbInfo.docShortUrl}}
    {{kbInfo.docShortUrl}}
    {{kbInfo.kbName}}
    <Nuxt />
  </div>
</template>

<script>
export default {
  name: "docShortUrl",
  layout: 'kbName',
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
