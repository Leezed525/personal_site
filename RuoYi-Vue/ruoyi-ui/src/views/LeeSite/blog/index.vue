<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="博客标题" prop="title">
        <el-input
          v-model="queryParams.title"
          placeholder="请输入博客标题"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="博客分类" prop="category">
        <el-select
          v-model="queryParams.category"
          placeholder="请选择博客分类"
          clearable
          @change="handleQuery"
        >
          <el-option
            v-for="item in blog_category"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <!--        <el-input-->
        <!--          v-model="queryParams.category"-->
        <!--          placeholder="请输入博客分类"-->
        <!--          clearable-->
        <!--          @keyup.enter.native="handleQuery"-->
        <!--        />-->
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:article:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:article:edit']"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:article:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:article:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <!--      <el-table-column label="id" align="center" prop="id" width="50px"/>-->
      <el-table-column label="博客标题" align="center" prop="title"/>
      <!-- 博客url -->
      <el-table-column label="博客url" align="center" prop="url">
        <template slot-scope="scope">
          <a :href="scope.row.url" target="_blank" class="link-text">
            {{ scope.row.url ? scope.row.url.substring(0, 30) + '...' : '' }}
          </a>
        </template>
      </el-table-column>
      <!-- 博客封面url -->
      <el-table-column label="博客封面url" align="center" prop="cover">
        <template slot-scope="scope">
          <a :href="scope.row.cover" target="_blank" class="link-text">
            {{ scope.row.cover ? scope.row.cover.substring(0, 30) + '...' : '' }}
          </a>
        </template>
      </el-table-column>
      <el-table-column label="博客摘要" align="center" prop="summary"/>
      <el-table-column label="博客分类" align="center" prop="category"/>
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.site_article_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime"/>
      <el-table-column label="备注" align="center" prop="remark"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            v-show="scope.row.status === 0"
            size="mini"
            type="text"
            icon="el-icon-unlock"
            @click="handlePublish(scope.row)"
            v-has-permi="['system:article:edit']"
          >发布
          </el-button>
          <el-button
            v-show="scope.row.status === 1"
            size="mini"
            type="text"
            icon="el-icon-lock"
            @click="handleHide(scope.row)"
            v-has-permi="['system:article:edit']"
          >隐藏
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:article:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:article:remove']"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改站点博客列对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="博客标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入博客标题"/>
        </el-form-item>
        <el-form-item label="博客url" prop="url">
          <el-input v-model="form.url" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="博客封面url" prop="cover">
          <el-input v-model="form.cover" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="博客摘要" prop="summary">
          <el-input v-model="form.summary" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="博客分类" prop="category">
          <!--          <el-input v-model="form.category" placeholder="请输入博客分类"/>-->
          <el-select v-model="form.category" placeholder="请选择博客分类" clearable>
            <el-option
              v-for="item in blog_category"
              :key="item.value"
              :label="item.name"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listArticle,
  getArticle,
  delArticle,
  addArticle,
  updateArticle,
  publishArticle,
  hideArticle
} from "@/api/LeeSite/article"

export default {
  name: "Article",
  dicts: ['site_article_status'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 站点博客列表格数据
      articleList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: null,
        url: null,
        cover: null,
        summary: null,
        category: null,
        status: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        title: [
          {required: true, message: "博客标题不能为空", trigger: "blur"}
        ],
        url: [
          {required: true, message: "博客url不能为空", trigger: "blur"}
        ],
        createBy: [
          {required: true, message: "创建人不能为空", trigger: "blur"}
        ],
        createTime: [
          {required: true, message: "创建时间不能为空", trigger: "blur"}
        ],
        status: [
          {required: true, message: "状态不能为空", trigger: "change"}
        ],
      },
      // 博客分类
      blog_category: [
        // {name: "全部", value: null},
        {name: "java", value: "java"},
        {name: "python", value: "python"},
        {name: "rust", value: "rust"},
        {name: "project", value: "project"},
      ]
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询站点博客列列表 */
    getList() {
      this.loading = true
      listArticle(this.queryParams).then(response => {
        this.articleList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        title: null,
        url: null,
        cover: null,
        summary: null,
        category: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        status: null,
        remark: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加站点博客列"
    },

    // 隐藏函数
    handleHide(row) {
      const id = row.id
      this.$modal.confirm('是否确认隐藏站点博客标题为"' + row.title + '"的数据项？').then(function () {
        return hideArticle({id})
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("隐藏成功")
      }).catch(() => {
      });
    },

    //发布函数
    handlePublish(row) {
      const id = row.id
      this.$modal.confirm('是否确认发布站点博客标题为"' + row.title + '"的数据项？').then(function () {
        return publishArticle({id})
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("发布成功")
      }).catch(() => {
      });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getArticle(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改站点博客列"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateArticle(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addArticle(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除站点博客标题为"' + row.title + '"的数据项？').then(function () {
        return delArticle(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/article/export', {
        ...this.queryParams
      }, `article_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.link-text {
  color: #409EFF;
  text-decoration: none;
}

.link-text:hover {
  text-decoration: underline;
}
</style>
