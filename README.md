# Online_Course_Website

### 一、未登录用户
#### 注册
- 前端
  - 用户名、密码、重复输入密码和身份不能为空，为空会有提示。
  - 密码长度必须大于等于6位且不能为纯数字，小于6位或为纯数字会有提示。
  - 重复输入密码应相同，两次不相同会有提示。
- 后端
  - 用户名必须是系统中未存在的，已存在会返回注册页面并提示，且输入都清空。
  - 提交成功后，系统创建一个新用户并存入数据库，同时自动登录，进入邮箱页面。
#### 首页
- 热门课程轮播和最新课程展示，点击可进入相应课程的详情页面。
#### 搜索
- 可按照课程名称、课程简介或开课老师中的一项进行关键字搜索。
- 可根据课程的选课人数进行正排序或逆排序。
- 每个课程有选课和查看按钮，点击选课跳到注册页面，点击查看可进入相应课程的详情页面。
- 分页展示，每页至多九个课程。
#### 课程详情
- 课程的次级导航栏，有首页、资源、作业等按钮，点击无用。
- 课程的单元和知识点列表展示，点击无用。
- 选课按钮，点击后跳到注册页面。

### 二、已登录用户（课程学生角度）
#### 邮箱
- 前端
  - 邮箱输入不能为空，为空会有提示。
  - 邮箱输入必须符合邮箱格式，不符合格式会有提示。
- 后端
- 提交成功后，发送验证码到该邮箱，并进入验证页面。
#### 验证
- 前端
  - 验证码输入不能为空，为空会有提示。
  - 验证码输入必须是数字，不是数字会有提示。
- 后端
  - 验证码必须与系统发送的验证码相同，不同会返回验证页面并提示。
  - 提交成功后，进入首页页面。
#### 个人中心
- “我选的课”展示，可看到已选的课程，每门课有退课和查看按钮。
  - 点击查看可进入相应课程的详情页面。
  - 点击退课，需要确认并输入密码才能完成退课，并仍在个人中心页面。
  - 点击添加课程，则进入搜索页面。
- “我开的课”展示，可看到已开的课程，每门课有查看按钮。
  - 点击查看可进入相应课程的详情页面。
  - 点击新建课程，则进入课程开设页面。
  - 两个展示通过点击按钮切换。
#### 课程开设
- 前端
  - 课程名称、课程介绍和课程图片不能为空，为空会有提示。
- 后端
  - 课程名称必须是系统中未存在的，已存在会返回课程开设页面并提示，且输入都清空。
  - 新建成功后，系统创建一门新课程存入数据库，并进入个人中心“我开的课”页面。
  - 两个展示通过点击按钮切换。
#### 首页
  - 热门课程轮播和最新课程展示，点击可进入相应课程的详情页面。
#### 搜索
  - 可按照课程名称、课程简介或开课老师中的一项进行关键字搜索。
  - 可根据课程的选课人数进行正排序或逆排序。
  - 默认展示所有课程，且按照课程的选课人数进行正排序。
  - 每个课程有查看按钮，点击查看可进入相应课程的详情页面。
  - 如果已选某课程，则该课程没有选课按钮；如果没选某课程，则该课程有选课按钮，点击则跳到个人中心“我选的课”页面。
  - 分页展示，每页至多九个课程。
#### 课程详情
- 课程的次级导航栏，有首页、资源、作业等按钮，点击则跳到该课程的相应页面。
- 课程的单元和知识点列表展示。
- 如果已选该课程，点击知识点则跳到该课程的相应知识点页面。
- 如果没选该课程，点击知识点无用。
- 如果已选该课程，则该课程有退课按钮，点击则退课且仍在该课程详情页面；如果没选该课程，则该课程有选课按钮，点击则选课且仍在该课程详情页面。
#### 知识点
- 左侧展示该课程的单元和知识点列表，点击知识点则进入相应的知识点页面。
- 展示该知识点的PPT和视频。
#### 资源
- 展示该课程的资源，提供下载功能。
#### 作业
- 展示开课老师布置的作业列表，每个作业有查看按钮，点击则进入相应的作业详情页面。
- 作业详情
- 展示该作业的所有题目。
- 若未完成该作业，则可完成题目，有提交按钮。
- 若已完成该作业，则可看到自己的答案，单选题还可看到正确答案。

### 三、已登录用户（课程老师角度）
#### 课程详情
- 课程的次级导航栏，有首页、资源、作业等按钮，点击则跳到该课程的相应页面。
- 课程的单元和知识点列表展示，单元有修改单元和添加知识点按钮。
- 点击修改单元，则可修改单元名称，若重命名则有提示。
- 点击添加知识点，则可在该单元添加知识点名称。
- 有添加章节按钮，点击则可在该课程添加章节名称。
#### 知识点
- 左侧展示该课程的单元和知识点列表，点击知识点则进入相应的知识点页面。
- 知识点有修改按钮，点击则可修改知识点名称，若重命名则有提示。
- 知识点有上传按钮，点击则可上传视频或PPT。
- 知识点文件有修改按钮，点击则可修改该文件，若重上传则有提示。
#### 资源
- 展示该课程的资源，提供下载功能。
- 资源有上传按钮，点击则可上传资源。
- 每个资源有修改按钮，点击则可修改该文件，若重上传则有提示。
#### 作业
- 展示开课老师布置的作业列表，每个作业有查看和结果按钮。
- 点击查看，则进入相应的作业详情页面。
- 点击结果，则进入相应的作业结果页面。
- 作业有添加作业按钮，点击则可添加作业，重复添加则有提示。
#### 作业详情
- 展示该作业的所有题目。
- 有添加单选题和简答题按钮，点击则可添加相应题目。
- 每个题目有修改按钮，点击则可修改相应题目。
#### 作业结果
- 展示该作业的完成情况。
