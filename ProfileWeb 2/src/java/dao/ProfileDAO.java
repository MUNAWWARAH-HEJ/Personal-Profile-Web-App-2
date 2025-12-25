package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import beans.ProfileBean;
import utils.DatabaseConnection;

public class ProfileDAO {
        public boolean insertProfile(ProfileBean profile) {
        String sql = "INSERT INTO profile (name, student_id, program, email, hobbies, introduction) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getStudentId());
            pstmt.setString(3, profile.getProgram());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntroduction());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<ProfileBean> getAllProfiles() {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profile ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                ProfileBean profile = extractProfileFromResultSet(rs);
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return profiles;
    }
    
    
    public List<ProfileBean> searchProfiles(String keyword) {
        List<ProfileBean> profiles = new ArrayList<>();

        String sql = "SELECT * FROM profile " +
                     "WHERE LOWER(name) LIKE ? OR LOWER(student_id) LIKE ? " +
                     "ORDER BY created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword.toLowerCase() + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ProfileBean profile = extractProfileFromResultSet(rs);
                profiles.add(profile);
            }

            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profiles;
    }

    public ProfileBean getProfileByStudentId(String studentId) {
        String sql = "SELECT * FROM profile WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                ProfileBean profile = extractProfileFromResultSet(rs);
                rs.close();
                return profile;
            }
            
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    private ProfileBean extractProfileFromResultSet(ResultSet rs) throws SQLException {
        ProfileBean profile = new ProfileBean();
        profile.setId(rs.getInt("id"));
        profile.setName(rs.getString("name"));
        profile.setStudentId(rs.getString("student_id"));
        profile.setProgram(rs.getString("program"));
        profile.setEmail(rs.getString("email"));
        profile.setHobbies(rs.getString("hobbies"));
        profile.setIntroduction(rs.getString("introduction"));
        profile.setCreatedAt(rs.getTimestamp("created_at"));
        return profile;
    }
}