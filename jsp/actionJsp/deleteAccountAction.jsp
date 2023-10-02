<%@ page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %> 
<%@ page import="java.sql.Connection" %> 
<%@ page import="java.sql.PreparedStatement" %> 

<%
    //계정 삭제 Action형 jsp

    //db 연결
    request.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/calendar","stageus","1234");

    //세션 가져오기
    String userSessionIdx = (String)session.getAttribute("idx");

    //유저가 쓴 댓글 삭제
    //String deleteCommentSQL = "DELETE comments FROM comments JOIN users on comments.users_idx=users.idx WHERE users.idx=?;";
    //유저가 쓴 게시글에 달린 댓글 삭제
    //String deletePostComentsSQL = "DELETE comments FROM comments JOIN posts on comments.posts_idx=posts.idx WHERE posts.users_idx=?;";
    //유저가 쓴 게시글 삭제
    //String deletePostSQL = "DELETE posts FROM posts JOIN users on posts.users_idx=users.idx WHERE users.idx=?;";
    //유저 계정 삭제
    String deleteAccountSQL = "DELETE FROM user WHERE idx=?;";

    //PreparedStatement query1 = connect.prepareStatement(deleteCommentSQL);
    //PreparedStatement query2 = connect.prepareStatement(deletePostComentsSQL);
    //PreparedStatement query3 = connect.prepareStatement(deletePostSQL);
    PreparedStatement query4 = connect.prepareStatement(deleteAccountSQL);

    //query1.setString(1, userSessionIdx);
    //query2.setString(1, userSessionIdx);
    //query3.setString(1, userSessionIdx);
    query4.setString(1, userSessionIdx);

    //query1.executeUpdate();
    //query2.executeUpdate();
    //query3.executeUpdate();
    query4.executeUpdate();

    //세션 삭제
    session.invalidate();
%>

<html>
    <script>
        localStorage.clear()
        alert('성공적으로 탈퇴하었습니다.')
        location.href = "../pageJsp/homePage.jsp"
    </script>
</html>