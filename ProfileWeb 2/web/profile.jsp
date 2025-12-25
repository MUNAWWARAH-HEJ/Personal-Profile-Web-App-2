<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - <%= request.getAttribute("name") %></title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="profile-card">
            <header class="profile-header">
                <div class="avatar">
                    <%= ((String)request.getAttribute("name")).substring(0, 1).toUpperCase() %>
                </div>
                <h1>Profile Created Successfully!</h1>
                <h2><%= request.getAttribute("name") %></h2>
                <p class="student-id">Student ID: <%= request.getAttribute("studentId") %></p>
            </header>
            
            <div class="profile-content">
                <div class="info-section">
                    <h3>Academic Information</h3>
                    <div class="info-item">
                        <strong>Program:</strong> 
                        <span class="program-badge"><%= request.getAttribute("program") %></span>
                    </div>
                </div>
                
                <div class="info-section">
                    <h3>Contact Information</h3>
                    <div class="info-item">
                        <strong>Email:</strong> 
                        <span>
                            <%= request.getAttribute("email") %>
                        </span>
                    </div>
                </div>
                
                <% if (request.getAttribute("hobbies") != null && 
                       !((String)request.getAttribute("hobbies")).trim().isEmpty()) { %>
                <div class="info-section">
                    <h3>Hobbies & Interests</h3>
                    <div class="hobbies-content">
                        <%= ((String)request.getAttribute("hobbies")).replace("\n", "<br>") %>
                    </div>
                </div>
                <% } %>
                
                <div class="info-section">
                    <h3>About Me</h3>
                    <div class="introduction-content">
                        <%= ((String)request.getAttribute("introduction")).replace("\n", "<br>") %>
                    </div>
                </div>
            </div>
            
            <div class="profile-actions" style="display: flex; visibility: visible; opacity: 1; background: #eee; border-radius: 12px;">
                <a href="index.html" class="btn btn-secondary">Create Another Profile</a>
                <a href="viewProfile.jsp" class="btn btn-secondary">View All Profiles</a>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelector('.profile-card').style.opacity = '0';
            setTimeout(() => {
                document.querySelector('.profile-card').style.transition = 'opacity 0.5s ease-in';
                document.querySelector('.profile-card').style.opacity = '1';
            }, 100);
        });
    </script>
</body>
</html>