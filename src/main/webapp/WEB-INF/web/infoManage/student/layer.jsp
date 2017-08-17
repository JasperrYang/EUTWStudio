<%@ page contentType="text/html; charset=UTF-8" %>

<script id="list-tpl" type="text/html">
    {{# layui.each(d.student, function(index,item){ }}
    <tr>
        <td>
            {{# if(item.no === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.no}}
            {{#}}}
        </td>

        <td>
            {{# if(item.name === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.name}}
            {{#}}}
        </td>
        <td>
            {{# if(item.gender === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.gender === "F" ? "女" : "男"}}
            {{#}}}
        </td>
        <td>
            {{# if(item.department === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.department}}
            {{#}}}
        </td>
        <td>
            {{# if(item.level === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.level}}
            {{#}}}
        </td>
        <td>
            {{# if(item.stay_type === "1"){ }}
            校内
            {{# }else{ }}
            {{item.stay_type === "2" ? "校外" : ""}}
            {{#}}}
        </td>
        <td>
            {{# if(item.profession === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.profession}}
            {{#}}}
        </td>
        <td>
            {{# if(item.direction === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.direction}}
            {{#}}}
        </td>

        <td>
            {{# if(item.classes === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.classes}}
            {{#}}}
        </td>

        <td>
            {{# if(item.area === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.area}}
            {{#}}}
        </td>

        <td>
            {{# if(item.floor === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.floor}}
            {{#}}}
        </td>

        <td>
            {{# if(item.room === undefined){ }}
            未分配
            {{# }else{ }}
            {{ item.room}}
            {{#}}}
        </td>

        <td>

            <%--<shiro:hasPermission name="communication:update">--%>
            <button class="layui-btn layui-btn-mini layui-btn-normal"
                    onclick="student.studentUpdate('{{ item.name}}','{{item.no}}','update')">
                <i class="layui-icon">&#xe642;</i>修改
            </button>
            <%--</shiro:hasPermission>--%>
            <%--<shiro:hasPermission name="communication:delete">--%>
            <button class="layui-btn layui-btn-mini  " onclick="student.preview('{{item.no}}')">
                <i class="layui-icon">&#xe60a;</i>预览
            </button>
            <%--</shiro:hasPermission>--%>
        </td>
    </tr>
    {{# }); }}

</script>


<div id="update" style="display: none; background:#F8F8F8">
    <div class="container" id="container" style=" background: #fff">
        <h1 style="text-align: center;margin-left: -30px;margin-top: 40px; ;color:#00ab9f ">西安欧亚学院<span
                id="studentName1"></span>学生档案</h1>
        <div style="margin-top: 40px;">
            <div style="width: 25%; height: 100%; float: left;border-right: 1px solid #00ab9f">
                <div style="width:140px; height: 200px; margin:10px 50px;border: 2px solid #00ab9f">
                    <img id="images" style="width: 100%" height="100%"/>
                </div>
                <div style="width:220px; height: 240px; margin:10px 30px;">
                    <table class="layui-table lay-even " data-name="articleCatData">
                        <tbody>
                        <tr>
                            <th>TEL：<span id="phone"></span></th>
                        </tr>
                        <tr>
                            <th>QQ：<span id="qq"></span></th>
                        </tr>
                        <tr>
                            <th>E-mail：<span id="email"></span></th>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div style="width: 75%; height: 100%; float: left;padding-left: 25px">
                <h4 style="color: #00ab9f;font-weight: bold">基本信息</h4>
                <table class="layui-table lay-even " data-name="articleCatData"
                       style="border: 0px solid red">
                    <tbody>
                    <tr>
                        <th colspan="2">学号：<span id="studentNo"></span></th>
                        <th>姓名：<span id="studentName"></span></th>
                        <th>性别：<span id="studentSex"></span></th>
                        <th>民族：<span id="famous_family"></span></th>
                        <th>身份证号：<span id="idcard"></span></th>
                    </tr>
                    <tr>
                        <th colspan="3">籍贯：<span id="native_place"></span></th>
                        <th colspan="3">出生日期：<span id="born"></span></th>
                    </tr>
                    <tr>
                        <th colspan="3">政治面貌：<span id="political_status"></span></th>
                        <th colspan="3">血型：<span id="blood"></span></th>
                    </tr>
                    <tr>
                        <th colspan="2">身高：<span id="height"></span>cm</th>
                        <th>体重：<span id="weight"></span>kg</th>
                        <th colspan="2">健康状况：<span id="health_status"></span></th>
                        <th>婚否：<span id="is_marry"></span></th>
                    </tr>
                    <tr>
                        <th colspan="6">邮编编码：<span id="family_zip_code"></span></th>
                    </tr>
                    <tr>
                        <th colspan="6">家庭电话：<span id="family_phone"></span></th>
                    </tr>
                    <tbody id="family">

                    </tbody>
                    <tr>
                        <th colspan="3">紧急联系人：<span id="emergency_contact_name"></span></th>

                        <th colspan="3">联系方式：<span id="emergency_contact_method"></span></th>
                    </tr>
                    </tbody>
                </table>
                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">教育经历</h4>
                <table class="layui-table lay-even " data-name="articleCatData"
                       style="border: 0px solid red">
                    <tbody id="experience_div">

                    </tbody>
                </table>
                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">学业信息</h4>
                <table class="layui-table lay-even " data-name="articleCatData"
                       style="border: 0px solid red">
                    <tbody>
                    <tr>
                        <th colspan="2">学生类别：<span id="student_type"></span></th>
                        <th colspan="2">高考成绩：<span id="sat_score"></span></th>

                    </tr>
                    <tr>
                        <th>录取专业：<span id="originProfession"></span></th>
                        <th>现专业：<span id="profession"></span></th>
                        <th>就业方向：<span id="direction"></span></th>
                        <th>班级：<span id="classes"></span></th>
                    </tr>
                    <tr>
                        <th colspan="2">职业导师：<span id="teacherName"></span></th>
                        <th colspan="2">社区辅导员：<span id="teacherCommunity"></span></th>
                    </tr>
                    <tr>
                        <th colspan="2">学籍状态：<span id="student_status"></span></th>
                        <th colspan="2">实践类型：<span id="practice_learning_type"></span></th>
                    </tr>

                    <tr>
                        <th colspan="4">缴费状态：
                            第一年：(<span id="payment_status_first_year"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            第二年：(<span id="payment_status_second_year"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            第三年：(<span id="payment_status_third_year"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        </th>

                    </tr>
                    <tr>
                        <th colspan="2">宿舍位置：<span id="area"></span>&nbsp;-&nbsp;<span
                                id="floor"></span>&nbsp;-&nbsp;<span id="room"></span>房间
                        </th>
                        <th colspan="2">困难类别：<span id="hard_type"></span></th>
                    </tr>
                    </tbody>
                </table>
                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">获奖或荣誉</h4>
                <table class="layui-table lay-even " data-name="articleCatData"
                       style="border: 0px solid red">
                    <tbody>
                    <tr>
                        <th id="own_punishment">
                        </th>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="updateStudent" style="display: none; background:#F8F8F8">
    <section class="larry-grid layui-form" style="height: auto">

        <div class="larry-personal">

            <div class="layui-tab layui-form" style="height: auto">
                <div style="float:left;position:fixed;">
                    <button class="layui-btn" onclick="student.updateStudentList()"><i class="layui-icon">&#xe61f;</i>
                        更新
                    </button>
                </div>
                <div class="larry-separate"></div>
                <div id="update1">
                    <div id="container1" style=" background: #fff">
                        <h1 style="text-align: center;color:#00ab9f;margin-top: 20px">西安欧亚学院高职学院学生档案修改页面</h1>
                        <div style="margin-top: 40px;">
                            <div style="float: left;width: 25%">
                                <div style="margin: 30px 10px;border: 1px ;">
                                    <div style="float: left;margin: 10px 37%">
                                        <div style="width:140px; height: 200px;border: 2px solid #e2e2e2;margin-bottom: 10px">
                                            <img id="imagesToUpdate" style="width: 100%" height="100%"/>
                                        </div>
                                        <div>
                                            <input type="file" name="file" class="layui-upload-file" style="width: auto"
                                                   lay-title="图片上传">
                                        </div>
                                    </div>
                                    <div style="margin:10px 30px;">
                                        <table class="layui-table lay-even " data-name="articleCatData">
                                            <tbody>
                                            <tr>
                                                <th>
                                                    <div class="layui-inline">
                                                        <label class="layui-form-label">TEL</label>
                                                        <div class="layui-input-inline">
                                                            <input type="tel" name="phone"
                                                                   autocomplete="off" class="layui-input"
                                                                   id="studentPhone">
                                                        </div>
                                                    </div>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>
                                                    <div class="layui-inline">
                                                        <label class="layui-form-label">QQ</label>
                                                        <div class="layui-input-inline">
                                                            <input type="number" name="QQ"
                                                                   autocomplete="off" class="layui-input"
                                                                   id="studentQQ">
                                                        </div>
                                                    </div>
                                                </th>
                                            </tr>
                                            <tr>
                                                <th>
                                                    <div class="layui-inline">
                                                        <label class="layui-form-label"
                                                               style="width: auto">E-mail</label>
                                                        <div class="layui-input-inline">
                                                            <input type="email" name="email"
                                                                   autocomplete="off" class="layui-input"
                                                                   id="studentEmail">
                                                        </div>
                                                    </div>
                                                </th>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 75%; height: 100%; float: left;padding-left: 25px">
                                <h4 style="color: #00ab9f;font-weight: bold">基本信息</h4>
                                <table class="layui-table lay-even " data-name="articleCatData"
                                       style="border: 0px solid red">
                                    <tbody>
                                    <tr>
                                        <th colspan="3">学号：<span>
                                            <div class="layui-input-inline" style="width: 70%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudentNo" disabled style="border: none">
                                             </div>
                                        </span></th>
                                        <th colspan="3">姓名：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudentName" readonly style="border: none">
                                             </div>
                                        </span></th>

                                    </tr>

                                    <tr>
                                        <th colspan="3">性别：<span>
                                            <div class="layui-inline" pane="" id="updateStudentSex">
                                                <div class="layui-inline" id="updateStudentSexToJs">
                                                    <input  name="sexOfUpdate" value="M" title="男"
                                                           type="radio">
                                                    <input  name="sexOfUpdate" value="F" title="女"
                                                           type="radio">
                                                </div>
                                             </div>
                                        </span></th>
                                        <th colspan="3">民族：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select id="updateStudentNationalities">
                                                    <option>汉族</option>
                                                    <option>汉族</option>
                                                </select>
                                                <%--<input type="text" name="text"--%>
                                                       <%--placeholder="请输入内容" autocomplete="off" class="layui-input"--%>
                                                       <%--id="updateStudentNationalities" readonly style="border: none">--%>
                                             </div>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="3">身份证号：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudentIdCard" readonly style="border: none">
                                             </div>
                                        </span></th>
                                        <th colspan="3">籍贯：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudentNativePlace">
                                             </div>
                                        </span></th>

                                    </tr>

                                    <tr>
                                        <th colspan="3">出生日期：
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input name="date"  placeholder="yyyy-mm-dd"
                                                       autocomplete="off" class="layui-input"
                                                       type="text"
                                                       id="updateStudentBirthday" onclick="layui.laydate({elem: this})">
                                            </div>
                                        </th>
                                        <th colspan="3">婚否：
                                            <div class="layui-inline" pane="" id="isMarry">
                                                <label class="layui-form-label" style="width: auto"></label>
                                                <div class="layui-inline">
                                                    <input class="marry" name="isMarry" value="是" title="是"
                                                           type="radio">
                                                    <input class="marry" name="isMarry" value="否" title="否"
                                                           type="radio">
                                                </div>
                                            </div>
                                        </th>
                                    </tr>

                                    <tr>
                                        <th colspan="1">身高：<span>
                                            <div class="layui-input-inline" style="width: 40%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudentHeight">
                                             </div>
                                        </span>
                                            <span>cm</span>
                                        </th>
                                        <th colspan="1">体重：<span>
                                            <div class="layui-input-inline" style="width: 40%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudentWight">
                                             </div>
                                        </span>
                                            <span>kg</span>
                                        </th>
                                        <th colspan="4">健康状况：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <div class="layui-inline" pane="" id="health">
                                                    <label class="layui-form-label" style="width: auto"></label>
                                                    <div class="layui-inline">
                                                       <input name="health" value="良好" title="良好"
                                                              type="radio">
                                                       <input name="health" value="其他" title="其他" type="radio">
                                                    </div>
                                                </div>
                                             </div>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="1">学生类型:<span>
                                        <div class="layui-inline" pane="" id="updateStudentType">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="student_type" value="高考录取" title="高考录取"
                                                      type="radio">
                                               <input name="student_type" value="自助招生" title="自助招生" type="radio">
                                            </div>
                                        </div>
                                    </span></th>
                                        <th colspan="1">住宿类型:<span>
                                        <div class="layui-inline" pane="" id="update_accommodation_type">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="accommodation_type" value="2" title="校外"
                                                      type="radio">
                                               <input name="accommodation_type" value="1" title="校内" type="radio">
                                            </div>
                                        </div>
                                    </span></th>
                                        <th colspan="4">血型：<span>
                                        <div class="layui-input-inline"
                                        >
                                          <select name="quiz1" lay-filter="updateStudentBloodType"
                                                  id="updateStudentBloodType">
                                            <option value="">请选择血型</option>
                                            <option value="1">O型</option>
                                            <option value="2">A型</option>
                                            <option value="3">B型</option>
                                            <option value="4">AB型</option>
                                            <option value="5">RH阴性</option>
                                          </select>
                                        </div>
                                    </span></th>
                                    </tr>


                                    <tr>
                                        <th colspan="6">政治面貌：
                                            <span>
                                            <div class="layui-input-inline">
                                              <select name="politicalOutlook" lay-filter="politicalOutlook"
                                                      id="updateStudentPoliticalOutlook">
                                                <option value="">请选择</option>
                                                <option value="1">中共党员</option>
                                                <option value="2">预备党员</option>
                                                <option value="3">共青团员</option>
                                                <option value="4">积极分子</option>
                                                <option value="5">群众</option>
                                                <option value="6">其他党派</option>
                                              </select>
                                            </div>
                                            <span id="otherParty" style="display: none">
                                                  <div class="layui-input-inline">
                                                    <label class="layui-form-label" style="width: auto">其他党派: </label>
                                                    <div class="layui-input-inline">
                                                      <input type="text" name="otherPartyName"
                                                             placeholder="请输入党派名称"
                                                             autocomplete="off" class="layui-input"
                                                             id="otherUpdateStudentPoliticalOutlook">
                                                    </div>
                                                  </div>
                                            </span>
                                        </span>
                                        </th>
                                    </tr>

                                    <tr>
                                        <th colspan="6">入学前文化程度：
                                            <span>
                                            <div class="layui-input-inline">
                                              <select name="pre_school_education" lay-filter="pre_school_education"
                                                      id="updateStudent_pre_school_education">
                                                <option value="">请选择</option>
                                                <option value="1">高中</option>
                                                <option value="2">三校生</option>
                                                <option value="3">其他</option>
                                              </select>
                                            </div>
                                            <span id="pre_school_education" style="display: none">
                                                  <div class="layui-input-inline">
                                                    <label class="layui-form-label" style="width: auto">其他: </label>
                                                    <div class="layui-input-inline">
                                                      <input type="text" name="otherPartyName" placeholder="请输入文化程度"
                                                             autocomplete="off" class="layui-input"
                                                             id="other_updateStudent_pre_school_education">
                                                    </div>
                                                  </div>
                                            </span>
                                        </span>
                                        </th>
                                    </tr>

                                    <tr>
                                        <th colspan="2">生源类别:<span>
                                        <div class="layui-inline" pane="" id="student_classify">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="student_classify" value="统招专科" title="统招专科"
                                                      type="radio">
                                               <input name="student_classify" value="综合评价" title="综合评价" type="radio">
                                            </div>
                                        </div>
                                    </span></th>
                                        <th colspan="4"><span>
                                        <div class="layui-input-inline">
                                            <label class="layui-form-label" style="width: auto">身份证住址: </label>
                                            <div class="layui-input-inline">
                                              <input type="text" name="idcard_address"
                                                     placeholder="请输入身份证住址"
                                                     autocomplete="off" class="layui-input" id="Identity_card_address" style="width: 140%">
                                            </div>
                                          </div>
                                    </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="6"><span style="font-weight: bold">家庭实际住址: </span>
                                            <div class="layui-input-inline" style="width: 100%">
                                                <label class="layui-form-label" style="width: auto"></label>
                                                <div class="layui-input-inline" style="width: 60%">
                                                    <input type="text" name="idcard_address" placeholder="请输入家庭实际住址"
                                                           autocomplete="off" class="layui-input" id="detailedAddresses"
                                                           readonly style="border: none">
                                                </div>
                                                <span>
                                                     <button class="layui-btn"
                                                             onclick="student.updateDetailedAddress()">编辑地址信息</button>
                                                </span>
                                            </div>
                                            <br>
                                            <br>
                                            <div style="display: none" id="updateDetailedAddress">
                                                <form class="form-inline">
                                                    <div id="distpicker3">
                                                        <div class="form-group">
                                                            <label class="sr-only" for="province3">Province</label>
                                                            <select class="form-control" id="province3"
                                                                    lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="sr-only" for="city3">City</label>
                                                            <select class="form-control" id="city3" lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="sr-only" for="district3">District</label>
                                                            <select class="form-control" id="district3"
                                                                    lay-ignore></select>
                                                        </div>
                                                    </div>
                                                    <br><br>
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label" style="width: auto">详细地址</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" name="detailedAddress"
                                                                   placeholder="请输入详细地址"
                                                                   autocomplete="off" class="layui-input"
                                                                   id="detailedAddress">
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                        </th>
                                    </tr>

                                    <tr>
                                        <th colspan="6"><span style="font-weight: bold">生源所在地名称： </span>
                                            <div class="layui-input-inline" style="width: 100%">
                                                <label class="layui-form-label" style="width: auto"></label>
                                                <div class="layui-input-inline" style="width: 60%">
                                                    <input type="text" name="idcard_address" placeholder="请输入生源所在地名称"
                                                           autocomplete="off" class="layui-input"
                                                           id="update_name_of_the_source" readonly style="border:none">
                                                </div>
                                                <span>
                                                     <button class="layui-btn"
                                                             onclick="student.showUpdate_name_of_the_source()">编辑地址信息</button>
                                                </span>
                                            </div>
                                            <br>
                                            <br>
                                            <div id="showUpdate_name_of_the_source" style="display: none">
                                                <form class="form-inline">
                                                    <div id="distpicker">
                                                        <div class="form-group">
                                                            <select class="form-control" id="province1"
                                                                    lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" id="city1" lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" id="district1"
                                                                    lay-ignore></select>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                        </th>
                                    </tr>


                                    <tr>
                                        <th colspan="6">邮编编码：<span class="layui-input-inline">
                                            <input type="text" name="text"
                                                   placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                   id="updateStudentZip_code">
                                        </span></th>
                                    </tr>
                                    <tr>
                                        <th colspan="6">家庭电话：<span class="layui-input-inline">

                                            <input type="text" name="text"
                                                   placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                   id="updateStudentHome_phone">
                                        </span></th>
                                    </tr>
                                    <div id="family_information">

                                    </div>


                                    <tr>
                                        <th colspan="3">紧急联系人：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudent_emergency_contact">
                                             </div>
                                        </span></th>

                                        <th colspan="3">联系方式：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="updateStudent_emergency_contact_phone">
                                             </div>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="3">户口是否转入：
                                            <span>
                                        <div class="layui-inline" pane="" id="whetherToTransfer">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="whetherToTransfer" value="是" title="是"
                                                      type="radio">
                                               <input name="whetherToTransfer" value="否" title="否" type="radio">
                                            </div>
                                        </div>
                                    </span>
                                        </th>

                                        <th colspan="3">城乡生源名称：<span>
                                        <div class="layui-inline" pane="" id="birthplaceName">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="birthplaceName" value="城镇" title="城镇"
                                                      type="radio">
                                               <input name="birthplaceName" value="农村" title="农村" type="radio">
                                            </div>
                                        </div>
                                    </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="6"><span style="font-weight: bold">入学前档案所在单位： </span>
                                            <div class="layui-input-inline" style="width: 100%">
                                                <label class="layui-form-label" style="width: auto"></label>
                                                <div class="layui-input-inline" style="width: 60%">
                                                    <input type="text" name="idcard_address" placeholder="请输入入学前档案所在单位"
                                                           autocomplete="off" class="layui-input"
                                                           id="Pre_enrollment_file_unit"
                                                           readonly style="border: none">
                                                </div>
                                                <span>
                                                     <button class="layui-btn"
                                                             onclick="student.update_Pre_enrollment_file_unit()">编辑地址信息</button>
                                                </span>
                                            </div>
                                            <div id="update_Pre_enrollment_file_unit" style="display: none">
                                                <form class="form-inline">
                                                    <div id="distpicker1">
                                                        <div class="form-group">
                                                            <label class="sr-only" for="province2">Province</label>
                                                            <select class="form-control" id="province2"
                                                                    lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="sr-only" for="city2">City</label>
                                                            <select class="form-control" id="city2" lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="sr-only" for="district2">District</label>
                                                            <select class="form-control" id="district2"
                                                                    lay-ignore></select>
                                                        </div>
                                                    </div>
                                                    <br><br>
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label" style="width: auto">详细地址</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" name="detailedAddress"
                                                                   placeholder="请输入详细地址"
                                                                   autocomplete="off" class="layui-input"
                                                                   id="updateStudent_Pre_enrollment_file_unit_detailed">
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                        </th>
                                    </tr>

                                    <tr>
                                        <th colspan="3">档案是否转入：
                                            <span>
                                        <div class="layui-inline" pane="" id="is_the_file_transferred">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="is_the_file_transferred" value="是" title="是"
                                                      type="radio">
                                               <input name="is_the_file_transferred" value="否" title="否" type="radio">
                                            </div>
                                        </div>
                                    </span>
                                        </th>

                                        <th colspan="3">
                                        <span>
                                            <div class="layui-form-item" style="margin-bottom: 0px">
                                                <label class="layui-form-label" style="width: auto">入学前学校名称:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="detailedAddress" placeholder="请输入详细地址"
                                                           autocomplete="off" class="layui-input"
                                                           style="width: 80%;margin-bottom: 1%" id="Pre_school_name">
                                                </div>
                                            </div>
                                        </span>

                                        </th>
                                    </tr>

                                    <tr>
                                        <th colspan="6"><span style="font-weight: bold">入学前户口所在派出所： </span>
                                            <div class="layui-input-inline" style="width: 100%">
                                                <label class="layui-form-label" style="width: auto"></label>
                                                <div class="layui-input-inline" style="width: 60%">
                                                    <input type="text" name="idcard_address" placeholder="请输入入学前户口所在派出所"
                                                           autocomplete="off" class="layui-input"
                                                           id="school_account_where_the_police_station_detailed"
                                                           readonly style="border: none">
                                                </div>
                                                <span>
                                                     <button class="layui-btn"
                                                             onclick="student.school_account_where_the_police_station_detailed()">编辑地址信息</button>
                                                </span>
                                            </div>
                                            <div id="show_Pre_school_account_where_the_police_station_detailed"
                                                 style="display: none">
                                                <form class="form-inline">
                                                    <div id="distpicker5">
                                                        <div class="form-group">
                                                            <label class="sr-only" for="province5">Province</label>
                                                            <select class="form-control" id="province5"
                                                                    lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="sr-only" for="city5">City</label>
                                                            <select class="form-control" id="city5" lay-ignore></select>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="sr-only" for="district5">District</label>
                                                            <select class="form-control" id="district5"
                                                                    lay-ignore></select>
                                                        </div>
                                                    </div>
                                                    <br><br>
                                                    <div class="layui-form-item">
                                                        <label class="layui-form-label" style="width: auto">详细地址</label>
                                                        <div class="layui-input-block">
                                                            <input type="text" name="detailedAddress"
                                                                   placeholder="请输入详细地址"
                                                                   autocomplete="off" class="layui-input"
                                                                   id="Pre_school_account_where_the_police_station_detailed">
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>

                                        </th>
                                    </tr>

                                    </tbody>
                                </table>


                                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">家庭成员信息</h4>
                                <table class="layui-table lay-even " data-name="articleCatData"
                                       style="border: 0px solid red" id="family_member_information_list">
                                    <tbody id="family_member_information">

                                    </tbody>
                                </table>
                                <button class="layui-btn" onclick="student.addStudentFamilyInfo()"><i
                                        class="layui-icon">&#xe61f;</i> 添加成员信息
                                </button>


                                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">教育经历</h4>
                                <table class="layui-table lay-even " data-name="articleCatData"
                                       style="border: 0px solid red" id="updateStudent_Educational_experience">
                                    <tbody id="educational_experience">

                                    </tbody>
                                </table>
                                <button class="layui-btn" onclick="student.addExperienceInfo()"><i
                                        class="layui-icon">&#xe61f;</i> 添加教育经历
                                </button>


                                <br>
                                <br>
                                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">学业信息</h4>
                                <table class="layui-table lay-even " data-name="articleCatData"
                                       style="border: 0px solid red" id="updateStudent_Academic information">
                                    <tbody>
                                    <tr>
                                        <th colspan="2">学生类型：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <div class="layui-inline" pane="" id="updateStudentType1">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="student_type1" value="高考录取" title="高考录取"
                                                      type="radio">
                                               <input name="student_type1" value="自助招生" title="自助招生" type="radio">
                                            </div>
                                        </div>
                                             </div>
                                        </span></th>
                                        <th colspan="2">高考成绩：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                       id="upadte_SAT_score">
                                             </div>
                                        </span></th>

                                    </tr>
                                    <tr>
                                        <th colspan="1">录取专业：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select id="studentsProfessionList" lay-filter="studentsProfessionList">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                        <th colspan="1">现专业：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select id="studentsNowProfessional"
                                                        lay-filter="studentsNowProfessional">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                        <th colspan="4">就业方向：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select id="employment_direction" lay-filter="employment_direction">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="1">系：<span>
                                             <div class="layui-input-inline">
                                                <select id="student_department" lay-filter="student_departments" class="student_class">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                        <th colspan="5">班级：<span>
                                             <div class="layui-input-inline">
                                                <select id="student_class" lay-filter="student_classe">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="2">职业导师：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select lay-filter="update_community_counselor"
                                                        id="update_career_mentor" readonly>
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                        <th colspan="2">社区辅导员：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select lay-filter="update_community_counselor"
                                                        id="update_community_counselor">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </span></th>
                                    </tr>
                                    <tr>
                                        <th colspan="1">学籍状态：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <select lay-filter="update_student_status" id="update_student_status">
                                                    <option value=""></option>
                                                    <option value="1">在读</option>
                                                    <option value="2">休学</option>
                                                    <option value="3">入伍</option>
                                                    <option value="4">退学</option>
                                                    <option value="5">复学</option>
                                                    <option value="6">留级</option>
                                                </select>
                                            </div>
                                        </span></th>
                                        <th colspan="5">困难类别：<span>
                                            <div class="layui-input-inline" style="width: 60%">
                                                <div class="layui-inline" pane="" id="update_hard_type">
                                            <label class="layui-form-label" style="width: auto"></label>
                                            <div class="layui-inline">
                                               <input name="update_hard_type" value="" title="不是" type="radio" checked>
                                               <input name="update_hard_type" value="一般" title="一般" type="radio">
                                               <input name="update_hard_type" value="特困" title="特困" type="radio">
                                            </div>
                                        </div>
                                             </div>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="5">第一年缴费状态：<span>
                                             <div class="layui-input-inline" style="width: 30%">
                                                <select lay-filter="update_payment_status" id="update_payment_status">
                                                    <option value=""></option>
                                                    <option value="1">全额</option>
                                                    <option value="2">缓交</option>
                                                    <option value="3">分期</option>
                                                    <option value="4">贷款</option>
                                                    <option value="5">欠费</option>
                                                </select>
                                            </div>
                                             <span id="showAmount_of_arrears" style="display: none">欠费金额:
                                                    <div class="layui-input-inline">
                                                      <input type="text" name="otherPartyName" placeholder="请输入欠费金额"
                                                             autocomplete="off" class="layui-input"
                                                             id="Amount_of_arrears" style="width: 65%">
                                                    </div>
                                                 <span style="float: none;margin-left: -5%">单位:元</span>
                                            </span>
                                        </span></th>

                                    </tr>

                                    <tr>
                                        <th colspan="5">第二年缴费状态：<span>
                                             <div class="layui-input-inline" style="width: 30%">
                                                <select lay-filter="update_payment_status2" id="update_payment_status2">
                                                    <option value=""></option>
                                                    <option value="1">全额</option>
                                                    <option value="2">缓交</option>
                                                    <option value="3">分期</option>
                                                    <option value="4">贷款</option>
                                                    <option value="5">欠费</option>
                                                </select>
                                            </div>
                                             <span id="showAmount_of_arrears2" style="display: none">欠费金额:
                                                    <div class="layui-input-inline">
                                                      <input type="text" name="otherPartyName" placeholder="请输入欠费金额"
                                                             autocomplete="off" class="layui-input"
                                                             id="Amount_of_arrears2" style="width: 65%">
                                                    </div>
                                                 <span style="float: none;margin-left: -5%">单位:元</span>
                                            </span>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="5">第三年缴费状态：<span>
                                             <div class="layui-input-inline" style="width: 30%">
                                                <select lay-filter="update_payment_status3" id="update_payment_status3">
                                                    <option value=""></option>
                                                    <option value="1">全额</option>
                                                    <option value="2">缓交</option>
                                                    <option value="3">分期</option>
                                                    <option value="4">贷款</option>
                                                    <option value="5">欠费</option>
                                                </select>
                                            </div>
                                             <span id="showAmount_of_arrears3" style="display: none">欠费金额:
                                                    <div class="layui-input-inline">
                                                      <input type="text" name="otherPartyName" placeholder="请输入欠费金额"
                                                             autocomplete="off" class="layui-input"
                                                             id="Amount_of_arrears3" style="width: 65%">
                                                    </div>
                                                 <span style="float: none;margin-left: -5%">单位:元</span>
                                            </span>
                                        </span></th>
                                    </tr>

                                    <tr>
                                        <th colspan="6">实践类型：<span>
                                            <div class="layui-input-inline" style="width: 30%">
                                                <select lay-filter="update_practical_type" id="update_practical_type">
                                                    <option value=""></option>
                                                    <option value="1">合作企业</option>
                                                    <option value="2">自主实习</option>
                                                    <option value="3">创新创业</option>
                                                    <option value="4">专升本</option>
                                                    <option value="5">其他</option>
                                                </select>
                                            </div>
                                             <span id="show_other_practical_type" style="display: none">实践类型:
                                                    <div class="layui-input-inline">
                                                      <input type="text" name="otherPartyName" placeholder="请输入事件类型名称"
                                                             autocomplete="off" class="layui-input"
                                                             id="other_practical_type" style="width: 100%">
                                                    </div>
                                            </span>
                                        </span></th>
                                    </tr>
                                    <tr id="dorms">
                                        <th colspan="6"><span><span style="font-weight: bold">宿舍信息: </span>

                                                <div class="layui-input-inline" style="width: 100%">
                                                <label class="layui-form-label" style="width: auto"></label>
                                                <div class="layui-input-inline" style="width: 60%">
                                                    <input type="text" name="idcard_address" placeholder="请输入宿舍信息"
                                                           autocomplete="off" class="layui-input" id="updateDorms"
                                                           readonly style="border: none">
                                                </div>
                                                <span>
                                                     <button class="layui-btn"
                                                             onclick="student.showUpdateDorms()">编辑地址信息</button>
                                                </span>
                                            </div>
                                            </span>
                                            <br>
                                            <br>
                                            <div id="showUpdateDorms" style="display: none">
                                                <div class="layui-input-inline">
                                                    <label class="layui-form-label">区</label>
                                                    <div class="layui-inline">
                                                        <div class="layui-input-inline">
                                                            <select name="modules" lay-filter="modules_3"
                                                                    lay-search=""
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
                                                            <select name="modules1" lay-filter="modules_2"
                                                                    lay-search=""
                                                                    id="queryFloors">
                                                                <option value="">直接选择或搜索选择</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="layui-input-inline">
                                                    <label class="layui-form-label">宿舍</label>
                                                    <div class="layui-inline">
                                                        <div class="layui-input-inline">
                                                            <select name="modules1" lay-filter="modules_1"
                                                                    lay-search=""
                                                                    id="queryRooms">
                                                                <option value="">直接选择或搜索选择</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </th>
                                    </tr>
                                    </tbody>
                                </table>
                                <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">获奖或荣誉</h4>
                                <table class="layui-table lay-even " data-name="articleCatData"
                                       style="border: 0px solid red" id="updateStudent_Award_or_honor">
                                    <tbody>
                                    <tr>
                                        <th>
                                            <div>
                                                <div class="layui-input-inline" style="width: 98%">
                                                    <input type="text" name="text"
                                                           placeholder="请输入内容" autocomplete="off" class="layui-input"
                                                           id="update_award_or_honor">
                                                </div>
                                            </div>
                                        </th>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<div id="addStudentFamily" style="display: none">
    <table class="layui-table lay-even " data-name="articleCatData"
           style="border: 0px solid red" id="add_family_member_information_list">
        <tbody id="add_family_member_information">
        <tr>
            <td>
                <div class="layui-inline">
                    <label class="layui-form-label">称谓</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone"
                               autocomplete="off" class="layui-input"
                               placeholder="请输入相关内容" id="family_relationship">
                    </div>
                </div>
            </td>
            <td>
                <div class="layui-inline">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone"
                               autocomplete="off" class="layui-input"
                               placeholder="请输入相关内容" id="family_name">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: auto">工作单位</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone"
                               autocomplete="off" class="layui-input"
                               placeholder="请输入相关内容" id="family_work_place">
                    </div>
                </div>
            </td>
            <td>
                <div class="layui-inline">
                    <label class="layui-form-label">职务</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone"
                               autocomplete="off" class="layui-input"
                               placeholder="请输入相关内容" id="family_staff">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="layui-inline">
                    <label class="layui-form-label">手机</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone"
                               autocomplete="off" class="layui-input"
                               placeholder="请输入相关内容" id="family_phone_add">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="layui-inline layui-form">
                    <label class="layui-form-label" style="width: auto">政治面貌</label>
                    <div class="layui-input-inline">
                        <select id="family_political_status"lay-filter="family_political_status">
                            <option value="">请选择</option>
                            <option value="1">中共党员</option>
                            <option value="2">预备党员</option>
                            <option value="3">共青团员</option>
                            <option value="4">积极分子</option>
                            <option value="5">群众</option>
                            <option value="6">其他党派</option>
                        </select>
                    </div>
                </div>
            </td>
            <td>
                <div class="layui-inline" placeholder="请输入相关内容" id="show_other_family_political_status" style="display: none">
                    <label class="layui-form-label" style="width: auto">其他党派</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="phone"
                               autocomplete="off" class="layui-input"
                               placeholder="请输入相关内容" id="other_family_political_status">
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
    <button class="layui-btn" style="float: right;margin-bottom: 10px;margin-right: 30px" onclick="student.addFamilyByUpdate()"><i class="layui-icon">&#xe61f;</i> 添加</button>
</div>

<div id="addExperienceInfo" style="display: none">
    <table class="layui-table lay-even " data-name="articleCatData"
           style="border: 0px solid red" id="add_addExperienceInfo_list">
        <tbody id="add_addExperienceInfo">
        <tr>

            <td>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: auto">起始时间</label>
                    <div class="layui-input-inline">
                        <input type="text" name="date" id="startDateExperience" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="layui-inline">
                    <label class="layui-form-label" style="width: auto">结束时间</label>
                    <div class="layui-input-inline">
                        <input type="text" name="date" id="endDateExperience" lay-verify="date" placeholder="yyyy-mm-dd" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: auto">地点</label>
                    <div class="layui-input-block">
                        <input type="text" name="placeExperience" id="placeExperience" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: auto">担任职务</label>
                    <div class="layui-input-block">
                        <input type="text" name="staffExperience" id="staffExperience" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
    <button class="layui-btn" style="float: right;margin-bottom: 10px;margin-right: 30px" onclick="student.addExperienceByUpdate()"><i class="layui-icon">&#xe61f;</i> 添加</button>
</div>
<%--省市区联动--%>
<script src="${baseurl}/js/city/distpicker.js"></script>
<script src="${baseurl}/js/city/main.js"></script>
<script src="${baseurl}/js/city/distpicker.data.js"></script>
<script type="text/javascript">
    $("#distpicker").distpicker({
        autoSelect: false
    });
    $("#distpicker1").distpicker({
        autoSelect: false
    });
    $("#distpicker3").distpicker({
        autoSelect: false
    });

</script>