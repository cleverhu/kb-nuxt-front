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
          <keep-alive>
            <el-tree :data="docInfo" :props="defaultProps"
                     v-show="flag"
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
            <el-tree :data="docInfo" :props="defaultProps"
                     v-show="flag"
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
          </keep-alive>

        </el-aside>
        <Nuxt></Nuxt>
      </el-container>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "kb_layout",
  data() {
    return {
      expandArr: [],
      flag: false,
      docTitle: "",
      content: "",
      kbInfo: {kbName: "", docGrpShortUrl: "", docShortUrl: "", grpName: "", docName: ""},
      docInfo: [],
      defaultProps: {
        children: 'children',
        label: 'label'
      },
    };
  },
  created() {

    this.docInfo = JSON.parse('{"code":10000,"result":[{"group_id":1052,"label":"2.0-Linux bash脚本特性-分组","url":"Vziiuq","children":[{"doc_id":1041,"label":"2.0-Linux bash脚本特性-文章","url":"qeaEre","DocHref":"/test/Vziiuq/qeaEre"},{"group_id":1053,"label":"1.9-Linux内存调优化-分组","url":"yAju6j","children":[{"doc_id":1042,"label":"1.9-Linux内存调优化-文章","url":"BZvQ3u","DocHref":"/test/yAju6j/BZvQ3u"}]},{"group_id":1054,"label":"1.8-Linux SELinux安全-分组","url":"beiABz","children":[{"doc_id":1043,"label":"1.8-Linux SELinux安全-文章","url":"UB7nay","DocHref":"/test/beiABz/UB7nay"}]}]},{"group_id":1055,"label":"1.7-Linux iptables及浅说tcp ip-分组","url":"3Inuem","children":[{"doc_id":1044,"label":"1.7-Linux iptables及浅说tcp ip-文章","url":"qQNzaq","DocHref":"/test/3Inuem/qQNzaq"},{"group_id":1056,"label":"1.6-Linux yum包管理器-分组","url":"aiiQFf","children":[{"doc_id":1045,"label":"1.6-Linux yum包管理器-文章","url":"Yreiua","DocHref":"/test/aiiQFf/Yreiua"}]},{"group_id":1057,"label":"1.5-Linux vim编辑器及文件查找-分组","url":"uEjm63","children":[{"doc_id":1046,"label":"1.5-Linux vim编辑器及文件查找-文章","url":"EVZVra","DocHref":"/test/uEjm63/EVZVra"}]}]},{"group_id":1058,"label":"1.4-Linux权限模型-分组","url":"meiqie","children":[{"doc_id":1047,"label":"1.4-Linux权限模型-文章","url":"6BRr2m","DocHref":"/test/meiqie/6BRr2m"},{"group_id":1059,"label":"1.3-Linux文件系统详解-分组","url":"Mf6jqm","children":[{"doc_id":1048,"label":"1.3-Linux文件系统详解-文章","url":"VryUR3","DocHref":"/test/Mf6jqm/VryUR3"},{"group_id":1060,"label":"1.2-Linux系统启动及内核设计风格-分组","url":"Q3QZjm","children":[{"doc_id":1049,"label":"1.2-Linux系统启动及内核设计风格-文章","url":"iIzMV3","DocHref":"/test/Q3QZjm/iIzMV3"}]}]}]},{"group_id":1061,"label":"1.1-Linux发展现状-分组","url":"jAN7Rn","children":[{"doc_id":1050,"label":"1.1-Linux发展现状-文章","url":"eMfABz","DocHref":"/test/jAN7Rn/eMfABz"},{"group_id":1062,"label":"1.0-Linux源起-分组","url":"mauEjq","children":[{"doc_id":1051,"label":"1.0-Linux源起-文章","url":"B3mMje","DocHref":"/test/mauEjq/B3mMje"}]}]}]}').result
    this.kbInfo.kbName = this.$route.params.kbName
    this.kbInfo.docGrpShortUrl = this.$route.params.docGrpShortUrl
    this.kbInfo.docShortUrl = this.$route.params.docShortUrl

  },
  mounted() {
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
    window.setTimeout(() => {
      this.flag = true
    }, 1)

  },
  methods: {
    handleNodeClick: function (data) {
      let kbName = this.kbInfo.kbName
      let grp = this.getParentShortUrl(data.url, this.docInfo)
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

  },
  watch: {
    $route: {
      handler(val) {
        //alert(val.path)
        this.kbInfo.kbName = this.$route.params.kbName
        this.kbInfo.docGrpShortUrl = this.$route.params.docGrpShortUrl
        this.kbInfo.docShortUrl = this.$route.params.docShortUrl
        this.kbInfo.docName = localStorage.getItem('docName')
        this.kbInfo.grpName = localStorage.getItem('grpName')
        this.docTitle = this.kbInfo.docName
        this.$forceUpdate()
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
