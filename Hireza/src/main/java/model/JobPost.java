//package model;
//
//import java.util.Date;
//
//
//public class JobPost {
//    private String jobId;
//    private String companyId; // Store as String
//    private String companyName;
//    private String jobTitle;
//    private String workMode;
//    private String location;
//    private String employmentType;
//    private String jobDescription;
//    private String requiredSkills;
//    private String experienceLevel;
//    private Date applicationDeadline;
//    private String salaryRange;
//    private String workingHoursShifts;
//    private String status;
//    private String adminNotes;
//    private Date createdAt;
//    private Date updatedAt;
//    private Company company;
//
//    public JobPost() {}
//
//    // Constructor for creating a new post
//    public JobPost(String companyId, String companyName, String jobTitle, String workMode, String location,
//                   String employmentType, String jobDescription, String requiredSkills,
//                   String experienceLevel, Date applicationDeadline, String salaryRange, String workingHoursShifts) {
//        this.companyId = companyId;
//        this.companyName = companyName;
//        this.jobTitle = jobTitle;
//        this.workMode = workMode;
//        this.location = location;
//        this.employmentType = employmentType;
//        this.jobDescription = jobDescription;
//        this.requiredSkills = requiredSkills;
//        this.experienceLevel = experienceLevel;
//        this.applicationDeadline = applicationDeadline;
//        this.salaryRange = salaryRange;
//        this.workingHoursShifts = workingHoursShifts;
//    }
//
//
//    public String getJobId() { return jobId; }
//    public void setJobId(String jobId) { this.jobId = jobId; }
//
//    public String getCompanyId() { return companyId; } // Changed to return String
//    public void setCompanyId(String companyId) { this.companyId = companyId; }
//
//    public String getCompanyName() { return companyName; }
//    public void setCompanyName(String companyName) { this.companyName = companyName; }
//
//    public String getJobTitle() { return jobTitle; }
//    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }
//
//    public String getWorkMode() { return workMode; }
//    public void setWorkMode(String workMode) { this.workMode = workMode; }
//
//    public String getLocation() { return location; }
//    public void setLocation(String location) { this.location = location; }
//
//    public String getEmploymentType() { return employmentType; }
//    public void setEmploymentType(String employmentType) { this.employmentType = employmentType; }
//
//    public String getJobDescription() { return jobDescription; }
//    public void setJobDescription(String jobDescription) { this.jobDescription = jobDescription; }
//
//    public String getRequiredSkills() { return requiredSkills; }
//    public void setRequiredSkills(String requiredSkills) { this.requiredSkills = requiredSkills; }
//
//    public String getExperienceLevel() { return experienceLevel; }
//    public void setExperienceLevel(String experienceLevel) { this.experienceLevel = experienceLevel; }
//
//    public Date getApplicationDeadline() { return applicationDeadline; }
//    public void setApplicationDeadline(Date applicationDeadline) { this.applicationDeadline = applicationDeadline; }
//
//    public String getSalaryRange() { return salaryRange; }
//    public void setSalaryRange(String salaryRange) { this.salaryRange = salaryRange; }
//
//    public String getWorkingHoursShifts() { return workingHoursShifts; }
//    public void setWorkingHoursShifts(String workingHoursShifts) { this.workingHoursShifts = workingHoursShifts; }
//
//    public String getStatus() { return status; }
//    public void setStatus(String status) { this.status = status; }
//
//    public String getAdminNotes() { return adminNotes; }
//    public void setAdminNotes(String adminNotes) { this.adminNotes = adminNotes; }
//
//    public Date getCreatedAt() { return createdAt; }
//    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
//
//    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
//
//    public Company getCompany() { return company; }
//    public void setCompany(Company company) { this.company = company; }
//
//    public String getId() { return jobId; }
//}

package model;

import java.util.Date;

public class JobPost {
    private String jobId;
    private String companyId; // Store as String
    private String companyName;
    private String jobTitle;
    private String workMode;
    private String location;
    private String employmentType;
    private String jobDescription;
    private String requiredSkills;
    private String experienceLevel;
    private Date applicationDeadline;
    private String salaryRange;
    private String workingHoursShifts;
    private String status;
    private String adminNotes;
    private Date createdAt;
    private Date updatedAt;
    private Company company;

    public JobPost() {}

    // Constructor for creating a new post
    public JobPost(String companyId, String companyName, String jobTitle, String workMode, String location,
                   String employmentType, String jobDescription, String requiredSkills,
                   String experienceLevel, Date applicationDeadline, String salaryRange, String workingHoursShifts) {
        this.companyId = companyId;
        this.companyName = companyName;
        this.jobTitle = jobTitle;
        this.workMode = workMode;
        this.location = location;
        this.employmentType = employmentType;
        this.jobDescription = jobDescription;
        this.requiredSkills = requiredSkills;
        this.experienceLevel = experienceLevel;
        this.applicationDeadline = applicationDeadline;
        this.salaryRange = salaryRange;
        this.workingHoursShifts = workingHoursShifts;
    }

    public String getJobId() { return jobId; }
    public void setJobId(String jobId) { this.jobId = jobId; }

    public String getCompanyId() { return companyId; } // Changed to return String
    public void setCompanyId(String companyId) { this.companyId = companyId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getWorkMode() { return workMode; }
    public void setWorkMode(String workMode) { this.workMode = workMode; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getEmploymentType() { return employmentType; }
    public void setEmploymentType(String employmentType) { this.employmentType = employmentType; }

    public String getJobDescription() { return jobDescription; }
    public void setJobDescription(String jobDescription) { this.jobDescription = jobDescription; }

    public String getRequiredSkills() { return requiredSkills; }
    public void setRequiredSkills(String requiredSkills) { this.requiredSkills = requiredSkills; }

    public String getExperienceLevel() { return experienceLevel; }
    public void setExperienceLevel(String experienceLevel) { this.experienceLevel = experienceLevel; }

    public Date getApplicationDeadline() { return applicationDeadline; }
    public void setApplicationDeadline(Date applicationDeadline) { this.applicationDeadline = applicationDeadline; }

    public String getSalaryRange() { return salaryRange; }
    public void setSalaryRange(String salaryRange) { this.salaryRange = salaryRange; }

    public String getWorkingHoursShifts() { return workingHoursShifts; }
    public void setWorkingHoursShifts(String workingHoursShifts) { this.workingHoursShifts = workingHoursShifts; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getAdminNotes() { return adminNotes; }
    public void setAdminNotes(String adminNotes) { this.adminNotes = adminNotes; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }

    public Company getCompany() { return company; }
    public void setCompany(Company company) { this.company = company; }

    public String getId() { return jobId; }
}