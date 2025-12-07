package model;

public class Company {
    private String companyId; // Changed to String
    private String userId;
    private String companyName;
    private String industry;
    private String description;
    private String website;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private String contactNumber;
    private String companySize;
    private int foundedYear;
    private String workMode;
    private String employmentTypes;
    private String companyEmail;
    private byte[] logo;
    private String aboutUs;
    private boolean profileCompleted;

    public Company() {}

    public Company(String userId, String companyName, String industry, String description, String website,
                   String address, String city, String state, String zipCode, String contactNumber,
                   String companySize, int foundedYear, String workMode, String employmentTypes,
                   String companyEmail, byte[] logo, String aboutUs) {
        this.userId = userId;
        this.companyName = companyName;
        this.industry = industry;
        this.description = description;
        this.website = website;
        this.address = address;
        this.city = city;
        this.state = state;
        this.zipCode = zipCode;
        this.contactNumber = contactNumber;
        this.companySize = companySize;
        this.foundedYear = foundedYear;
        this.workMode = workMode;
        this.employmentTypes = employmentTypes;
        this.companyEmail = companyEmail;
        this.logo = logo;
        this.aboutUs = aboutUs;
        this.profileCompleted = true;
    }

    // Getters and Setters
    public String getCompanyId() { return companyId; }
    public void setCompanyId(String companyId) { this.companyId = companyId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getIndustry() { return industry; }
    public void setIndustry(String industry) { this.industry = industry; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getZipCode() { return zipCode; }
    public void setZipCode(String zipCode) { this.zipCode = zipCode; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getCompanySize() { return companySize; }
    public void setCompanySize(String companySize) { this.companySize = companySize; }

    public int getFoundedYear() { return foundedYear; }
    public void setFoundedYear(int foundedYear) { this.foundedYear = foundedYear; }

    public String getWorkMode() { return workMode; }
    public void setWorkMode(String workMode) { this.workMode = workMode; }

    public String getEmploymentTypes() { return employmentTypes; }
    public void setEmploymentTypes(String employmentTypes) { this.employmentTypes = employmentTypes; }

    public String getCompanyEmail() { return companyEmail; }
    public void setCompanyEmail(String companyEmail) { this.companyEmail = companyEmail; }

    public byte[] getLogo() { return logo; }
    public void setLogo(byte[] logo) { this.logo = logo; }

    public String getAboutUs() { return aboutUs; }
    public void setAboutUs(String aboutUs) { this.aboutUs = aboutUs; }

    public boolean isProfileCompleted() { return profileCompleted; }
    public void setProfileCompleted(boolean profileCompleted) { this.profileCompleted = profileCompleted; }
}
