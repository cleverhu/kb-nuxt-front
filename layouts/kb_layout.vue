<template>

  <div>
    <el-container>
      <el-header style="margin-top: 20px;height:60px;position: fixed;">
        <el-breadcrumb separator="/">
          <el-breadcrumb-item><a :href="'/'+kbInfo.kbName">{{ kbInfo.kbName }}</a></el-breadcrumb-item>
          <el-breadcrumb-item v-if="kbInfo.docGrpShortUrl!==undefined"><a
            :href="'/'+kbInfo.kbName+'/'+kbInfo.docGrpShortUrl">{{ kbInfo.grpName }}</a></el-breadcrumb-item>
          <el-breadcrumb-item v-if="kbInfo.docShortUrl!==undefined"><a
            :href="'/'+kbInfo.kbName+'/'+kbInfo.docGrpShortUrl+'/'+kbInfo.docShortUrl">{{ kbInfo.docName }}</a>
          </el-breadcrumb-item>
        </el-breadcrumb>
      </el-header>
      <el-container style="position:fixed;top:60px;bottom:0;">
        <el-aside style="height: calc(100vh);position: fixed;width: 30%!important;">
          <el-tag style="margin-top: 10px;margin-bottom: 10px;margin-left: 10px">
            目录
          </el-tag>

          <el-tree :data="kbDetail" :props="defaultProps"
                   @node-click="handleNodeClick"
                   @node-collapse="handleNodeCollapse"
                   @node-expand="handleNodeExpand"
                   :default-expanded-keys="expandArr"
                   node-key="url"
                   v-if="kbInfo.docShortUrl!==undefined"
                   :current-node-key="kbInfo.docShortUrl"
                   style="background-color:#fafafa!important;position:fixed;"

          >
          </el-tree>
          <el-tree :data="kbDetail" :props="defaultProps"
                   @node-click="handleNodeClick"
                   @node-collapse="handleNodeCollapse"
                   @node-expand="handleNodeExpand"
                   :default-expanded-keys="expandArr"
                   node-key="url"
                   v-else
                   :current-node-key="kbInfo.docGrpShortUrl"
                   style="background-color:#fafafa!important;position:fixed;"
          >
          </el-tree>


        </el-aside>
        <Nuxt></Nuxt>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "kb_layout",
  data() {
    return {
      expandArr: [],
      docTitle: "",
      content: "",
      kbInfo: {kbName: "", docGrpShortUrl: "", docShortUrl: "", grpName: "", docName: ""},
      kbDetail: [],
      defaultProps: {
        children: 'children',
        label: 'label'
      },
    };
  },
  created() {
    this.kbInfo.kbName = this.$route.params.kbName
    this.kbInfo.docGrpShortUrl = this.$route.params.docGrpShortUrl
    this.kbInfo.docShortUrl = this.$route.params.docShortUrl
  },
  mounted() {
    this.kbInfo.kbName = this.$route.params.kbName
    this.kbInfo.docGrpShortUrl = this.$route.params.docGrpShortUrl
    this.kbInfo.docShortUrl = this.$route.params.docShortUrl
    let temp = JSON.parse(localStorage.getItem('expandArr'))
    if (temp !== null) {
      for (let i = 0; i < temp.length; i++) {
        if (temp[i] !== null) {
          this.expandArr.push(temp[i])
        }
      }
    }
    this.kbInfo.docName = localStorage.getItem('docName')
    this.kbInfo.grpName = localStorage.getItem('grpName')
    this.docTitle = this.kbInfo.docName
    this.getKbDetail()
  },
  methods: {
    handleNodeClick: function (data) {
      let kbName = this.kbInfo.kbName
      let grp = this.getParentShortUrl(data.url, this.kbDetail)
      //console.log(grp)
      if (grp !== undefined && data.DocHref !== undefined) {
        this.kbInfo.docName = data.label
        this.kbInfo.grpName = grp.label
        this.$router.push("/" + kbName + "/" + grp.url + "/" + data.url)
        localStorage.setItem("docName", data.label)
        localStorage.setItem("grpName", grp.label)
      }
    },
    getParentShortUrl: function (sonUrl, par) {
      if (par.length === undefined) {
        for (let j = 0; j < par.children.length; j++) {
          if (par.children[j].url === sonUrl) {
            return par
          }
          if (par.children[j].children !== undefined) {
            let result = this.getParentShortUrl(sonUrl, par.children[j])
            if (result !== undefined) {
              return result
            }
          }

        }
      }

      for (let i = 0; i < par.length; i++) {
        for (let j = 0; j < par[i].children.length; j++) {
          if (par[i].children[j].url === sonUrl) {
            return par[i]
          }
          if (par[i].children[j].children !== undefined) {
            let result = this.getParentShortUrl(sonUrl, par[i].children[j])
            if (result !== undefined) {
              return result
            }
          }

        }
      }
    },
    handleNodeCollapse: function (data) {
      let index = this.expandArr.indexOf(data.url)
      delete this.expandArr[index]
      localStorage.setItem('expandArr', JSON.stringify(this.expandArr))
    },
    handleNodeExpand: function (data) {
      this.expandArr.push(data.url)
      localStorage.setItem('expandArr', JSON.stringify(this.expandArr))
    },
    getKbDetail: function () {
      axios.get("http://nuxt-back.deeplythink.com/kns/120")
        .then(res => {
          this.kbDetail = JSON.parse(res.data.result)
        })
    }
  },
  watch: {
    $route: {
      handler(val) {
        this.kbInfo.kbName = val.params.kbName
        this.kbInfo.docGrpShortUrl = val.params.docGrpShortUrl
        this.kbInfo.docShortUrl = val.params.docShortUrl
        this.kbInfo.docName = localStorage.getItem('docName')
        this.kbInfo.grpName = localStorage.getItem('grpName')
      },
      // 深度观察监听
      deep: true
    }
  }
}
</script>

<style>

.is-current > .el-tree-node__content {
  color: orange !important;
}

</style>
