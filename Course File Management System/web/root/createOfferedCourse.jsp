<jsp:include page="../header.jsp"/>
<%@ page import ="java.sql.*, common.DB, java.util.*" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Offer Course - <%=session.getAttribute("User").toString()%></title>
    <script>
        $(window).on("popstate", function(e) {
            url = window.location.pathname;
            filename = url.substring(url.lastIndexOf('/')+1);
            if(filename !== "createOfferedCourse.jsp")
                window.location.href = window.location.href;
            else {
                $('#result').load(window.location.href + ' #result'); 
            }
                
        });
        jQuery(function($) {
            $('form').bind('submit', function() {
                $(this).find(':input').removeAttr('disabled');
            });
        });
    </script>
    <script>
        var semester = [];
        $.getJSON("<%=request.getContextPath()%>/ListSemesterServlet", {
            value: "id",
            label: "text",
            id: "[semesterID]",
            text: "[year] / [semester]"
        },
        function( json ) {
            var keys = Object.keys(json);
            keys.forEach(function(key){
                semester.push(json[key]);
            });
            $("#semester").select2({
                data: semester,
                placeholder: "Select A Semester"
            });
            $("#semester").select2("val", "");
            $("#semester").change(function() {
                dataSet = { 
                    "semesterID":$("#semester").val()
                };
                var uri = new URI(window.location.href);
                var query = new URI(uri.search());
                var query = query.setSearch(dataSet);
                var uri = uri.pathname();
                var newQueryUrl = uri + query;
                history.pushState(null, null, newQueryUrl);
                $('#result').load(newQueryUrl + ' #result'); 
            });
        });
    </script>
    <script>
        function buildCourseList() {
            $( document ).ready( function () {
                $(".semester-label").val($("#semester").text());
                $("select.penyelaras").change(function(){
                    var course = $(this);
                    var selected = course.find(":selected");
                    var co_ID = selected.attr("co_ID");
                    var inputField = $("#username\\["+co_ID+"\\]");
                    inputField.val(selected.attr("username"));
                });
            });
            var course = [];
            $.getJSON("<%=request.getContextPath()%>/ListCourseServlet", {
                value: "id",
                label: "text",
                id: "[courseCode] [courseID] [courseName]",
                text: "[courseName]",
                semesterID: $("#semester").val()
            },
            function( json ) {
                var keys = Object.keys(json);
                keys.forEach(function(key){
                    course.push(json[key]);
                });
                $("#courseName").select2({
                    data: course,
                    placeholder: "Select A Course"
                });
                $("#courseName").select2("val", "");
                $("#courseName").change(function() {
                    alert($("#courseName").attr("courseName"));
                });
            });
        }
    </script>
</head>
<body>
    <div class="container">
        <select class="form-control" id="semester"></select>
        <div id="result">
            <script>
                buildCourseList();
            </script>
            <table class="table" id="tblSemesters">
                <thead>
                    <tr>
                        <th>Course Code</th>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Course Credit Hours</th>
                        <th>Penyelaras</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if(request.getParameter("semesterID") != null) {
                    String semesterID = request.getParameter("semesterID");
                    String query = "SELECT co.course_offered_ID, c.courseCode, c.courseID, c.courseName, c.creditHours, p.name, p.username FROM " + 
                            "course_offered AS co, course AS c, profile AS p WHERE " +
                            "co.courseCode = c.courseCode AND co.courseID = c.courseID AND " +
                            "co.username = p.username AND co.semesterID = " + semesterID;
                    ResultSet rs = DB.query(query);
                    while(rs.next()) {
                    %>
                    <tr>
                        <td><%=rs.getString("courseCode")%></td>
                        <td><%=rs.getString("courseID")%></td>
                        <td><%=rs.getString("courseName")%></td>
                        <td><%=rs.getString("creditHours")%></td>
                        <td>
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#changePenyelaras-<%=rs.getString("co.course_offered_ID")%>"><%=rs.getString("name")%></button>
                            <div id="changePenyelaras-<%=rs.getString("co.course_offered_ID")%>" class="modal fade" role="dialog">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Change Penyelaras</h4>
                                        </div>
                                        <form class='form-horizontal' action="<%=request.getContextPath()%>/UpdatePenyelarasServlet">
                                            <div class="modal-body">
                                                <%
                                                    String query2 = "SELECT * FROM profile AS p, user AS u, section AS s WHERE " +
                                                        "u.username=p.username AND u.username=s.username AND "+
                                                        "s.course_offered_ID = \'"+rs.getString("co.course_offered_ID")+"\' AND s.semesterID="+semesterID;
                                                    ResultSet rs2 = DB.query(query2);
                                                %>
                                                <label>Semester: </label>
                                                <input class="form-control semester-label" disabled>
                                                <label>Course Name: </label>
                                                <input class="form-control" value="<%=rs.getString("courseName")%>" disabled>
                                                <label>Penyelaras: </label>
                                                <select class="form-control penyelaras">
                                                    <option value='' disabled selected style='display:none;'><%=rs.getString("name")%></option>
                                                    <% while(rs2.next()) { %>
                                                    <option id="selected" co_ID="<%=rs.getString("co.course_offered_ID")%>" username="<%=rs2.getString("username")%>"><%=rs2.getString("name")%></option>
                                                    <% } %>
                                                </select>
                                                <input class="" id="username[<%=rs.getString("co.course_offered_ID")%>]" name="username" value="<%=rs.getString("username")%>">
                                                <div class="">
                                                    <input id="course_offered_ID" name="course_offered_ID" value="<%=rs.getString("course_offered_ID")%>">
                                                </div>  
                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-primary" id="addCourse" >Update</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <a href="<%=request.getContextPath()%>/DeleteOfferedCourseServlet?course_offered_ID=<%=rs.getString("co.course_offered_ID")%>" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                    <% } } %>
                    <%
                    if(request.getParameter("semesterID") != null) {
                    String semesterID = request.getParameter("semesterID");
                    String query = "SELECT co.course_offered_ID, c.courseCode, c.courseID, c.courseName, c.creditHours FROM course_offered AS co, course AS c WHERE " +
                            "co.courseCode = c.courseCode AND co.courseID = c.courseID AND " +
                            "co.username IS NULL AND co.semesterID = " + semesterID;
                    ResultSet rs = DB.query(query);
                    while(rs.next()) {
                    %>
                    <tr>
                        <td><%=rs.getString("courseCode")%></td>
                        <td><%=rs.getString("courseID")%></td>
                        <td><%=rs.getString("courseName")%></td>
                        <td><%=rs.getString("creditHours")%></td>
                        <td>
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#changePenyelaras-<%=rs.getString("co.course_offered_ID")%>">New Penyelaras</button>
                            <div id="changePenyelaras-<%=rs.getString("co.course_offered_ID")%>" class="modal fade" role="dialog">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Change Penyelaras</h4>
                                        </div>
                                        <form class='form-horizontal' action="<%=request.getContextPath()%>/UpdatePenyelarasServlet">
                                            <div class="modal-body">
                                                <%
                                                    String query2 = "SELECT * FROM profile AS p, user AS u, section AS s WHERE " +
                                                        "u.username=p.username AND u.username=s.username AND "+
                                                        "s.course_offered_ID = \'"+rs.getString("co.course_offered_ID")+"\' AND s.semesterID="+semesterID;
                                                    ResultSet rs2 = DB.query(query2);
                                                %>
                                                <label>Semester: </label>
                                                <input class="form-control semester-label" disabled>
                                                <label>Course Name: </label>
                                                <input class="form-control" value="<%=rs.getString("courseName")%>" disabled>
                                                <label>Penyelaras: </label>
                                                <select class="form-control penyelaras">
                                                    <option value='' disabled selected style='display:none;'>Select New Penyelaras</option>
                                                    <% while(rs2.next()) { %>
                                                    <option id="selected" co_ID="<%=rs.getString("co.course_offered_ID")%>" username="<%=rs2.getString("username")%>"><%=rs2.getString("name")%></option>
                                                    <% } %>
                                                </select>
                                                <input class="" id="username[<%=rs.getString("co.course_offered_ID")%>]" name="username">
                                                <div class="">
                                                    <input id="course_offered_ID" name="course_offered_ID" value="<%=rs.getString("course_offered_ID")%>">
                                                </div>  
                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-primary" id="addCourse" >Update</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <a href="<%=request.getContextPath()%>/DeleteOfferedCourseServlet?course_offered_ID=<%=rs.getString("co.course_offered_ID")%>" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
            <% if(request.getParameter("semesterID") != null) {%>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#newCourse">Add New Course</button>
            <div id="newCourse" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            New Course
                        </div>
                        <form class='form' action="<%=request.getContextPath()%>/CreateOfferedCourseServlet">
                            <div class="modal-body">
                                <label>Semester: </label>
                                <input class="form-control semester-label" disabled>
                                <label>Course Name:</label>
                                <select class="form-control" name="courseName" id="courseName"></select>
                                <label>Course Code:</label>
                                <input class="form-control" name="courseCode" id="courseCode" disabled>
                                <label>Course ID:</label>
                                <input class="form-control" name="courseID" id="courseID" disabled>
                                <label>Credit Hour:</label>
                                <input class="form-control" name="creditHours" id="creditHours" disabled>
                                <div class="hidden">
                                    <input id="semesterID" name="semesterID">
                                </div> 
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class='btn btn-primary'>New Course</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>                        
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div> <!-- /.container -->
</body>
</html>
