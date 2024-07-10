<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Database Connection</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .failure {
            color: red;
            font-weight: bold;
        }
        .result-box {
            margin-top: 20px;
            padding: 15px;
            border: 2px solid #000;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .result {
            width: 100%;
            border-collapse: collapse;
        }
        .result, .result th, .result td {
            border: 1px solid #000;
        }
        .result th, .result td {
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h1>Database Connection Results</h1>
    <%
    Connection conn = null;

    try {
        // JNDI
        Context init = new InitialContext();
        DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysql");
        conn = ds.getConnection();
    %>
    <div class="success">JNDI Connection Success!!!</div>
    <div class="result-box">
        <table class="result">
            <tr><th>ID</th><th>Name</th><th>Email</th></tr>
        <%
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM world.member");
            
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
            </tr>
        <%
            }
            
            rs.close();
            stmt.close();
        %>
        </table>
    </div>
    <%
    } catch (Exception e) {
    %>
    <div class="failure">JNDI Connection Failure!!!</div>
    <div class="result-box"><pre><%= e.toString() %></pre></div>
    <%
    }

    try {
        // DriverManager
        String DB_URL = "jdbc:mysql://${DB_ADDR}:3306/world";
        String DB_USER = "${DB_USERNAME}";
        String DB_PASSWORD = "${DB_PASSWORD}";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    %>
    <div class="success">DriverManager Connection Success!!!</div>
    <div class="result-box">
        <table class="result">
            <tr><th>ID</th><th>Name</th><th>Email</th></tr>
        <%
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM world.member");
            
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
            </tr>
        <%
            }
            
            rs.close();
            stmt.close();
        %>
        </table>
    </div>
    <%
    } catch (Exception e) {
    %>
    <div class="failure">DriverManager Connection Failure!!!</div>
    <div class="result-box"><pre><%= e.toString() %></pre></div>
    <%
    } finally {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
    %>
    <div class="failure">Error closing connection: <%= e.getMessage() %></div>
    <%
        }
    }
    %>
</body>
</html>