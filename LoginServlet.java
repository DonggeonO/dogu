package test;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    @Override
    public void init() {
        try {
            Class.forName("org.sqlite.JDBC");
            System.out.println("✔ JDBC 드라이버 로딩 성공");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
        throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        LoginDAO dao = new LoginDAO();
        LoginVO vo = dao.login(id, password);

        if (vo != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", vo);
            res.sendRedirect("springmvc/index5.jsp"); // 성공 시 index5.jsp로 이동
        } else {
            res.setContentType("text/html; charset=UTF-8");
            PrintWriter out = res.getWriter();
            out.println("<script>alert('아이디 또는 비밀번호가 올바르지 않습니다.'); history.back();</script>");
        }
    }
}
