<template>
  <div>
    <el-container>
      <el-aside style="height: calc(100vh - .29524rem);">
        <el-tag>
          目录
        </el-tag>
        <el-tree :data="docInfo" :props="defaultProps"
                 @node-click="handleNodeClick"
                 :default-expand-all="true"
                 node-key="url"
                 :current-node-key="$route.params.docShortUrl"
        >

        </el-tree>

      </el-aside>
      <el-container>
        <el-main>
          {{ content }}

        </el-main>
        <el-footer>
          <div>
            <span style="display:block;text-align:center;"> footer</span>
          </div>
        </el-footer>
      </el-container>

    </el-container>
  </div>
</template>

<script>
export default {
  name: "_docShortUrl",
  data() {
    return {
      content: "",
      kbInfo: {kbName: "", docGrpShortUrl: "", docShortUrl: ""},
      docInfo: [
        {
          label: '1',
          url: "1",
          children: [{
            label: '1.1',
            url: "1-1",
            children: [{
              label: '1.1.1',
              url: "1-1-1",
              children:
                [{
                  label: '1.1.1.1',
                  url: "1-1-1-1",
                }]
            }, {
              label: '1.1.2',
              url: "1-1-2",
            }]
          },
            {
              label: '1.2',
              url: "1-2",
            },]
        },
        {
          label: '2',
          url: "2",
          children: [{
            label: '2.1',
            url: "2-1",
          },
            {
              label: '2.2',
              url: "2-2",
            },]
        }
      ],
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


    this.content = this.$route.params
  },
  methods: {
    handleNodeClick: function (data) {
      let kbName = this.kbInfo.kbName
      let groupShortUrl = this.getParentShortUrl(data.url, this.docInfo)
      //alert(groupShortUrl)
      if (groupShortUrl !== undefined) {
        this.$router.push("/" + kbName + "/" + groupShortUrl + "/" + data.url)
      } else {
        this.$router.push("/" + kbName + "/" + data.url)
      }

    },
    getParentShortUrl: function (sonUrl, par) {
      //console.log(sonUrl, par, par.length)
      if (par.length === undefined) {
        for (let j = 0; j < par.children.length; j++) {
          //console.log(j, sonUrl, par.children[j])
          if (par.children[j].url === sonUrl) {
            return par.url
          }
          if (par.children[j].children !== undefined) {
            let result = this.getParentShortUrl(sonUrl, par.children[j])
            //alert("res" + result)
            if (result !== undefined) {
              return result
            }
          }

        }
      }

      for (let i = 0; i < par.length; i++) {
        //console.log(i,par[i])
        for (let j = 0; j < par[i].children.length; j++) {
          //console.log(j,par[i].children[j])
          if (par[i].children[j].url === sonUrl) {
            return par[i].url
          }
          if (par[i].children[j].children !== undefined) {
            //console.log(sonUrl,par[i].children[j])
            // console.log(this.getParentShortUrl(sonUrl, par[i].children[j]))
            let result = this.getParentShortUrl(sonUrl, par[i].children[j])
            if (result !== undefined) {
              return result
            }
          }

        }
      }
    }

  }
}
</script>

<style>
.is-current > .el-tree-node__content {
  color: orange !important;
}

</style>
