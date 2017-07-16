<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <script src="${baseurl}/public/common/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
    <%--时间轴--%>
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/css/screen.css" type="text/css" media="screen">
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/css/responsive.css" type="text/css" media="screen">
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/inc/colorbox.css" type="text/css" media="screen">

</head>
<body>
<section class="larry-grid layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-inline">
                    <div class="layui-input-inline " style="width: auto ;margin-bottom: 10px;">
                        <select lay-filter="course" id="module_search">
                            <option value="">系</option>

                        </select>
                    </div>

                    <div class="layui-input-inline" style="width: auto;margin-bottom: 10px;">
                        <select lay-filter="profession" id="semester-search">
                            <option value="">年级</option>
                            

                        </select>
                    </div>

                    <div class="layui-input-inline" style="width: auto;margin-bottom: 10px;">
                        <select lay-filter="t_direction" id="findDirection">
                            <option value="">方向</option>


                        </select>
                    </div>

                    <div class="layui-input-inline" style="width: auto;margin-bottom: 10px;">
                        <select lay-filter="profession" id="queryClass">
                            <option value="">班级</option>


                        </select>
                    </div>
                    <div class="layui-input-inline" style="width: auto ;margin-bottom: 10px;">
                        <input type="text" name="title" id="name-search" lay-verify="title" autocomplete="off"
                               placeholder="学号" value="" class="layui-input">
                    </div>
                    <div class="layui-inline">
                        <div class="layui-input-inline" style="width: auto ;margin-bottom: 10px;">
                            <input type="text" name="title" id="name_search" lay-verify="title" autocomplete="off"
                                   placeholder="姓名" class="layui-input">
                        </div>
                    </div>
                </div>
                <br>
                <div class="layui-input-inline" style="width: auto ;margin-bottom: 10px;">
                    <select lay-filter="queryAreaOfRoom" id="queryAreaOfRoom">
                        <option value="">楼号</option>


                    </select>
                </div>
                <div class="layui-input-inline" style="width: auto ;margin-bottom: 10px;">
                    <select lay-filter="queryFloor" id="queryFloor">
                        <option value="">层号</option>


                    </select>
                </div>

                <div class="layui-inline">
                    <div class="layui-input-inline" style="width: auto ;margin-bottom: 10px;">
                        <input type="text" name="title" lay-verify="title" autocomplete="off"
                               placeholder="房间号码" class="layui-input">
                    </div>
                </div>
                <a class="layui-btn" style="width: auto ;margin-bottom: 10px;" onclick="communication.list()"><i
                        class="layui-icon">&#xe615;</i>搜索</a>


            </blockquote>
        </div>
        <div class="larry-separate"></div>
        <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
            <div class="layui-form">
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>方向</th>
                        <th>专业</th>
                        <th>班级</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="list">

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </div>
</section>
</body>

<%@include file="layer.jsp" %>
<script type="text/javascript" src="${baseurl}/public/css/timeAsix/inc/colorbox.js"></script>
<script type="text/javascript" src="${baseurl}/public/css/timeAsix/js/timeliner.min.js"></script>
<script>
    $(document).ready(function () {
        $.timeliner({
            startOpen: ['#19550828EX', '#19630828EX']
        });
        $.timeliner({
            timelineContainer: '#timelineContainer_2'
        });
        // Colorbox Modal
        $(".CBmodal").colorbox({
            inline: true,
            initialWidth: 100,
            maxWidth: 682,
            initialHeight: 100,
            transition: "elastic",
            speed: 750
        });
    });
</script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/html2canvas.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/jspdf.debug.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/renderPDF.js"></script>
<script type="text/javascript">
    let communication;
    let student;
    let no;
    layui.use(['jquery', 'layer', 'element', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        communication = {
            list: function () {
                let data = {
                    name: $("#name_search").val(),
                }
                $.ajax({
                    url: baseUrl + "/communication/list",
                    data: data,
                    type: "post",
                    success: function (data) {
                        if (data.result) {
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            add: function (studentNo) {
                $.post(baseUrl + "/studentClass/student", {studentNo: studentNo}, function (data) {
                    if (data.result) {
                        student = data.data;

                        $("#student_radio").prop({checked: true});
                        $(".no").val(student.no);
                        $("#studentName").val(student.name);
                        $("#talkName").text(student.name);
                        form.render();
                        layer.open({
                            type: 1,
                            title: '添加',
                            area: ["100%", "100%"]
                            , content: $("#add")
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                })

            },
            addAjax: function () {
                let no = $(".no").val();
                let direction = $("#direction").val();
                let talkName = $("#talkName").text();
                let contents = "";
                let contentNodes = $(".add-contents");
                for (let i = 0; i < contentNodes.length; ++i) {
                    contents += $(contentNodes[i]).val() + "$%$";
                }

                let data = {
                    "studentId": no,
                    "direction": direction,
                    "talkName": talkName,
                    "content": contents
                }
                $.post(baseUrl + "/communication/add", data, function (data) {
                    layer.msg(data.msg);
                    setTimeout("location.reload()", 500);
                })
            },
            updateAjax: function (data) {
                $.post(baseUrl + "/communication/updateContent", data, function (data) {
                    layer.msg(data.msg);
                })
            },
            updateContent: function (id, qaId) {
                let contents = "";
                let contentNodes = $("#id" + qaId + "EX").find(".update-contents");
                for (let i = 0; i < contentNodes.length; ++i) {
                    contents += $(contentNodes[i]).val() + "$%$";//Q&A 分隔符
                }
                let data = {
                    id: id,
                    content: contents
                }
                communication.updateAjax(data);
            },
            previewOrUpdate: function (name, studentNo, type) {
                $("#who").text(name);

                $.post(baseUrl + "/communication/communication", {studentNo: studentNo}, function (data) {
                    if (data.result) {
                        showCommunicationContents(data.data, type);
                        let title = null;
                        if (type === "preview") {
                            $("#printPDF").show();
                            title = "预览"
                        } else {
                            $("#printPDF").hide();
                            title = "修改"
                        }
                        layer.open({
                            type: 1,
                            title: title,
                            area: ["100%", "100%"]
                            , content: $("#update")
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                });
            },
            loadDepartmentOrDirection: function (data, selectId) {
                let _html = ""
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },

            select: function () {
                $.post(baseUrl + "/department/allDepartments", function (data) {
                    if (data.result) {
                        $("#module_search").html( `<option value="" selected>系</option>`).append(communication.loadDepartmentOrDirection(data.data  ,"-"));
                        form.render();
                    }
                });
            },
            nowDate:function () {
                let date = new Date();
                let year=date.getFullYear();
                let differ =year-2017;
                if(differ>=0){
                    for(let i =differ;i>=0;i--){
                        $("#semester-search").append(`<option value="`+year+`">`+(year+i)+`</option>`)
                    }
                    form.render();
                }
            },
            direction:function (data) {
                $.post(baseUrl +"/communication/queryDirectionByDepartmentId",{departmentId:data},function (data) {
                    if (data.result) {
                        $("#findDirection").html(`<option value="">方向</option>`).append(communication.loadDepartmentOrDirection(data.data, "-"))
                        form.render();
                    }
                })
            },
            directionOne:function () {
                $.post(baseUrl +"/communication/queryDirectionByDepartment",function (data) {
                    if (data.result) {
                        $("#findDirection").html(`<option value="">方向</option>`).append(communication.loadDepartmentOrDirection(data.data, "-"))
                        form.render();
                    }
                })
            },
            queryClass:function () {
                $.post(baseUrl +"/communication/queryClass",function (data) {
                    if (data.result) {
                        $("#queryClass").html(`<option value="">班级</option>`).append(communication.loadDepartmentOrDirection(data.data, "-"))
                        form.render();
                    }
                })
            },
            queryClassByDepartmentId:function (data) {
                $.post(baseUrl +"/communication/queryClassByDepartmentId",{departmentId:data},function (data) {
                    if (data.result) {
                        $("#queryClass").html(`<option value="">班级</option>`).append(communication.loadDepartmentOrDirection(data.data, "-"))
                        form.render();
                    }
                })
            },
            queryFloorAndAreaOfRoom :function () {
                $.post(baseUrl +"/dorm/room/showAreaAndFloorInfosToQuery",function (data) {
                    if (data.result) {
                        $("#queryFloor").html(`<option value="">层号</option>`).append(communication.loadDepartmentOrDirection(data.data.queryFloorOfRoom, "-"))
                        $("#queryAreaOfRoom").html(`<option value="">楼号</option>`).append(communication.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
                        form.render();
                    }
                })
            }



        };
        $(function () {
            communication.list();
            communication.select();
            communication.nowDate();
            communication.directionOne();
            communication.queryClass();
            communication.queryFloorAndAreaOfRoom();
            form.on('radio(talk)', function (data) {
                let talkName = data.value == "parent" ? student.parentName : student.name;
                $("#talkName").text(talkName);
            });
            form.on('select(course)', function (data) {
                communication.direction(data.value);
                communication.queryClassByDepartmentId(data.value);

            });
            form.on('select(queryAreaOfRoom)', function (data) {
                var id = data.value;

                $.post(baseUrl + "dorm/room/showAreaAndFloorInfos", {areaId: data.value}, function (data) {
                    console.log(data)
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom


                        $("#queryAreaOfRoom").html(communication.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#queryFloor").html(`<option value="">层号</option>`).append(communication.loadDepartmentOrDirection(queryFloorOfRoom, "-"))

                        form.render();
                    }
                })
            })
        });
    })
    ;

    function printPdf() {
        pdf(document.getElementById("container"), $("#exportPDFName").text(), "a4");
        location.reload();
    }
</script>


</html>