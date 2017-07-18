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
    <%--时间轴--%>
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/css/screen.css" type="text/css" media="screen">
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/css/responsive.css" type="text/css" media="screen">
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/inc/colorbox.css" type="text/css" media="screen">

</head>
<body>
<section class="larry-grid">
    <div class="larry-personal">
        <div class="layui-tab">

            <div class="larry-separate"></div>

            <div id="update" style="background: #fff">
                <a class="layui-btn" onclick="printPdf()" id="printPDF"><i class="layui-icon">&#xe630;</i>导出 PDF</a>
                <div class="container" id="container" style="padding:50px 30px">

                    <h1 style="text-align: center;margin-left: -30px">西安欧亚学院高职学院<span id="who"></span>学生成长经历报告</h1>
                    <div style="margin:40px 0">

                        <table  class="layui-table lay-even " data-name="articleCatData">
                            <thead>
                            <tr>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>籍贯</th>
                                <th>身份证号码</th>
                                <th>专业</th>
                                <th>就业方向</th>
                                <th>政治面貌</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th id="name"></th>
                                <th id ="gender"></th>
                                <th id="native_place"></th>
                                <th id="idcard"></th>
                                <th id="profession"></th>
                                <th id="direction2"></th>
                                <th id="political_status"></th>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div id="timelineContainer" class="timelineContainer">

                        <div class="timelineToggle"><p><a class="expandAll ">+ 全部展开</a></p></div>

                        <br class="clear">
                        <div id="communication_container">

                        </div>


                        <br class="clear">
                    </div>
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
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let communication;
    let student;
    let no;
    layui.use(['jquery', 'layer', 'element','laypage', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        communication = {
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
                            communication.list();
                        }
                    }
                });
            },
            list: function () {
                let data = {
                    departmentId: $("#module_search").val(),
                    professionId: $("#semester-search").val(),
                    directionId: $("#findDirection").val(),
                    classesId: $("#queryClass").val(),
                    studentNo: $("#no-search").val(),
                    name: $("#name_search").val(),
                    areaId: $("#queryAreaOfRoom").val(),
                    floorId: $("#queryFloor").val(),
                    roomId: $("#roomId").val(),
                    currentIndex: currentIndex,
                    pageSize: pageSize
                }
                $.ajax({
                    url: baseUrl + "/communication/list",
                    data: data,
                    type: "post",
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            communication.page();
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
                        console.log(data)
                        showCommunicationContents(data.data, type);
                        $("#name").text(data.data[(data.data.length-1)].name);
                        $("#gender").text(data.data[(data.data.length-1)].gender);
                        $("#native_place").text(data.data[(data.data.length-1)].native_place);
                        $("#idcard").text(data.data[(data.data.length-1)].idcard);
                        $("#profession").text(data.data[(data.data.length-1)].profession);
                        $("#direction2").text(data.data[(data.data.length-1)].direction);
                        $("#political_status").text(data.data[(data.data.length-1)].political_status);
                        let title = null;
                        if (type === "preview") {
                            $("#printPDF").show();
                            title = "预览"
                        } else {
                            $("#printPDF").hide();
                            title = "修改"
                        }

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
                $.post(baseUrl +"/dorm/room/showAreaAndFloorsToQuery",function (data) {
                    if (data.result) {
                        $("#queryFloor").html(`<option value="">层号</option>`).append(communication.loadDepartmentOrDirection(data.data.queryFloorOfRoom, "-"))
                        $("#queryAreaOfRoom").html(`<option value="">区号</option>`).append(communication.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
                        form.render();
                    }
                })
            }



        };
        $(function () {
            communication.previewOrUpdate('小','15642142536258','preview');
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
                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
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

    function showCommunicationContents(data, type) {
        let communication = ""
        for (let i = 0; i < data.length-1; ++i) {
            let com = data[i];
            communication += `
            <div class="timelineMajor">
                <h2 class="timelineMajorMarker">
                <span>` + com.time + `</span></h2>
                <dl class="timelineMinor">
                    <dt id="id` + com.id + `">
                    <a id='exportPDFName'>` + com.teacherName + ` - ` + com.direction + ` - ` + com.talkName + `</a></dt>
                    <%--QA 容器--%>
                    <dd class="timelineEvent" id="id` + com.id + `EX" style="display:none;">
                `;

            loadPreviewQA(com.contents);
            communication += `</dd></dl></div>`;

        }

        $("#communication_container").html(communication);
    }

    function loadPreviewQA(contents) {
        let QA = "";
        for (let index = 0; index < contents.length; index += 2) {
            QA += `
             <dl class="timelineMinor">
                <dt id="` + index + `"><a style="font-size: 12px;color: peru">Q&A</a></dt>
                <dd class="timelineEvent" id="` + index + `EX" style="display:none;">
               <p style="font-size: 12px;"
                           class=" contents"> <a style="font-size: 12px;color: peru">Q：</a> ` + contents[index] + `</p>
                   <p style="font-size: 12px;"
                              class=" contents"> <a style="font-size: 12px;color: peru">A：</a> ` + contents[index + 1] + `</p>
                    <br class="clear">
                </dd>
            </dl>
         `;
        }
        return QA;
    }

    function printPdf() {
        pdf(document.getElementById("container"), $("#exportPDFName").text(), "a3");
    }




</script>


</html>
