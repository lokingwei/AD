<!doctype html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <div class="container">
    
        <div class="jumbotron">
            <h1>Course File Management System</h1>
            <p>Upload all your course-related documents here for the usage of students and administrators.</p>
        </div>
        
        <jsp:include page="../header.jsp"/>
        
        <div class="col-xs-8 panel panel-default">
            <h1>Test</h1>
            <p>You are logged in as: Lecturer</p>
        </div>
              
        <div class="col-xs-4 panel panel-default">
            <h1>Test 2</h1>
            <p>The quick brown fox jumps over the lazy dog</p>
        </div>
        
    </div> <!-- /.container -->
</body>
</html>