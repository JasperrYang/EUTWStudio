<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../../public/tag.jsp" %>

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

    <blockquote class="layui-elem-quote mylog-info-tit">
        <button class="layui-btn">区</button>
        <button class="layui-btn">楼层</button>
        <button class="layui-btn">宿舍</button>
    </blockquote>

    <div class="larry-personal">
        <div class="layui-tab">
            <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">

                <blockquote class="layui-elem-quote mylog-info-tit">

                    <div class="layui-input-inline">
                        <label class="layui-form-label">区</label>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select name="modules" lay-filter="modules_1" lay-verify="required" lay-search=""
                                        id="queryAreas">
                                    <option value="">直接选择或搜索选择</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-input-inline">
                        <label class="layui-form-label">楼层</label>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select name="modules1" lay-filter="modules_2" lay-verify="required" lay-search=""
                                        id="queryFloors">
                                    <option value="">直接选择或搜索选择</option>
                                </select>
                            </div>
                            <a class="layui-btn" onclick="floor.list()"><i class="layui-icon">&#xe615;</i>搜索</a>
                        </div>
                    </div>

                </blockquote>
            </form>

            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <ul class="layui-tab-title">
                    <li class="layui-btn " onclick="floor.add()"><i class="layui-icon">&#xe61f;</i>添加楼层
                    </li>
                </ul>
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>区名称</th>
                            <th>楼层</th>
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
<%@ include file="layer.jsp" %>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let floor;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        floor = {
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
                            floor.list();
                        }
                    }
                });
            },
            list: function () {
                let areaId = $("#queryAreas").val();
                let floorId = $("#queryFloors").val();
                let areaName = $("#queryAreas").find("option:selected").text();
                let floorName = $("#queryFloors").find("option:selected").text();
                $.ajax({
                    url: baseUrl + "dorm/floor/list",
                    data: {
                        currentIndex: currentIndex,
                        pageSize: pageSize,
                        areaId:areaId,
                        floorId:floorId,
                        areaName:areaName,
                        floorName:floorName

                    },
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.data.pageUtil.currentIndex;
                            totalSize = data.data.pageUtil.totalSize;
                            floor.page();

                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            floor.loadSelectAreaHtml();
                            form.render();
                        }
                        $("#queryAreas").html(floor.loadDepartmentOrDirection(data.data.showAreaAndFloorInfos.queryAreaOfRoom),"-")
                        $("#queryFloors").html(floor.loadDepartmentOrDirection(data.data.showAreaAndFloorInfos.queryFloorOfRoom),"-")
                    }
                });
            },
            add: function () {
                layer.open({
                    type: 1,
                    area: ['390px', '260px'],
                    title: '添加'
                    , content: $("#add")
                });

            },
            addAjax: function () {
                let name = $("#addFloorName").val();
                var options = $("#showAreasAdd option:selected");
                var areaId = options.val();
                layer.confirm('确定添加？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/floor/add", {
                        name: name,
                        areaId:areaId
                    }, function (data) {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                })
            },
            update: function (id, name, areaName, area_id) {
                $("#updateFloorName").val(name);
                $("#updateFloorId").val(id);
                $("#updateShowAreas").val(areaName);
                $("#showAreasUpdates").html(floor.loadSelectAreaHtml(area_id));
                layer.open({
                    type: 1,
                    area: ["30%", "60%"],
                    title: '修改'
                    , content: $("#update")
                });
            },
            loadSelectAreaHtml: function (area_id) {
                let _html = "";
                $.post(baseUrl + "dorm/floor/selectArea", function (data) {
                    $("#showAreasUpdates").html(floor.loadDepartmentOrDirection(data.data.dormInfos,area_id))
                    laytpl($("#list-areas").text()).render(data, function (html) {
                        $("#showAreasAdd").html(html);
                    });
                    form.render();
                })

                return _html;
            },
            loadDepartmentOrDirection: function (data, selectId) {
                let _html = `<option value="">直接选择或搜索选择</option>`;
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/floor/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 400);
                    })
                });
            },
            updateAjax: function () {
                let name = $("#updateFloorName").val();
                let id = $("#updateFloorId").val();
                layer.confirm('确定修改？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/floor/update", {
                        name: name,
                        id: id
                    }, function (data) {
                        layer.msg(data.msg);

                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                })
            }
        };
        $(function () {
            floor.list();

            form.on('select(modules_1)', function (data) {
                var id = data.value;

                $.post(baseUrl + "dorm/room/showAreaAndFloorInfos", {areaId: data.value}, function (data) {
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom

                        $("#queryAreas").html(floor.loadDepartmentOrDirection(queryAreaOfRoom,id))
                        $("#queryFloors").html(floor.loadDepartmentOrDirection(queryFloorOfRoom), "-")
                        form.render();
                    }
                })
            })
        });
    });


</script>

<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form()
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });

        //监听指定开关
        form.on('switch(switchTest)', function (data) {
            layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
        });

        //监听提交
        form.on('submit(demo1)', function (data) {
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });


    });
</script>

</html>