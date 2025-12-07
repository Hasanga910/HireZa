package model;

public class Admin extends User {

    public Admin() {
        super();
        this.setRole("Admin");
    }

    public Admin(String fullName, String username, String email, String password, String phone) {
        super(fullName, username, email, password, "Admin",phone);
    }

    // You can add admin-specific methods later if needed
}