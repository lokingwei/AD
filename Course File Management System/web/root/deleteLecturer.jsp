<%@ page import ="java.sql.*, common.DB" %>

<jsp:include page="../auth.jsp"/>
<%
	String username = request.getParameter("username");

	int rs = DB.update("DELETE FROM profile WHERE username='" + username + "'");

	int rs2 = DB.update("DELETE FROM user WHERE username='" + username + "'");

	response.sendRedirect("viewLecturers.jsp");
%>