/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : lee_site

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 18/01/2026 20:23:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'lee_article', '站点博客列表', NULL, NULL, 'LeeArticle', 'crud', '', 'com.ruoyi.system', 'system', 'article', '站点博客列', 'ruoyi', '0', '/', NULL, 'admin', '2025-07-13 16:20:43', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (2, 'lee_comment', '留言板', NULL, NULL, 'LeeComment', 'crud', 'element-ui', 'com.ruoyi.lee', 'project', 'comment', '留言板', 'ruoyi', '0', '/', '{}', 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49', NULL);
INSERT INTO `gen_table` VALUES (3, 'lee_project', '项目表', NULL, NULL, 'LeeProject', 'crud', 'element-ui', 'com.ruoyi.lee', 'LeeSite', 'project', '项目', 'ruoyi', '0', '/', '{}', 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', 'id', 'int', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (2, 1, 'title', '博客标题', 'varchar(255)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (3, 1, 'url', '博客url', 'varchar(500)', 'String', 'url', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (4, 1, 'cover', '博客封面url', 'varchar(500)', 'String', 'cover', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (5, 1, 'summary', '博客摘要', 'varchar(500)', 'String', 'summary', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (6, 1, 'category', '博客分类', 'varchar(255)', 'String', 'category', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_by', '创建人', 'varchar(64)', 'String', 'createBy', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (8, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (9, 1, 'update_by', '更新人', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (10, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (11, 1, 'status', '状态', 'int', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (12, 1, 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 12, 'admin', '2025-07-13 16:20:43', '', NULL);
INSERT INTO `gen_table_column` VALUES (13, 2, 'id', '主键', 'int', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (14, 2, 'pre_id', '上级留言', 'int', 'Long', 'preId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (15, 2, 'content', '留言内容', 'varchar(500)', 'String', 'content', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', 3, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (16, 2, 'status', '状态', 'int', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (17, 2, 'reply', '回复内容', 'varchar(500)', 'String', 'reply', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (18, 2, 'reply_time', '回复时间', 'datetime', 'Date', 'replyTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (19, 2, 'root', '是否根留言', 'char(1)', 'String', 'root', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (20, 2, 'create_by', '创建人', 'varchar(64)', 'String', 'createBy', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (21, 2, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (22, 2, 'update_by', '更新人', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (23, 2, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (24, 2, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 12, 'admin', '2025-07-17 13:10:42', '', '2025-07-17 13:11:49');
INSERT INTO `gen_table_column` VALUES (25, 3, 'id', '主键', 'int', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (26, 3, 'title', '项目名称', 'varchar(255)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (27, 3, 'description', '项目描述', 'varchar(500)', 'String', 'description', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (28, 3, 'status', '状态', 'int', 'Long', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 4, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (29, 3, 'link', '项目链接', 'varchar(500)', 'String', 'link', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 5, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (30, 3, 'image', '项目图片', 'varchar(500)', 'String', 'image', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'imageUpload', '', 6, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (31, 3, 'create_by', '创建人', 'varchar(64)', 'String', 'createBy', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (32, 3, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '1', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (33, 3, 'update_by', '更新人', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (34, 3, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');
INSERT INTO `gen_table_column` VALUES (35, 3, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2025-07-18 21:49:35', '', '2025-07-18 21:50:04');

-- ----------------------------
-- Table structure for lee_article
-- ----------------------------
DROP TABLE IF EXISTS `lee_article`;
CREATE TABLE `lee_article`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '博客标题',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '博客url',
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '博客封面url',
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '博客摘要',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '博客分类',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `status` int NOT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '站点博客列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_article
-- ----------------------------
INSERT INTO `lee_article` VALUES (2, '6.0 手动实现一个RAG工程开始', 'https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501', 'https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/2kmL/1440X839/image.png', '开始自己动手实现一个简单地RAG', 'python', 'admin', '2025-07-14 17:44:58', 'admin', '2025-07-15 16:11:03', 1, NULL);
INSERT INTO `lee_article` VALUES (3, '6.1 实现Embeding模块', 'https://blog.csdn.net/Leezed525/article/details/149027973?spm=1001.2014.3001.5501', 'https://picx.zhimg.com/v2-93f2dc6f416063d069944eba49030803_r.jpg', '实现了一个Embeding模块', 'python', 'admin', '2025-07-14 23:26:20', 'admin', '2025-07-15 16:18:57', 1, NULL);
INSERT INTO `lee_article` VALUES (4, '6.2 实现文档加载和切分和简易向量数据库的功能', 'https://blog.csdn.net/Leezed525/article/details/149054143?spm=1001.2014.3001.5501', NULL, '完成资料的加载和切分的工具，完成简易的向量数据库', 'python', 'admin', '2025-07-14 23:28:27', 'admin', '2025-07-15 16:18:59', 1, NULL);
INSERT INTO `lee_article` VALUES (5, '1. pytorch手写数字预测', 'https://blog.csdn.net/Leezed525/article/details/148344780?spm=1001.2014.3001.5501', 'https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/t4vt/818X762/image.png', '完成pytorch手写预测', 'python', 'admin', '2025-07-14 23:30:03', 'admin', '2025-07-15 16:19:02', 1, NULL);
INSERT INTO `lee_article` VALUES (6, '2. 手写数字预测 gui版', 'https://blog.csdn.net/Leezed525/article/details/148352169?spm=1001.2014.3001.5501', 'https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/8C5l/502X582/image.png', '使用pyqt来作为GUI实现手写数字预测', 'python', 'admin', '2025-07-14 23:31:16', 'admin', '2025-07-15 16:19:03', 1, NULL);
INSERT INTO `lee_article` VALUES (7, '3 mnist gan小试牛刀', 'https://blog.csdn.net/Leezed525/article/details/148587180?spm=1001.2014.3001.5501', 'https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/QIzS/847X783/image.png', '手写gan', 'python', 'admin', '2025-07-14 23:40:28', 'admin', '2025-07-15 16:19:07', 1, NULL);
INSERT INTO `lee_article` VALUES (8, '4 mnist cgan生成指定图像', 'https://blog.csdn.net/Leezed525/article/details/148738971?spm=1001.2014.3001.5501', 'https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250715/TCgJ/987X990/image.png', '手写cgan', 'python', 'admin', '2025-07-15 00:03:27', 'admin', '2025-07-15 16:19:15', 1, NULL);

-- ----------------------------
-- Table structure for lee_comment
-- ----------------------------
DROP TABLE IF EXISTS `lee_comment`;
CREATE TABLE `lee_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pre_id` int NULL DEFAULT NULL COMMENT '上级留言',
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '留言内容',
  `status` int NOT NULL COMMENT '状态',
  `root` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否根留言',
  `author_id` int NOT NULL COMMENT '作者id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '留言板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_comment
-- ----------------------------
INSERT INTO `lee_comment` VALUES (7, NULL, '您好，欢迎您来到我的站点', 1, '1', 100, 'leezed', '2025-07-18 16:27:34', 'admin', '2025-07-18 16:31:25', NULL);

-- ----------------------------
-- Table structure for lee_page_view
-- ----------------------------
DROP TABLE IF EXISTS `lee_page_view`;
CREATE TABLE `lee_page_view`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `view_count` int NOT NULL COMMENT '浏览量',
  `view_date` datetime NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_page_view
-- ----------------------------
INSERT INTO `lee_page_view` VALUES (1, 8, '2025-08-29 00:00:00');
INSERT INTO `lee_page_view` VALUES (2, 8, '2025-08-29 00:00:00');

-- ----------------------------
-- Table structure for lee_project
-- ----------------------------
DROP TABLE IF EXISTS `lee_project`;
CREATE TABLE `lee_project`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目描述',
  `status` int NOT NULL COMMENT '状态',
  `link` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目链接',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目图片',
  `order_num` int NOT NULL DEFAULT 20 COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_project
-- ----------------------------
INSERT INTO `lee_project` VALUES (1, 'MHTEnglish小程序加管理页面', 'Springboot + vue + mybatis + shiro + redis MhtEnglish  项目特色：\n1. 自定义日志系统\n2. 自定义mysql二级缓存\n', 2, 'https://github.com/Leezed525/Springboot-vue-MhtEnglish', 'https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/kzaw/1825X956/image.png', 20, 'admin', '2025-07-18 22:28:36', NULL, NULL, NULL);
INSERT INTO `lee_project` VALUES (2, 'cs231n 全套解答', 'CS231n是斯坦福大学开设的深度学习与计算机视觉课程，专注于卷积神经网络（CNN）及其在图像识别、目标检测等领域的应用。课程内容涵盖深度学习基础、CNN架构、优化方法、经典网络模型（如AlexNet、ResNet）、以及前沿应用（如图像字幕生成、GAN等）。课程通过理论讲解、编程作业和项目实践，帮助学生掌握计算机视觉核心技术和深度学习模型的搭建与优化。课程适合有一定机器学习基础和Python编程能力的学习者，旨在培养其解决实际视觉问题的能力。', 2, 'https://github.com/Leezed525/cs231n-assignment123-answer', 'https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/FiEu/1161X645/image.png', 20, 'admin', '2025-07-18 22:49:18', 'admin', '2025-07-18 22:50:30', NULL);
INSERT INTO `lee_project` VALUES (3, '英语单词10000+数据库', '自己爬百度网盘爬出来的10000+英语单词数据库，公益项目（含释义音标词性等）', 2, 'https://github.com/Leezed525/EnglishDataBase', 'https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/GCbx/843X283/image.png', 20, 'admin', '2025-07-18 23:38:29', NULL, NULL, NULL);
INSERT INTO `lee_project` VALUES (4, 'Rust_Port_Scan', 'rust语言写的多线程端口探测器，目前可以做到两分钟左右扫描完一个ip的所有端口，还没写完，后续还有很多可以优化的地方，更新中', 1, 'https://github.com/Leezed525/rust_port_scan', 'https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/BZqr/1117X614/image.png', 2, 'admin', '2025-07-18 23:51:52', 'admin', '2025-07-19 17:28:19', NULL);
INSERT INTO `lee_project` VALUES (5, 'SMSTracker: Tri-path Score Mask Sigma Fusion for Multi-Modal Tracking [iccv2025]', '提出三分支打分掩码跟踪框架。1）提出可靠性分数掩码模块，计算多模态数据间的可靠性，增强多模态数据特征；2）提出Drop Key 微调范式，在几乎不增加参数量的基础上提升多模态模型的鲁棒性；3）引入sigma模块进行数据交互，提升跟踪表现；4）提出三路模型架构，不干扰各个模态数据特征提取的过程，提取出各自模态的关键特征。 ', 2, 'https://github.com/Leezed525/SMSTracker', 'https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250719/3OB6/1479X660/image.png', 0, 'admin', '2025-07-19 17:26:17', 'admin', '2025-07-19 17:34:10', NULL);
INSERT INTO `lee_project` VALUES (6, 'pytorch_toy', '主要是包含一些使用pytorch编写的轻量级神经网络应用，包括：\n1. gan系列\n2. 手写数字预测以及gui封装\n3. 一些杂七杂八的pytorch小玩具', 1, 'https://github.com/Leezed525/pytorch_toy', 'https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250719/RRyq/284X238/image.png', 6, 'admin', '2025-07-19 17:41:02', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for lee_unique_view
-- ----------------------------
DROP TABLE IF EXISTS `lee_unique_view`;
CREATE TABLE `lee_unique_view`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `view_count` int NOT NULL COMMENT '浏览量',
  `view_date` datetime NOT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lee_unique_view
-- ----------------------------
INSERT INTO `lee_unique_view` VALUES (1, 1, '2025-08-29 00:00:00');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-07-11 22:37:16', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', 'LeeSite', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', 'admin', '2025-07-15 18:21:25');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', 'admin', '2025-07-14 23:07:46');
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '前台站点', 3, NULL, NULL, NULL, '0', '0', 'admin', '2025-07-15 18:22:54', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '隐藏', '0', 'site_article_status', NULL, 'warning', 'N', '0', 'admin', '2025-07-14 23:03:50', 'admin', '2025-07-14 23:04:38', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 0, '公开', '1', 'site_article_status', NULL, 'success', 'N', '0', 'admin', '2025-07-14 23:04:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 0, '删除', '100', 'site_article_status', NULL, 'info', 'N', '0', 'admin', '2025-07-14 23:04:26', 'admin', '2025-07-14 23:04:49', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '审核中', '0', 'site_comment_status', NULL, 'warning', 'N', '0', 'admin', '2025-07-17 14:20:17', 'admin', '2025-07-17 14:20:45', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 0, '公开', '1', 'site_comment_status', NULL, 'success', 'N', '0', 'admin', '2025-07-17 14:20:38', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 0, '审核不通过', '2', 'site_comment_status', NULL, 'danger', 'N', '0', 'admin', '2025-07-17 14:21:04', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 0, '计划中', '0', 'site_project_status', NULL, 'info', 'N', '0', 'admin', '2025-07-18 22:34:01', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 0, '开发中', '1', 'site_project_status', NULL, 'warning', 'N', '0', 'admin', '2025-07-18 22:34:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 0, '已完成', '2', 'site_project_status', NULL, 'success', 'N', '0', 'admin', '2025-07-18 22:34:37', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-07-11 22:37:16', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '博文状态', 'site_article_status', '0', 'admin', '2025-07-14 23:02:47', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '留言状态', 'site_comment_status', '0', 'admin', '2025-07-17 14:19:45', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '项目状态', 'site_project_status', '0', 'admin', '2025-07-18 22:08:35', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-07-11 22:37:16', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-07-11 22:37:16', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-07-11 22:37:16', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 260 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-11 22:43:46');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-12 11:26:34');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-12 14:33:25');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-12 16:31:11');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-13 16:19:55');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-13 17:56:00');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-13 18:11:36');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-13 18:11:40');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-13 18:20:50');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-13 18:21:03');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-13 19:22:57');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-13 22:07:19');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-13 22:07:25');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-13 22:07:42');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-14 12:39:12');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 14:21:59');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-14 14:24:46');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-14 14:24:56');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 14:24:58');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-14 14:34:34');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 14:34:38');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 15:00:57');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 15:51:18');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 17:44:23');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-14 18:32:11');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 18:32:15');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-14 19:47:16');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 19:47:19');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-14 22:53:57');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 10:50:42');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 10:50:47');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 15:50:10');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 16:51:47');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-15 16:55:18');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 16:55:21');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 18:20:10');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 18:22:14');
INSERT INTO `sys_logininfor` VALUES (137, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:24:31');
INSERT INTO `sys_logininfor` VALUES (138, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:24:48');
INSERT INTO `sys_logininfor` VALUES (139, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:27:41');
INSERT INTO `sys_logininfor` VALUES (140, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:29:26');
INSERT INTO `sys_logininfor` VALUES (141, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-15 21:29:28');
INSERT INTO `sys_logininfor` VALUES (142, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-15 21:29:29');
INSERT INTO `sys_logininfor` VALUES (143, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-15 21:29:29');
INSERT INTO `sys_logininfor` VALUES (144, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-15 21:29:31');
INSERT INTO `sys_logininfor` VALUES (145, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-15 21:29:33');
INSERT INTO `sys_logininfor` VALUES (146, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:30:00');
INSERT INTO `sys_logininfor` VALUES (147, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:30:20');
INSERT INTO `sys_logininfor` VALUES (148, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:31:59');
INSERT INTO `sys_logininfor` VALUES (149, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 21:32:11');
INSERT INTO `sys_logininfor` VALUES (150, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-15 21:45:43');
INSERT INTO `sys_logininfor` VALUES (151, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 23:31:28');
INSERT INTO `sys_logininfor` VALUES (152, 'ad', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-15 23:32:50');
INSERT INTO `sys_logininfor` VALUES (153, 'asd', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-15 23:33:24');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-15 23:36:58');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 10:59:26');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-16 11:01:00');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-16 11:03:33');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:05:03');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:05:53');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:10:15');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:11:40');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-16 11:12:07');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:12:35');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:15:34');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:16:43');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:17:07');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:18:24');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-16 11:29:49');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:30:03');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:31:18');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:39:48');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:40:28');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:41:13');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:41:54');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 11:49:15');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-16 13:18:02');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 13:18:10');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 13:19:38');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-16 13:20:15');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 11:38:21');
INSERT INTO `sys_logininfor` VALUES (181, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 12:02:32');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-17 13:10:15');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 13:10:20');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-17 13:10:51');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 13:10:54');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-17 13:15:39');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 13:22:37');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-17 13:22:58');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-17 13:23:02');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 13:23:05');
INSERT INTO `sys_logininfor` VALUES (191, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 13:42:06');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 14:19:07');
INSERT INTO `sys_logininfor` VALUES (193, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 15:12:41');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 16:54:36');
INSERT INTO `sys_logininfor` VALUES (195, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-17 16:55:10');
INSERT INTO `sys_logininfor` VALUES (196, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 16:55:20');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 18:15:50');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 22:29:03');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-17 23:26:57');
INSERT INTO `sys_logininfor` VALUES (200, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 10:41:08');
INSERT INTO `sys_logininfor` VALUES (201, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 13:01:22');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 13:23:28');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-18 13:23:35');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 13:23:38');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-18 13:23:49');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 13:23:52');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-18 13:26:38');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 13:26:41');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 15:37:41');
INSERT INTO `sys_logininfor` VALUES (210, 'leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 16:27:14');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 21:48:46');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-18 23:36:52');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 09:57:17');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 09:59:37');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-19 16:22:43');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 16:22:47');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 17:19:21');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-19 17:25:36');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 17:25:39');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-19 17:27:46');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 17:27:51');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-19 17:27:58');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 17:28:09');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 17:33:29');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 21:40:01');
INSERT INTO `sys_logininfor` VALUES (226, 'leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 22:13:41');
INSERT INTO `sys_logininfor` VALUES (227, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 22:51:13');
INSERT INTO `sys_logininfor` VALUES (228, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-19 22:57:50');
INSERT INTO `sys_logininfor` VALUES (229, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-19 22:57:59');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-20 09:50:26');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-20 15:52:26');
INSERT INTO `sys_logininfor` VALUES (232, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-20 15:52:34');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-20 15:52:42');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:19:35');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:19:43');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-28 10:19:48');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-28 10:19:52');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:20:00');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:20:09');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-28 10:20:24');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:20:28');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-07-28 10:20:37');
INSERT INTO `sys_logininfor` VALUES (243, 'test', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:20:56');
INSERT INTO `sys_logininfor` VALUES (244, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-28 10:21:05');
INSERT INTO `sys_logininfor` VALUES (245, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:21:09');
INSERT INTO `sys_logininfor` VALUES (246, 'leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:21:51');
INSERT INTO `sys_logininfor` VALUES (247, 'leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:23:10');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-28 10:26:31');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-07-28 10:26:35');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2025-07-28 10:26:37');
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-28 10:27:12');
INSERT INTO `sys_logininfor` VALUES (252, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:27:15');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-07-28 10:29:49');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-07-28 10:29:58');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-28 10:30:42');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-07-28 10:34:11');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-07-28 10:34:18');
INSERT INTO `sys_logininfor` VALUES (258, 'Leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-08-29 21:51:28');
INSERT INTO `sys_logininfor` VALUES (259, 'leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-08-29 21:52:12');
INSERT INTO `sys_logininfor` VALUES (260, 'leezed', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-08-29 21:52:37');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-07-11 22:37:15', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-07-11 22:37:15', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-07-11 22:37:15', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-07-11 22:37:15', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-07-11 22:37:15', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-07-11 22:37:15', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-07-11 22:37:15', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-07-11 22:37:15', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-07-11 22:37:15', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-07-11 22:37:15', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-07-11 22:37:15', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-07-11 22:37:15', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-07-11 22:37:15', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-07-11 22:37:15', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-07-11 22:37:15', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-07-11 22:37:15', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-07-11 22:37:15', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-07-11 22:37:15', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-07-11 22:37:15', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-07-11 22:37:15', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-07-11 22:37:15', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-07-11 22:37:15', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-07-11 22:37:15', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-07-11 22:37:15', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-07-11 22:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '站点设置', 0, 0, 'project', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'dashboard', 'admin', '2025-07-13 18:08:53', 'admin', '2025-07-13 18:09:31', '');
INSERT INTO `sys_menu` VALUES (2001, '博客管理', 2000, 1, 'blog', 'LeeSite/blog/index', NULL, '', 1, 0, 'C', '0', '0', '', 'textarea', 'admin', '2025-07-13 18:11:06', 'admin', '2025-07-18 21:55:37', '');
INSERT INTO `sys_menu` VALUES (2002, '留言管理', 2000, 2, 'comment', 'LeeSite/comment/index', NULL, '', 1, 0, 'C', '0', '0', '', 'documentation', 'admin', '2025-07-17 13:25:01', 'admin', '2025-07-18 21:55:44', '');
INSERT INTO `sys_menu` VALUES (2003, '项目管理', 2000, 3, 'project', 'LeeSite/project/index', NULL, '', 1, 0, 'C', '0', '0', '', 'example', 'admin', '2025-07-18 21:56:48', 'admin', '2025-07-18 21:57:08', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-07-11 22:37:17', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-07-11 22:37:17', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 223 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"lee_article\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-13 16:20:43', 83);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"lee_article\"}', NULL, 0, NULL, '2025-07-13 17:56:05', 34);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"站点设置\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"asd\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-13 18:08:53', 43);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-07-13 18:08:53\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"站点设置\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-13 18:09:21', 50);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-07-13 18:08:53\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"站点设置\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-13 18:09:31', 47);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"project/blog/index\",\"createBy\":\"admin\",\"icon\":\"textarea\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"博客管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"blog\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-13 18:11:06', 39);
INSERT INTO `sys_oper_log` VALUES (106, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"123\",\"params\":{},\"remark\":\"asd\",\"summary\":\"123\",\"title\":\"test\",\"url\":\"test\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/lee/mapper/LeeArticleMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeArticleMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2025-07-14 14:58:19', 40);
INSERT INTO `sys_oper_log` VALUES (107, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"123\",\"params\":{},\"remark\":\"123\",\"summary\":\"123\",\"title\":\"test\",\"url\":\"test\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.\r\n### The error may exist in com/ruoyi/lee/mapper/LeeArticleMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeArticleMapper.insert\r\n### The error occurred while executing an update\r\n### Cause: java.lang.IllegalStateException: Type handler was null on parameter mapping for property \'params\'. It was either not specified and/or could not be found for the javaType (java.util.Map) : jdbcType (null) combination.', '2025-07-14 15:01:10', 4);
INSERT INTO `sys_oper_log` VALUES (108, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"123213\",\"params\":{},\"remark\":\"213213\",\"summary\":\"123213\",\"title\":\"21313\",\"url\":\"21313\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_by\' doesn\'t have a default value\r\n### The error may exist in com/ruoyi/lee/mapper/LeeArticleMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeArticleMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lee_article  ( summary, remark,  title, url, cover,    category )  VALUES  ( ?, ?,  ?, ?, ?,    ? )\r\n### Cause: java.sql.SQLException: Field \'create_by\' doesn\'t have a default value\n; Field \'create_by\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_by\' doesn\'t have a default value', '2025-07-14 15:04:33', 108);
INSERT INTO `sys_oper_log` VALUES (109, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"java\",\"cover\":\"213\",\"params\":{},\"remark\":\"123\",\"summary\":\"213\",\"title\":\"213\",\"url\":\"213\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no setter for property named \'create_time\' in \'class com.ruoyi.lee.domain.LeeArticle\'', '2025-07-14 15:51:26', 25);
INSERT INTO `sys_oper_log` VALUES (110, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"java\",\"cover\":\"213\",\"params\":{},\"remark\":\"123\",\"summary\":\"213\",\"title\":\"213\",\"url\":\"213\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no setter for property named \'create_time\' in \'class com.ruoyi.lee.domain.LeeArticle\'', '2025-07-14 15:55:24', 22);
INSERT INTO `sys_oper_log` VALUES (111, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"java\",\"cover\":\"213\",\"params\":{},\"remark\":\"123\",\"summary\":\"213\",\"title\":\"213\",\"url\":\"213\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no setter for property named \'create_time\' in \'class com.ruoyi.lee.domain.LeeArticle\'', '2025-07-14 15:57:29', 38);
INSERT INTO `sys_oper_log` VALUES (112, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"java\",\"cover\":\"213\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 16:01:24\",\"params\":{},\"remark\":\"123\",\"summary\":\"213\",\"title\":\"213\",\"url\":\"213\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'status\' doesn\'t have a default value\r\n### The error may exist in com/ruoyi/lee/mapper/LeeArticleMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeArticleMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lee_article  ( summary, remark,  title, url, cover, create_by,  create_time, category )  VALUES  ( ?, ?,  ?, ?, ?, ?,  ?, ? )\r\n### Cause: java.sql.SQLException: Field \'status\' doesn\'t have a default value\n; Field \'status\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'status\' doesn\'t have a default value', '2025-07-14 16:01:24', 48);
INSERT INTO `sys_oper_log` VALUES (113, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"java\",\"cover\":\"213\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 16:05:47\",\"id\":1,\"params\":{},\"remark\":\"123\",\"status\":0,\"summary\":\"213\",\"title\":\"213\",\"url\":\"213\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 16:05:47', 70);
INSERT INTO `sys_oper_log` VALUES (114, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://i-blog.csdnimg.cn/direct/ff0d1c0839fb4be7a28a594cd589cc0e.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:57\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 17:44:57', 82);
INSERT INTO `sys_oper_log` VALUES (115, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://i-blog.csdnimg.cn/direct/ff0d1c0839fb4be7a28a594cd589cc0e.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:58\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"updateBy\":\"admin\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'updateTime\' not found. Available parameters are [param1, et]', '2025-07-14 17:48:12', 11);
INSERT INTO `sys_oper_log` VALUES (116, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://i-blog.csdnimg.cn/direct/ff0d1c0839fb4be7a28a594cd589cc0e.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:58\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"updateBy\":\"admin\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'updateTime\' not found. Available parameters are [param1, et]', '2025-07-14 17:57:31', 30);
INSERT INTO `sys_oper_log` VALUES (117, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://i-blog.csdnimg.cn/direct/ff0d1c0839fb4be7a28a594cd589cc0e.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:58\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"updateBy\":\"admin\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'updateTime\' not found. Available parameters are [param1, et]', '2025-07-14 18:03:57', 5);
INSERT INTO `sys_oper_log` VALUES (118, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://i-blog.csdnimg.cn/direct/ff0d1c0839fb4be7a28a594cd589cc0e.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:58\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"updateBy\":\"admin\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'updateTime\' not found. Available parameters are [param1, et]', '2025-07-14 18:06:12', 28);
INSERT INTO `sys_oper_log` VALUES (119, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://i-blog.csdnimg.cn/direct/ff0d1c0839fb4be7a28a594cd589cc0e.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:58\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-14 18:13:34\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 18:13:34', 66);
INSERT INTO `sys_oper_log` VALUES (120, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/2kmL/1440X839/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 17:44:58\",\"id\":2,\"params\":{},\"status\":0,\"summary\":\"开始自己动手实现一个简单地RAG\",\"title\":\"6.0 手动实现一个RAG工程开始\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-14 18:13:35\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148999508?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 18:28:45', 48);
INSERT INTO `sys_oper_log` VALUES (121, '站点博客列', 3, 'com.ruoyi.web.controller.site.LeeArticleController.remove()', 'DELETE', 1, 'admin', '研发部门', '/LeeSite/article/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 19:47:24', 44);
INSERT INTO `sys_oper_log` VALUES (122, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"博文状态\",\"dictType\":\"site_article_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:02:47', 47);
INSERT INTO `sys_oper_log` VALUES (123, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"隐藏\",\"dictSort\":0,\"dictType\":\"site_article_status\",\"dictValue\":\"0\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:03:50', 46);
INSERT INTO `sys_oper_log` VALUES (124, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"公开\",\"dictSort\":0,\"dictType\":\"site_article_status\",\"dictValue\":\"1\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:04:12', 45);
INSERT INTO `sys_oper_log` VALUES (125, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"删除\",\"dictSort\":0,\"dictType\":\"site_article_status\",\"dictValue\":\"100\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:04:27', 31);
INSERT INTO `sys_oper_log` VALUES (126, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:03:50\",\"default\":false,\"dictCode\":100,\"dictLabel\":\"隐藏\",\"dictSort\":0,\"dictType\":\"site_article_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:04:38', 47);
INSERT INTO `sys_oper_log` VALUES (127, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:04:26\",\"default\":false,\"dictCode\":102,\"dictLabel\":\"删除\",\"dictSort\":0,\"dictType\":\"site_article_status\",\"dictValue\":\"100\",\"isDefault\":\"N\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:04:49', 46);
INSERT INTO `sys_oper_log` VALUES (128, '字典类型', 9, 'com.ruoyi.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:04:53', 114);
INSERT INTO `sys_oper_log` VALUES (129, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":107,\"deptName\":\"运维部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":5,\"params\":{},\"parentId\":101,\"parentName\":\"深圳总公司\",\"phone\":\"15888888888\",\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:07:43', 40);
INSERT INTO `sys_oper_log` VALUES (130, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":107,\"deptName\":\"运维部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":5,\"params\":{},\"parentId\":101,\"parentName\":\"深圳总公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:07:46', 47);
INSERT INTO `sys_oper_log` VALUES (131, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://picx.zhimg.com/v2-93f2dc6f416063d069944eba49030803_r.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:26:20\",\"id\":3,\"params\":{},\"status\":0,\"summary\":\"实现了一个Embeding模块\",\"title\":\"6.1 实现Embeding模块\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/149027973?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:26:20', 49);
INSERT INTO `sys_oper_log` VALUES (132, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:28:27\",\"id\":4,\"params\":{},\"status\":0,\"summary\":\"完成资料的加载和切分的工具，完成简易的向量数据库\",\"title\":\"6.2 实现文档加载和切分和简易向量数据库的功能\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/149054143?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:28:27', 32);
INSERT INTO `sys_oper_log` VALUES (133, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/t4vt/818X762/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:30:03\",\"id\":5,\"params\":{},\"status\":0,\"summary\":\"完成pytorch手写预测\",\"title\":\"1. pytorch手写数字预测\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148344780?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:30:03', 32);
INSERT INTO `sys_oper_log` VALUES (134, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"project\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/8C5l/502X582/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:31:16\",\"id\":6,\"params\":{},\"status\":0,\"summary\":\"使用pyqt来作为GUI实现手写数字预测\",\"title\":\"2. 手写数字预测 gui版\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148352169?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:31:16', 38);
INSERT INTO `sys_oper_log` VALUES (135, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/QIzS/847X783/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:40:27\",\"id\":7,\"params\":{},\"status\":0,\"title\":\"3 mnist gan小试牛刀\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148587180?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-14 23:40:27', 89);
INSERT INTO `sys_oper_log` VALUES (136, '站点博客列', 1, 'com.ruoyi.web.controller.site.LeeArticleController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250715/TCgJ/987X990/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-15 00:03:27\",\"id\":8,\"params\":{},\"status\":0,\"summary\":\"cgan\",\"title\":\"4 mnist cgan生成指定图像\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148738971?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 00:03:27', 40);
INSERT INTO `sys_oper_log` VALUES (137, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250714/QIzS/847X783/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-14 23:40:28\",\"id\":7,\"params\":{},\"status\":0,\"summary\":\"手写gan\",\"title\":\"3 mnist gan小试牛刀\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 11:06:52\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148587180?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 11:06:53', 72);
INSERT INTO `sys_oper_log` VALUES (138, '站点博客列', 2, 'com.ruoyi.web.controller.site.LeeArticleController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article', '127.0.0.1', '内网IP', '{\"category\":\"python\",\"cover\":\"https://tc.z.wiki/autoupload/f/p1xbiZaWAoHAPXZdQlp9qcwntDfOTgKSzo0g8H84d86yl5f0KlZfm6UsKj-HyTuv/20250715/TCgJ/987X990/image.png\",\"createBy\":\"admin\",\"createTime\":\"2025-07-15 00:03:27\",\"id\":8,\"params\":{},\"status\":0,\"summary\":\"手写cgan\",\"title\":\"4 mnist cgan生成指定图像\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 11:07:02\",\"url\":\"https://blog.csdn.net/Leezed525/article/details/148738971?spm=1001.2014.3001.5501\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 11:07:02', 33);
INSERT INTO `sys_oper_log` VALUES (139, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":2,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:11:03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:11:03', 66);
INSERT INTO `sys_oper_log` VALUES (140, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":3,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:18:53\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:18:53', 69);
INSERT INTO `sys_oper_log` VALUES (141, '站点博客列', 11, 'com.ruoyi.web.controller.site.LeeArticleController.hide()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/hide/', '127.0.0.1', '内网IP', '{\"id\":3,\"params\":{},\"status\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:18:55\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:18:55', 31);
INSERT INTO `sys_oper_log` VALUES (142, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":3,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:18:57\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:18:57', 37);
INSERT INTO `sys_oper_log` VALUES (143, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:18:58\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:18:58', 36);
INSERT INTO `sys_oper_log` VALUES (144, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":5,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:19:01\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:19:02', 36);
INSERT INTO `sys_oper_log` VALUES (145, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":6,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:19:03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:19:03', 36);
INSERT INTO `sys_oper_log` VALUES (146, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":7,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:19:07\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:19:07', 35);
INSERT INTO `sys_oper_log` VALUES (147, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":8,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:19:09\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:19:09', 33);
INSERT INTO `sys_oper_log` VALUES (148, '站点博客列', 11, 'com.ruoyi.web.controller.site.LeeArticleController.hide()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/hide/', '127.0.0.1', '内网IP', '{\"id\":8,\"params\":{},\"status\":0,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:19:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:19:13', 33);
INSERT INTO `sys_oper_log` VALUES (149, '站点博客列', 10, 'com.ruoyi.web.controller.site.LeeArticleController.publish()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/article/publish/', '127.0.0.1', '内网IP', '{\"id\":8,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-15 16:19:15\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:19:15', 41);
INSERT INTO `sys_oper_log` VALUES (150, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"前台站点访问用户\",\"roleId\":100,\"roleKey\":\"visitor\",\"roleName\":\"房客\",\"roleSort\":4,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:55:44', 72);
INSERT INTO `sys_oper_log` VALUES (151, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-07-15 16:55:44\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"前台站点访问用户\",\"roleId\":100,\"roleKey\":\"visitor\",\"roleName\":\"访客\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 16:56:05', 153);
INSERT INTO `sys_oper_log` VALUES (152, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"LeeSite\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 18:21:25', 50);
INSERT INTO `sys_oper_log` VALUES (153, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"前台站点\",\"orderNum\":3,\"params\":{},\"parentId\":100,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-15 18:22:54', 35);
INSERT INTO `sys_oper_log` VALUES (154, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"lee_comment\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 13:10:43', 89);
INSERT INTO `sys_oper_log` VALUES (155, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"comment\",\"className\":\"LeeComment\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":13,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 13:10:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PreId\",\"columnComment\":\"上级留言\",\"columnId\":14,\"columnName\":\"pre_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 13:10:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"preId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"留言内容\",\"columnId\":15,\"columnName\":\"content\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 13:10:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"editor\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"content\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态\",\"columnId\":16,\"columnName\":\"status\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-07-17 13:10:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"status\",\"javaType\":\"Long\",\"list\":t', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 13:11:49', 64);
INSERT INTO `sys_oper_log` VALUES (156, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"lee_comment\"}', NULL, 0, NULL, '2025-07-17 13:11:52', 212);
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"project/comment/index\",\"createBy\":\"admin\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"留言管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"comment\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 13:25:01', 45);
INSERT INTO `sys_oper_log` VALUES (158, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"留言状态\",\"dictType\":\"site_comment_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 14:19:45', 52);
INSERT INTO `sys_oper_log` VALUES (159, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审核中\",\"dictSort\":0,\"dictType\":\"site_comment_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 14:20:17', 49);
INSERT INTO `sys_oper_log` VALUES (160, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"公开\",\"dictSort\":0,\"dictType\":\"site_comment_status\",\"dictValue\":\"1\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 14:20:39', 59);
INSERT INTO `sys_oper_log` VALUES (161, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-17 14:20:17\",\"default\":false,\"dictCode\":103,\"dictLabel\":\"审核中\",\"dictSort\":0,\"dictType\":\"site_comment_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 14:20:45', 40);
INSERT INTO `sys_oper_log` VALUES (162, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审核不通过\",\"dictSort\":0,\"dictType\":\"site_comment_status\",\"dictValue\":\"2\",\"listClass\":\"danger\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 14:21:04', 36);
INSERT INTO `sys_oper_log` VALUES (163, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"2312321321312\",\"params\":{},\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'root\' doesn\'t have a default value\r\n### The error may exist in com/ruoyi/lee/mapper/LeeCommentMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeCommentMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lee_comment  ( content, status,  author_id )  VALUES  ( ?, ?,  ? )\r\n### Cause: java.sql.SQLException: Field \'root\' doesn\'t have a default value\n; Field \'root\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'root\' doesn\'t have a default value', '2025-07-17 17:19:57', 118);
INSERT INTO `sys_oper_log` VALUES (164, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"2312321321312\",\"params\":{},\"root\":\"1\",\"status\":0}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'create_by\' doesn\'t have a default value\r\n### The error may exist in com/ruoyi/lee/mapper/LeeCommentMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeCommentMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lee_comment  ( content, status, root, author_id )  VALUES  ( ?, ?, ?, ? )\r\n### Cause: java.sql.SQLException: Field \'create_by\' doesn\'t have a default value\n; Field \'create_by\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'create_by\' doesn\'t have a default value', '2025-07-17 17:23:41', 61);
INSERT INTO `sys_oper_log` VALUES (165, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"2312321321312\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-17 17:24:36\",\"id\":1,\"params\":{},\"root\":\"1\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 17:24:36', 54);
INSERT INTO `sys_oper_log` VALUES (166, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":1,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-17 23:27:02\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 23:27:02', 67);
INSERT INTO `sys_oper_log` VALUES (167, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":1,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-17 23:28:07\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 23:28:07', 37);
INSERT INTO `sys_oper_log` VALUES (168, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":1,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-17 23:29:02\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 23:29:02', 38);
INSERT INTO `sys_oper_log` VALUES (169, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":1,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-17 23:29:28\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-17 23:29:28', 27);
INSERT INTO `sys_oper_log` VALUES (170, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"1234\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-18 13:22:40\",\"id\":2,\"params\":{},\"preId\":1,\"root\":\"0\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:22:40', 74);
INSERT INTO `sys_oper_log` VALUES (171, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":2,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:23:57\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:23:57', 32);
INSERT INTO `sys_oper_log` VALUES (172, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":2,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:26:35\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:26:35', 28);
INSERT INTO `sys_oper_log` VALUES (173, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":2,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:26:49\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:26:49', 23);
INSERT INTO `sys_oper_log` VALUES (174, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":2,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:27:14\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:27:14', 25);
INSERT INTO `sys_oper_log` VALUES (175, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"5678\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-18 13:27:21\",\"id\":3,\"params\":{},\"preId\":1,\"root\":\"0\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:27:21', 31);
INSERT INTO `sys_oper_log` VALUES (176, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":3,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:27:50\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:27:50', 24);
INSERT INTO `sys_oper_log` VALUES (177, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"test\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-18 13:28:13\",\"id\":4,\"params\":{},\"preId\":1,\"root\":\"0\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:28:13', 37);
INSERT INTO `sys_oper_log` VALUES (178, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:28:32\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:28:32', 27);
INSERT INTO `sys_oper_log` VALUES (179, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:03', 33);
INSERT INTO `sys_oper_log` VALUES (180, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:06\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:06', 24);
INSERT INTO `sys_oper_log` VALUES (181, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:09\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:09', 25);
INSERT INTO `sys_oper_log` VALUES (182, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:16\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:16', 21);
INSERT INTO `sys_oper_log` VALUES (183, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:30\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:30', 27);
INSERT INTO `sys_oper_log` VALUES (184, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditFail()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/fail', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":2,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:32\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:32', 24);
INSERT INTO `sys_oper_log` VALUES (185, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":4,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:34', 27);
INSERT INTO `sys_oper_log` VALUES (186, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"你好\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-18 13:29:46\",\"id\":5,\"params\":{},\"root\":\"1\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:46', 34);
INSERT INTO `sys_oper_log` VALUES (187, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":5,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:29:56\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:29:56', 35);
INSERT INTO `sys_oper_log` VALUES (188, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"谢谢你\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-18 13:30:07\",\"id\":6,\"params\":{},\"preId\":5,\"root\":\"0\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:30:07', 25);
INSERT INTO `sys_oper_log` VALUES (189, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":6,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 13:30:12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 13:30:12', 17);
INSERT INTO `sys_oper_log` VALUES (190, '留言板', 3, 'com.ruoyi.web.controller.site.LeeCommentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/LeeSite/comment/6,1', '127.0.0.1', '内网IP', '[6,1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 16:26:27', 85);
INSERT INTO `sys_oper_log` VALUES (191, '留言板', 3, 'com.ruoyi.web.controller.site.LeeCommentController.remove()', 'DELETE', 1, 'admin', '研发部门', '/LeeSite/comment/5', '127.0.0.1', '内网IP', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 16:27:00', 39);
INSERT INTO `sys_oper_log` VALUES (192, '留言板', 1, 'com.ruoyi.web.controller.front.CommentController.add()', 'POST', 1, 'leezed', '前台站点', '/front/comment/add', '127.0.0.1', '内网IP', '{\"authorId\":100,\"content\":\"您好，欢迎您来到我的站点\",\"createBy\":\"leezed\",\"createTime\":\"2025-07-18 16:27:34\",\"id\":7,\"params\":{},\"root\":\"1\",\"status\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 16:27:34', 28);
INSERT INTO `sys_oper_log` VALUES (193, '留言板', 2, 'com.ruoyi.web.controller.site.LeeCommentController.auditSuccess()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/comment/audit/success', '127.0.0.1', '内网IP', '{\"id\":7,\"params\":{},\"status\":1,\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 16:31:24\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 16:31:24', 34);
INSERT INTO `sys_oper_log` VALUES (194, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"lee_project\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 21:49:35', 113);
INSERT INTO `sys_oper_log` VALUES (195, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"project\",\"className\":\"LeeProject\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-07-18 21:49:35\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"项目名称\",\"columnId\":26,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-18 21:49:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"项目描述\",\"columnId\":27,\"columnName\":\"description\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-18 21:49:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Status\",\"columnComment\":\"状态\",\"columnId\":28,\"columnName\":\"status\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-07-18 21:49:35\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"status\",\"j', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 21:50:04', 53);
INSERT INTO `sys_oper_log` VALUES (196, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"lee_project\"}', NULL, 0, NULL, '2025-07-18 21:50:13', 156);
INSERT INTO `sys_oper_log` VALUES (197, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"LeeSite/blog/index\",\"createTime\":\"2025-07-13 18:11:06\",\"icon\":\"textarea\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"博客管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"blog\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 21:55:37', 71);
INSERT INTO `sys_oper_log` VALUES (198, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"LeeSite/comment/index\",\"createTime\":\"2025-07-17 13:25:01\",\"icon\":\"documentation\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"留言管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"comment\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 21:55:44', 33);
INSERT INTO `sys_oper_log` VALUES (199, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"LeeSite\\\\project\\\\index\",\"createBy\":\"admin\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"项目管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 21:56:48', 47);
INSERT INTO `sys_oper_log` VALUES (200, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"LeeSite/project/index\",\"createTime\":\"2025-07-18 21:56:48\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"项目管理\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2000,\"path\":\"project\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 21:57:08', 35);
INSERT INTO `sys_oper_log` VALUES (201, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"项目状态\",\"dictType\":\"site_project_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:08:35', 52);
INSERT INTO `sys_oper_log` VALUES (202, '项目', 1, 'com.ruoyi.web.controller.front.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 22:27:06\",\"description\":\"Springboot + vue + mybatis + shiro + redis MhtEnglish  项目特色：\\n1. 自定义日志系统\\n2. 自定义mysql二级缓存\\n\",\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/kzaw/1825X956/image.png\",\"link\":\"https://github.com/Leezed525/Springboot-vue-MhtEnglish\",\"params\":{},\"title\":\"MHTEnglish小程序加管理页面\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'status\' doesn\'t have a default value\r\n### The error may exist in com/ruoyi/lee/mapper/LeeProjectMapper.java (best guess)\r\n### The error may involve com.ruoyi.lee.mapper.LeeProjectMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO lee_project  ( title, description,  link, image, create_by, create_time, update_by, update_time )  VALUES  ( ?, ?,  ?, ?, ?, ?, ?, ? )\r\n### Cause: java.sql.SQLException: Field \'status\' doesn\'t have a default value\n; Field \'status\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'status\' doesn\'t have a default value', '2025-07-18 22:27:06', 94);
INSERT INTO `sys_oper_log` VALUES (203, '项目', 1, 'com.ruoyi.web.controller.front.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 22:28:35\",\"description\":\"Springboot + vue + mybatis + shiro + redis MhtEnglish  项目特色：\\n1. 自定义日志系统\\n2. 自定义mysql二级缓存\\n\",\"id\":1,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/kzaw/1825X956/image.png\",\"link\":\"https://github.com/Leezed525/Springboot-vue-MhtEnglish\",\"params\":{},\"status\":2,\"title\":\"MHTEnglish小程序加管理页面\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:28:35', 62);
INSERT INTO `sys_oper_log` VALUES (204, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"计划中\",\"dictSort\":0,\"dictType\":\"site_project_status\",\"dictValue\":\"0\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:34:01', 50);
INSERT INTO `sys_oper_log` VALUES (205, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"开发中\",\"dictSort\":0,\"dictType\":\"site_project_status\",\"dictValue\":\"1\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:34:14', 51);
INSERT INTO `sys_oper_log` VALUES (206, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已完成\",\"dictSort\":0,\"dictType\":\"site_project_status\",\"dictValue\":\"2\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:34:37', 47);
INSERT INTO `sys_oper_log` VALUES (207, '项目', 1, 'com.ruoyi.web.controller.front.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 22:49:17\",\"id\":2,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/FiEu/1161X645/image.png\",\"link\":\"https://github.com/Leezed525/cs231n-assignment123-answer\",\"params\":{},\"status\":2,\"title\":\"cs231n 全套解答\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:49:17', 76);
INSERT INTO `sys_oper_log` VALUES (208, '项目', 2, 'com.ruoyi.web.controller.front.LeeProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 22:49:18\",\"description\":\"CS231n是斯坦福大学开设的深度学习与计算机视觉课程，专注于卷积神经网络（CNN）及其在图像识别、目标检测等领域的应用。课程内容涵盖深度学习基础、CNN架构、优化方法、经典网络模型（如AlexNet、ResNet）、以及前沿应用（如图像字幕生成、GAN等）。课程通过理论讲解、编程作业和项目实践，帮助学生掌握计算机视觉核心技术和深度学习模型的搭建与优化。课程适合有一定机器学习基础和Python编程能力的学习者，旨在培养其解决实际视觉问题的能力。\",\"id\":2,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/FiEu/1161X645/image.png\",\"link\":\"https://github.com/Leezed525/cs231n-assignment123-answer\",\"params\":{},\"status\":2,\"title\":\"cs231n 全套解答\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-18 22:50:30\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 22:50:30', 48);
INSERT INTO `sys_oper_log` VALUES (209, '项目', 1, 'com.ruoyi.web.controller.front.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 23:38:28\",\"description\":\"自己爬百度网盘爬出来的10000+英语单词数据库，公益项目（含释义音标词性等）\",\"id\":3,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/GCbx/843X283/image.png\",\"link\":\"https://github.com/Leezed525/EnglishDataBase\",\"params\":{},\"status\":2,\"title\":\"英语单词10000+数据库\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 23:38:29', 31);
INSERT INTO `sys_oper_log` VALUES (210, '项目', 1, 'com.ruoyi.web.controller.front.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 23:51:52\",\"description\":\"rust语言写的多线程端口探测器，目前可以做到两分钟左右扫描完一个ip的所有端口，还没写完，后续还有很多可以优化的地方，更新中\",\"id\":4,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/BZqr/1117X614/image.png\",\"link\":\"https://github.com/Leezed525/rust_port_scan\",\"params\":{},\"status\":1,\"title\":\"Rust_Port_Scan\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-18 23:51:52', 34);
INSERT INTO `sys_oper_log` VALUES (211, '项目', 1, 'com.ruoyi.web.controller.site.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-19 17:26:17\",\"description\":\"提出三分支打分掩码跟踪框架。1）提出可靠性分数掩码模块，计算多模态数据间的可靠性，增强多\\n模态数据特征；2）提出Drop Key 微调范式，在几乎不增加参数量的基础上提升多模态模型的鲁棒\\n性；3）引入sigma模块进行数据交互，提升跟踪表现；4）提出三路模型架构，不干扰各个模态数\\n据特征提取的过程，提取出各自模态的关键特征。 \",\"id\":5,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250719/3OB6/1479X660/image.png\",\"link\":\"https://github.com/Leezed525/SMSTracker\",\"orderNum\":0,\"params\":{},\"status\":2,\"title\":\"SMSTracker: Tri-path Score Mask Sigma Fusion for Multi-Modal Tracking [iccv2025]\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 17:26:17', 67);
INSERT INTO `sys_oper_log` VALUES (212, '项目', 2, 'com.ruoyi.web.controller.site.LeeProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-18 23:51:52\",\"description\":\"rust语言写的多线程端口探测器，目前可以做到两分钟左右扫描完一个ip的所有端口，还没写完，后续还有很多可以优化的地方，更新中\",\"id\":4,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250718/BZqr/1117X614/image.png\",\"link\":\"https://github.com/Leezed525/rust_port_scan\",\"orderNum\":2,\"params\":{},\"status\":1,\"title\":\"Rust_Port_Scan\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-19 17:28:19\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 17:28:19', 45);
INSERT INTO `sys_oper_log` VALUES (213, '项目', 2, 'com.ruoyi.web.controller.site.LeeProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-19 17:26:17\",\"description\":\"提出三分支打分掩码跟踪框架。1）提出可靠性分数掩码模块，计算多模态数据间的可靠性，增强多模态数据特征；2）提出Drop Key 微调范式，在几乎不增加参数量的基础上提升多模态模型的鲁棒性；3）引入sigma模块进行数据交互，提升跟踪表现；4）提出三路模型架构，不干扰各个模态数据特征提取的过程，提取出各自模态的关键特征。 \",\"id\":5,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250719/3OB6/1479X660/image.png\",\"link\":\"https://github.com/Leezed525/SMSTracker\",\"orderNum\":0,\"params\":{},\"status\":2,\"title\":\"SMSTracker: Tri-path Score Mask Sigma Fusion for Multi-Modal Tracking [iccv2025]\",\"updateBy\":\"admin\",\"updateTime\":\"2025-07-19 17:34:10\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 17:34:10', 40);
INSERT INTO `sys_oper_log` VALUES (214, '项目', 1, 'com.ruoyi.web.controller.site.LeeProjectController.add()', 'POST', 1, 'admin', '研发部门', '/LeeSite/project', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-07-19 17:41:02\",\"description\":\"主要是包含一些使用pytorch编写的轻量级神经网络应用，包括：\\n1. gan系列\\n2. 手写数字预测以及gui封装\\n3. 一些杂七杂八的pytorch小玩具\",\"id\":6,\"image\":\"https://tc.z.wiki/autoupload/f/Ip5seilHYD23S7yVjUmBP7KXl_QqVl-bpSwqP4fJO68/20250719/RRyq/284X238/image.png\",\"link\":\"https://github.com/Leezed525/pytorch_toy\",\"orderNum\":6,\"params\":{},\"status\":1,\"title\":\"pytorch_toy\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 17:41:02', 38);
INSERT INTO `sys_oper_log` VALUES (215, '用户管理', 2, 'com.ruoyi.web.controller.front.UserController.resetPwd()', 'PUT', 1, 'leezed', '前台站点', '/front/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"leezed525@qq.com\",\"params\":{}}', '{\"msg\":\"只能重置自己的密码\",\"code\":500}', 0, NULL, '2025-07-19 22:51:24', 4);
INSERT INTO `sys_oper_log` VALUES (216, '用户管理', 2, 'com.ruoyi.web.controller.front.UserController.resetPwd()', 'PUT', 1, 'leezed', '前台站点', '/front/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"leezed525@qq.com\",\"params\":{}}', '{\"msg\":\"只能重置自己的密码\",\"code\":500}', 0, NULL, '2025-07-19 22:55:13', 8);
INSERT INTO `sys_oper_log` VALUES (217, '用户管理', 2, 'com.ruoyi.web.controller.front.UserController.resetPwd()', 'PUT', 1, 'leezed', '前台站点', '/front/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"leezed525@qq.com\",\"params\":{},\"updateBy\":\"leezed\",\"userName\":\"leezed\"}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-07-19 22:56:47', 97);
INSERT INTO `sys_oper_log` VALUES (218, '用户管理', 2, 'com.ruoyi.web.controller.front.UserController.resetPwd()', 'PUT', 1, 'leezed', '前台站点', '/front/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"leezed\",\"userId\":100,\"userName\":\"leezed\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-19 22:57:38', 91);
INSERT INTO `sys_oper_log` VALUES (219, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 09:50:51', 47);
INSERT INTO `sys_oper_log` VALUES (220, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"理智点\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 09:51:00', 41);
INSERT INTO `sys_oper_log` VALUES (221, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 09:51:20', 204);
INSERT INTO `sys_oper_log` VALUES (222, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 09:51:48', 199);
INSERT INTO `sys_oper_log` VALUES (223, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updatePwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile/updatePwd', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-28 10:34:32', 296);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-07-11 22:37:14', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-07-11 22:37:14', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-07-11 22:37:14', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-07-11 22:37:14', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-07-11 22:37:14', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '访客', 'visitor', 4, '1', 1, 1, '0', '0', 'admin', '2025-07-15 16:55:44', 'admin', '2025-07-15 16:56:05', '前台站点访问用户');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '理智点', '00', 'ry@163.com', '15888888888', '0', '', '$2a$10$tIsE1rkcgFNAqShaeCXo9O4Tmtja0LFEylBxh7QpmrdhUpYOKhhRO', '0', '0', '127.0.0.1', '2025-07-28 10:34:19', '2025-07-28 10:34:32', 'admin', '2025-07-11 22:37:14', '', '2025-07-28 10:34:18', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-07-11 22:37:14', '2025-07-11 22:37:14', 'admin', '2025-07-11 22:37:14', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 200, 'leezed', '理智点', '00', 'leezed525@qq.com', '', '0', '', '$2a$10$tB3CHcLXMuJgv6LNjJbRLOczODJ9GUFzqsflbCszqDGpEHm4u64Ry', '0', '0', '127.0.0.1', '2025-08-29 21:52:37', NULL, 'register_user', '2025-07-17 12:02:12', 'leezed', '2025-08-29 21:52:37', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
