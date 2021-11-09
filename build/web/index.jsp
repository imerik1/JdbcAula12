<%-- 
    Document   : index
    Created on : 8 de nov. de 2021, 21:05:37
    Author     : erik_
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="db.TasksConnector"%>
<%@page import="java.util.ArrayList"%>
<%@page import="web.DbListener"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd/MM/yyyy");
    Exception requestException = null;
    ArrayList<String> taskList = new ArrayList();
    try {
        if (request.getParameter("add") != null) {
            String taskName = request.getParameter("taskName");
            TasksConnector.addTasks(taskName);
            response.sendRedirect(request.getRequestURI());
        }
        if (request.getParameter("remove") != null) {
            String taskName = request.getParameter("taskName");
            TasksConnector.removeTasks(taskName);
            response.sendRedirect(request.getRequestURI());
        }
        taskList = TasksConnector.getTasks();
    } catch (Exception e) {
        response.sendRedirect(request.getRequestURI());
    }

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JDBC - Todo List</title>
    </head>
    <body>
        <header>
            <h1>JDBC - Erik Santana Marques dos Santos</h1>
            <h2>To-Do List</h2>
            <p><%= LocalDateTime.now().format(formatter) %></p>
        </header>
        <%if (DbListener.exception != null) {%>
        <div>
            Erro na criação do BD: <%= DbListener.exception.getMessage()%>
        </div>
        <%}%>
        <%if (requestException != null) {%>
        <div>
            Erro na leitura ou gravação das tarefas: <%= requestException.getMessage()%>
        </div>
        <%}%>
        <form>
            <input type="text" name="taskName" />
            <input type="submit" name="add" value="+" />
        </form>
        <table>
            <%for (String taskName : taskList) {%>
            <tr>
                <td><%= taskName%></td>
                <td>
                    <form>
                        <input type="hidden" name="taskName" value="<%= taskName%>" />
                        <input type="submit" name="remove" value="-" />
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
