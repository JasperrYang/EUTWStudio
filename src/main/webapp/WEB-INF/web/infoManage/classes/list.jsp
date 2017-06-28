<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>

<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
</head>
<body>
<section class="larry-grid">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <%--<shiro:hasPermission name="classes:add">--%>
                <ul class="layui-tab-title">
                    <li class="layui-btn " onclick="classes.addManual()"><i class="layui-icon">&#xe61f;</i>添加班级
                    </li>
                </ul>
                <%--</shiro:hasPermission>--%>
            </blockquote>
            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>班级代码</th>
                            <th>名称</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="list">
                        </tbody>
                    </table>

                </div>
                <div id="demo1"></div>
            </div>
        </div>
    </div>
</section>
</body>
<%@include file="layer.jsp" %>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let classes;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        classes = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    curr: currentIndex,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            classes.list();
                        }
                    }
                });
            },
            list: function () {
                $.ajax({
                    url: baseUrl + "/classes/list",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            classes.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            addManual: function () {
                $.post(baseUrl + "/department/allDepartments", function (data) {
                    if (data.result) {
                        data = data.data;
                        let _html = "";
                        for (let i = 0; i < data.length; ++i) {
                            _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                        }
                        $("#department-add").html(_html);
                        form.render();
                        layer.open({
                            type: 1,
                            title: '添加'
                            , content: $("#add")
                        });
                    }
                });

            },
            update: function (id, level, name,departmentId) {
                $("#id").val(id);
                $("#level").val(level);
                $("#name").val(name);
                $.post(baseUrl + "/department/allDepartments", function (data) {
                    if (data.result) {
                        data = data.data;
                        let _html = "";
                        for (let i = 0; i < data.length; ++i) {
                            if(data[i].id == departmentId) {
                                _html += `<option selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                            }else{
                                _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                            }
                        }
                        $("#department-update").html(_html);
                        form.render();
                        layer.open({
                            type: 1,
                            title: '修改'
                            , content: $("#update")
                        });
                    }
                });

            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/classes/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 500);
                    })
                });
            },
            addManualAjax: function () {
                let data = $("#add-form").serialize();
                $.post(baseUrl + "/classes/addManual", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }
                })
            },
            updateAjax: function () {
                let data = $("#update-form").serialize();
                $.post(baseUrl + "/classes/update", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }

                })
            }
        };
        ;
        $(function () {
            classes.list();
        });
    })
    ;


</script>

</html>
