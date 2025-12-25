package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import beans.ProfileBean;
import dao.ProfileDAO;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProfileDAO profileDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        profileDAO = new ProfileDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("index.html");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String introduction = request.getParameter("introduction");
        
        if (name == null || name.trim().isEmpty() || 
            studentId == null || studentId.trim().isEmpty() ||
            program == null || program.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            introduction == null || introduction.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("index.html").forward(request, response);
            return;
        }
        
        ProfileBean existingProfile = profileDAO.getProfileByStudentId(studentId);
        if (existingProfile != null) {
            response.sendRedirect("index.html?duplicateId=true");
            return;
        }

        ProfileBean profile = new ProfileBean(name, studentId, program, email, hobbies, introduction);
        
        boolean success = profileDAO.insertProfile(profile);
        
        if (success) {
            request.setAttribute("name", name);
            request.setAttribute("studentId", studentId);
            request.setAttribute("program", program);
            request.setAttribute("email", email);
            request.setAttribute("hobbies", hobbies);
            request.setAttribute("introduction", introduction);
            
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to save profile. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}