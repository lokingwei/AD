<%-- 
    Document   : lecturerAutoComplete
    Created on : Aug 13, 2015, 1:50:05 PM
    Author     : Kiwi
--%>

<%@page import="AutoComplete.Select2OptionGenerator"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<select name= "username" class="form-control lecturerName" 
        <% if(request.getParameter("id") != null && !request.getParameter("id").equals("")) { %>
        id="<%=request.getParameter("id")%>"
        <% } %>
        >
<%
    String query = "Select u.username, p.name FROM user AS u, profile AS p WHERE u.username = p.username AND u.userType = 'lecturer' ORDER BY name";
    HashMap<String,String> extra = new HashMap();
    extra.put("value", "[username]");
    extra.put("text", "[name]");
    out.print(Select2OptionGenerator.generate(query, "text", extra));
%>
</select>
<% if(request.getParameter("prebuild") != null && !request.getParameter("prebuild").equals("")) { %>
    <script>
        $(".lecturerName").select2({
            placeholder: "Select A Lecturer",
            allowClear : true,
            theme: "bootstrap"
        });
        <% if(request.getParameter("username") != null && !request.getParameter("username").equals("")) { %>
        $(".lecturerName").select2("val", "<%=request.getParameter("username")%>");
        <% } else { %>
        $("#lecturerName").select2("val", "");    
        <% } %>
        $(".lecturerName").change(function() {
            <% if(request.getParameter("selectAction") != null) { 
                String action = request.getParameter("selectAction");
                if(action.equals("none")) { %>
                <% } %>
            <%} else {%>
            dataSet = { 
                "username":$(".lecturerName").val()
            };
            var uri = new URI(window.location.href);
            var query = new URI(uri.search());
            var query = query.setSearch(dataSet);
            var uri = uri.pathname();
            var newQueryUrl = uri + query;
            window.location.href = newQueryUrl; 
            <% } %>
        });
    </script>
<% } %>