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

</head>
<body>
<section class="larry-grid layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">

                <div class="layui-inline">
                    <div class="layui-inline">
                        <div class="layui-input-inline">
                            <input type="text" name="title" id="name_search" lay-verify="title" autocomplete="off"
                                   placeholder="姓名" class="layui-input">
                        </div>
                        <a class="layui-btn" onclick="communication.list()"><i class="layui-icon">&#xe615;</i>搜索</a>

                    </div>
                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form">
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th><input type="checkbox" lay-filter="checkedAll" name="" lay-skin="primary"
                                       lay-filter="allChoose"></th>
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
                <div id="demo1"></div>
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
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 5;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        student = {



            list: function () {
               /* let data = {
                    name: $("#name_search").val(),
                    page: {currentIndex: currentIndex, pageSize: pageSize},
                }*/
                $.ajax({
                    url: baseUrl + "/student/list",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
                    success: function (data) {
                        if (data.result) {
                            console.log(data)
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            }

        };

        $(function () {
            student.list();
        });
    });

</script>

<script>

    layui.use(['laypage', 'layer'], function(){
        var laypage = layui.laypage
            ,layer = layui.layer;

        laypage({
            cont: 'demo1'
            ,pages: totalSize //总页数
            ,groups: 5 //连续显示分页数
            ,skin: '#1E9FFF',
            jump: function (obj, first) {
                currentIndex = obj.curr;
                if (!first) {
                    profession.list();
                }
            }
        });
    });
</script>

</html>
