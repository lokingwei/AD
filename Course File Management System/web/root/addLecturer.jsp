<%@ page import ="java.sql.*, common.DB" %>
<jsp:include page="../auth.jsp"/>
<!doctype html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/auto-complete.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Lecuter - Add lecturer</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery-ui-1.9.2.custom.min.js"></script>
 
</head>
<body>
    <div class="container">
    
        <div class="jumbotron">
            <h1>Course File Management System</h1>
            <p>Upload all your course-related documents here for the usage of students and administrators.</p>
        </div>
        
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <ul class="nav navbar-nav">
                    <li><a href="rootHome.jsp">Home</a></li>
                     <li class="active"><a href="#">Lecturers</a></li>
                    <li><a href="viewCourses.jsp">Courses</a></li>
                    <li><a href="viewSemesters.jsp">Semesters</a></li>
                    
                </ul>
                
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="logOut.html">Log Out</a></li>
                </ul>
            </div> <!-- /.container-fluid -->
        </nav>
        
        <div class="panel">
            
        </div>
        
  


		<form class="form-horizontal" method="post" action="addLecturerDB.jsp">
            <div class="form-group">
                 <label for="username" class="control-label col-xs-4">Username</label>
                     <div class="col-xs-8">
                                <input type="text" class="form-control" name="username" placeholder="username">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="password" class="control-label col-xs-4">Password</label>
                            <div class="col-xs-8">
                                <input type="password" class="form-control" name="password" placeholder="Password">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="name" class="control-label col-xs-4">Name</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="name" placeholder="Name">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="control-label col-xs-4">Email Address</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="emailAdd" placeholder="Email Address">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phoneNo" class="control-label col-xs-4">Phone Number</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="phoneNo" placeholder="Phone Number">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="department" class="control-label col-xs-4">Department</label>
                            <div class="col-xs-8">
                                <input type="text" class="form-control" name="department" placeholder="Department">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="status" class="control-label col-xs-4">Status</label>
                            <div class="radio col-xs-8">
                            <label class="radio-inline"><input type="radio" name="status" value="Active">Active</label>
                            <label class="radio-inline"><input type="radio" name="status" value="Inactive">Inactive</label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-xs-offset-4 col-xs-8">
                                <button type="submit" class="btn btn-primary">Add</button>
                            </div>
                        </div>
                    </form>


    </div> <!-- /.container -->
</body>
</html>