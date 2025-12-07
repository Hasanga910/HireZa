package model;

public class Assistant extends User {
    public Assistant() {
        super();
    }

    public Assistant(String fullName, String username, String email, String password, String role) {
        super(fullName, username, email, password, role);
    }

    public Assistant(String fullName, String username, String email, String password, String role, String phone) {
        super(fullName, username, email, password, role, phone);
    }
}