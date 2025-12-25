package beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class ProfileBean implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String name;
    private String studentId;
    private String program;
    private String email;
    private String hobbies;
    private String introduction;
    private Timestamp createdAt;
    
    public ProfileBean() {
    }
    
    public ProfileBean(String name, String studentId, String program, 
                      String email, String hobbies, String introduction) {
        this.name = name;
        this.studentId = studentId;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.introduction = introduction;
    }
    
    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public String getProgram() {
        return program;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getHobbies() {
        return hobbies;
    }
    
    public String getIntroduction() {
        return introduction;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public void setProgram(String program) {
        this.program = program;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }
    
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "ProfileBean [id=" + id + ", name=" + name + ", studentId=" + studentId + 
               ", program=" + program + ", email=" + email + "]";
    }
}