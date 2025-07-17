<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="上级留言" prop="preId">
        <el-input
          v-model="queryParams.preId"
          placeholder="请输入上级留言"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否根留言" prop="root">
        <el-select
          v-model="queryParams.root"
          placeholder="请选择博客分类"
          clearable
          @change="handleQuery"
        >
          <el-option
            v-for="item in is_root_selections"
            :key="item.id"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
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
          v-hasPermi="['project:comment:add']"
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
          v-hasPermi="['project:comment:edit']"
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
          v-hasPermi="['project:comment:remove']"
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
          v-hasPermi="['project:comment:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="commentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="上级留言" align="center" prop="preId"/>
      <el-table-column label="留言内容" align="center" prop="content"/>
      <el-table-column prop="status" label="状态" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.site_comment_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="是否根留言" align="center" prop="root">
        <template slot-scope="scope">
          {{ scope.row.root === '1' ? '是' : '否' }}
        </template>
      </el-table-column>
      <el-table-column label="留言人" align="center" prop="createBy"/>
      <el-table-column label="留言时间" align="center" prop="createTime"/>
      <el-table-column label="备注" align="center" prop="remark"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
          >查看
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['project:comment:remove']"
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

    <!-- 添加或修改留言板对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="上级留言" prop="preId">
          <el-input v-model="form.preId" placeholder="请输入上级留言"/>
        </el-form-item>
        <el-form-item label="留言内容">
          <editor v-model="form.content" :min-height="192"/>
        </el-form-item>
        <el-form-item label="回复内容" prop="reply">
          <el-input v-model="form.reply" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="回复时间" prop="replyTime">
          <el-date-picker clearable
                          v-model="form.replyTime"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择回复时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="是否根留言" prop="root">
          <el-input v-model="form.root" placeholder="请输入是否根留言"/>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!--查看弹窗-->
    <!-- 查看留言 -->
    <el-dialog
      title="查看留言"
      :visible.sync="viewOpen"
      width="600px"
      append-to-body>
      <el-form label-width="100px" class="view-form">
        <el-form-item label="上级留言">{{ viewForm.preId || '无' }}</el-form-item>
        <el-form-item label="留言内容">
          <div v-html="viewForm.content" class="content-box"></div>
        </el-form-item>
        <el-form-item label="是否根留言">{{ viewForm.root === '1' ? '是' : '否' }}</el-form-item>
        <el-form-item label="留言人">{{ viewForm.createBy }}</el-form-item>
        <el-form-item label="留言时间">{{ viewForm.createTime }}</el-form-item>
        <el-form-item label="状态">
          <dict-tag :options="dict.type.site_comment_status" :value="viewForm.status"/>
        </el-form-item>
        <el-form-item label="备注">{{ viewForm.remark || '-' }}</el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button
          type="success"
          icon="el-icon-check"
          :loading="auditLoading"
          @click="auditComment(1)"
        >审核通过
        </el-button>
        <el-button
          type="danger"
          icon="el-icon-close"
          :loading="auditLoading"
          @click="auditComment(2)"
        >审核不通过
        </el-button>
        <el-button @click="viewOpen=false">关 闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {listComment, getComment, delComment, addComment, updateComment,auditCommentSuccess,auditCommentFail} from "@/api/project/comment"

export default {
  name: "Comment",
  dicts: ['site_comment_status'],
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
      // 留言板表格数据
      commentList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        preId: null,
        content: null,
        status: null,
        reply: null,
        replyTime: null,
        root: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        content: [
          {required: true, message: "留言内容不能为空", trigger: "blur"}
        ],
        status: [
          {required: true, message: "状态不能为空", trigger: "change"}
        ],
        root: [
          {required: true, message: "是否根留言不能为空", trigger: "blur"}
        ],
        createBy: [
          {required: true, message: "创建人不能为空", trigger: "blur"}
        ],
        createTime: [
          {required: true, message: "创建时间不能为空", trigger: "blur"}
        ],
      },
      is_root_selections: [
        {
          id: 1,
          label: "是",
          value: "1",
        },
        {
          id: 2,
          label: "否",
          value: "0",
        }
      ],
      viewOpen: false,
      viewForm: {},
      auditLoading: false    // 审核按钮 loading

    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询留言板列表 */
    getList() {
      this.loading = true
      listComment(this.queryParams).then(response => {
        this.commentList = response.rows
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
        preId: null,
        content: null,
        status: null,
        reply: null,
        replyTime: null,
        root: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
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
      this.title = "添加留言板"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getComment(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改留言板"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateComment(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addComment(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除留言板编号为"' + ids + '"的数据项？').then(function () {
        return delComment(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    handleView(row) {
      this.viewForm = {...row};   // 浅拷贝即可，无需深拷贝
      this.viewOpen = true;
    },
    auditComment(status) {
      this.auditLoading = true;
      const data = {id: this.viewForm.id};
      if (status === 1) {
        auditCommentSuccess(data).then(() => {
          this.$modal.msgSuccess('审核通过');
        }).catch(() => {
        });
      }else{
        auditCommentFail(data).then(() => {
          this.$modal.msgSuccess('审核不通过');
        }).catch(() => {
        });
      }
      // 1. 关闭弹窗 2. 刷新列表
      this.viewOpen = false;
      this.auditLoading = false;
      this.getList();
    },

    /** 导出按钮操作 */
    handleExport() {
      this.download('project/comment/export', {
        ...this.queryParams
      }, `comment_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style>
.view-form .content-box {
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding: 8px 12px;
  background: #fafafa;
  min-height: 80px;
  line-height: 1.6;
}
</style>
