package test;

public class LoginVO {
    private String id, password, name, email, regDate;

    public LoginVO() {}

    public LoginVO(String id, String password, String name, String email, String regDate) {
        this.id = id;
        this.password = password;
        this.name = name;
        this.email = email;
        this.regDate = regDate;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }
}
