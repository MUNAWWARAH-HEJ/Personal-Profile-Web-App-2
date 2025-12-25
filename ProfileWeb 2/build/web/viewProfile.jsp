<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.ProfileBean" %>
<%@ page import="dao.ProfileDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Profiles</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .search-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }   

        .search-form {
            display: flex;
            gap: 10px;
            max-width: 600px;
            margin: 0 auto;
        }     

        .search-input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #D1D1D1;
            border-radius: 25px;
            font-size: 16px;
            transition: all 0.3s ease;
        }      

        .search-input:focus {
            outline: none;
            border-color: #A080C0;
            box-shadow: 0 0 0 3px rgba(160, 128, 192, 0.2);
        }

        .search-btn {
            padding: 12px 30px;
            background: #000000;
            color: white;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }     

        .clear-btn {
            padding: 12px 20px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
        }
      
        .clear-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }        

        .profiles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .profile-card-mini {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }       

        .profile-card-mini:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .profile-avatar-mini {
            width: 60px;
            height: 60px;
            background: #000000;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
            font-weight: bold;
            color: white;
            margin-bottom: 15px;
        }
        
        .profile-name {
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
       
        .profile-student-id {
            color: #666;
            font-size: 0.95em;
            margin-bottom: 10px;
        }       

        .profile-program-badge {
            display: inline-block;
            background: #000000;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            margin-bottom: 10px;
        }        

        .profile-email {
            color: #555;
            font-size: 0.9em;
            word-break: break-all;
        }       
        .no-profiles {
            text-align: center;
            padding: 60px 20px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            margin-top: 30px;
        }
        
        .no-profiles h2 {
            color: #666;
            margin-bottom: 20px;
        }        

        .back-btn {
            display: inline-block;
            padding: 12px 30px;
            background: #000000;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 20px;
        }        

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        
        .results-info {
            text-align: center;
            color: white;
            font-size: 1.1em;
            margin-bottom: 20px;
            background: rgba(0,0,0,0.6);
            padding: 15px;
            border-radius: 10px;            

        .btn-secondary {
            background-color: #6c757d;
            color: #ffffff;
            margin-left: 10px;
        }



        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Student Profiles</h1>
        </header>
        <div class="search-container">
            <form action="viewProfile.jsp" method="GET" class="search-form">
                <input type="text" 
                       name="search" 
                       class="search-input" 
                       placeholder="Search by name or student ID..."
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit" class="search-btn">Search</button>
                <% if (request.getParameter("search") != null && !request.getParameter("search").trim().isEmpty()) { %>
                    <a href="viewProfile.jsp" class="clear-btn">Clear</a>
                <% } %>
            </form>
        </div>
        
        <%

            ProfileDAO profileDAO = new ProfileDAO();

            List<ProfileBean> profiles;

            String searchKeyword = request.getParameter("search");

            

            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {

                profiles = profileDAO.searchProfiles(searchKeyword);

            } else {

                profiles = profileDAO.getAllProfiles();

            }

        %>     

        <% if (searchKeyword != null && !searchKeyword.trim().isEmpty()) { %>
            <div class="results-info">
                Found <%= profiles.size() %> profile(s) matching "<%= searchKeyword %>"
            </div>
        <% } %>
        
        <% if (profiles != null && !profiles.isEmpty()) { %>
            <div class="profiles-grid">
                <% for (ProfileBean profile : profiles) { %>
                    <div class="profile-card-mini">
                        <div class="profile-avatar-mini">
                            <%= profile.getName().substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="profile-name"><%= profile.getName() %></div>
                        <div class="profile-student-id">ID: <%= profile.getStudentId() %></div>
                        <div class="profile-program-badge"><%= profile.getProgram() %></div>
                        <div class="profile-email">
                            <strong>Email:</strong> <%= profile.getEmail() %>
                        </div>
                        <% if (profile.getHobbies() != null && !profile.getHobbies().trim().isEmpty()) { %>
                            <div style="margin-top: 10px; color: #666; font-size: 0.9em;">
                                <strong>Hobbies:</strong> <%= profile.getHobbies().length() > 50 ? 
                                    profile.getHobbies().substring(0, 50) + "..." : profile.getHobbies() %>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="no-profiles">
                <h2>
                    <% if (searchKeyword != null && !searchKeyword.trim().isEmpty()) { %>
                        No profiles found matching your search.
                    <% } else { %>
                        No profiles found.
                    <% } %>
                </h2>
            </div>
        <% } %>

    </div>
        <div class="profile-actions" style="display: flex; visibility: visible; opacity: 1; background: #eee; border-radius: 12px;">
                <a href="index.html" class="btn btn-secondary">Create Another Profile</a>
                
        </div>
</body>
</html>