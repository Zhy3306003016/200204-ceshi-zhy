<%--
  Created by IntelliJ IDEA.
  User: 张海洋
  Date: 2022/4/15
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="https://www.layuicdn.com/layui/css/layui.css"/>
</head>
<body>

<form class="layui-form" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-inline">
            <input type="text" name="names" id="names" placeholder="请输入姓名" class="layui-input">
        </div>
        <div class="layui-inline">
            <button type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
        </div>
    </div>
</form>

<table class="layui-hide" id="test" lay-filter="test"></table>

<form class="layui-form" action="" id="empFrom" style="display: none">
    <div class="layui-form-item" style="display: none">
        <label class="layui-form-label">id</label>
        <div class="layui-input-block">
            <input type="text" name="id" id="id" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="name" id="name" lay-verify="title" autocomplete="off" placeholder="请输入姓名" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">年龄</label>
        <div class="layui-input-block">
            <input type="text" name="age" id="age" lay-verify="title" autocomplete="off" placeholder="请输入年龄" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <input type="text" name="sex" id="sex" lay-verify="title" autocomplete="off" placeholder="请输入性别" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input type="text" name="state" id="state" lay-verify="title" autocomplete="off" placeholder="请输入状态" class="layui-input">
        </div>
    </div>
    <div class="layui-inline">
        <button type="submit" class="layui-btn" lay-submit="" lay-filter="cjack">立即提交</button>
    </div>
</form>
</body>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="addEmp">增加</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
    <script src="https://www.layuicdn.com/layui/layui.js"></script>
</html>
<script type="text/javascript">
    layui.use(['table','jquery','form'], function(){
        var table = layui.table;
        var $ = layui.jquery;
        var form = layui.form;
        table.render({
            elem: '#test'
            ,url:'/emps'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: ['filter', 'exports', 'print', { //自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID'}
                ,{field:'name', title:'用户名'}
                ,{field:'sex', title:'性别'}
                ,{field:'age', title:'年龄'}
                ,{field:'state', title:'状态'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo'}
            ]]
            ,page: true
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.map.total, //解析数据长度
                    "data": res.map.records //解析数据列表
                };
            }
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'addEmp':
                    layer.open({
                        type: 1,
                        auto: '500px',
                        content: $("#empFrom"), //这里content是一个普通的String
                    });
                    break;
                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    $.ajax({
                        url:'/emps',
                        data:{
                            id: data.id,
                        },
                        type: 'Delete',
                        dataType:'json',
                        success:function (res){
                            //执行重载
                            table.reload('test', {
                                page: {
                                    curr: 1 //重新从第 1 页开始
                                },
                            });
                            return false;
                        }
                    })
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.open({
                    type: 1,
                    auto: '500px',
                    content: $("#empFrom"), //这里content是一个普通的String
                    success: function (res){
                        $("#id").val(data.id);
                        $("#name").val(data.name);
                        $("#sex").val(data.sex);
                        $("#age").val(data.age);
                        $("#state").val(data.state);
                }
                });
            }
        });
        //监听提交
        form.on('submit(demo1)', function(data){
            //执行重载
            table.reload('test', {
                page: {
                    curr: 1 //重新从第 1 页开始
                },
                where: {
                    name: $("#names").val(),
                }
            });
            return false;
        });
        //监听提交
        form.on('submit(cjack)', function(data){
            console.log(data)
            console.log(data.field)
            if(data.field.id == 0 || data.field.id == null){
                var m = 'POST'
            }else {
                var m = 'put'
            }
            $.ajax({
                url:'/emps',
                data:{
                    id : data.field.id,
                    name: data.field.name,
                    sex: data.field.sex,
                    age: data.field.age,
                    sex: data.field.sex,
                },
                type: m,
                dataType:'json',
                success:function (res){
                    $("#empFrom")[0].reset();
                    //执行重载
                    layer.closeAll();
                    table.reload('test', {
                        page: {
                            curr: 1 //重新从第 1 页开始
                        },
                    });

                }
            })
            return false;
        });
    });
</script>