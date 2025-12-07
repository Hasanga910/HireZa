
-- USERS TABLE
CREATE TABLE Users (
    userId VARCHAR(10) PRIMARY KEY, 
    fullName NVARCHAR(100) NOT NULL,
    username NVARCHAR(50) UNIQUE NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(50) NOT NULL,      
    createdAt DATETIME DEFAULT GETDATE(),
    phone NVARCHAR(20) NOT NULL
);


-- JOB SEEKER PROFILE
CREATE TABLE JobSeekerProfile (
    profileId VARCHAR(10) PRIMARY KEY,        
    seekerId VARCHAR(10) NOT NULL UNIQUE,
    title NVARCHAR(100),
    location NVARCHAR(100),
    about NVARCHAR(MAX),
    experience NVARCHAR(MAX),
    education NVARCHAR(MAX),
    skills NVARCHAR(500),
    profilePic NVARCHAR(255),
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_JobSeekerProfile_Users 
        FOREIGN KEY (seekerId) 
        REFERENCES Users(userId)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


-- COMPANY TABLE
CREATE TABLE Company (
    companyId VARCHAR(10) PRIMARY KEY,   
    userId VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES Users(userId) ON DELETE CASCADE,
    companyName NVARCHAR(255) NOT NULL,
    industry NVARCHAR(100),
    description NVARCHAR(MAX),
    website NVARCHAR(255),
    address NVARCHAR(500),
    city NVARCHAR(100),
    state NVARCHAR(100),
    zipCode NVARCHAR(20),
    contactNumber NVARCHAR(50),
    companySize NVARCHAR(50),
    foundedYear INT,
    workMode NVARCHAR(20), -- Online, Offline, Hybrid
    employmentTypes NVARCHAR(255),
    companyEmail NVARCHAR(255),
    aboutUs NVARCHAR(MAX),
    profileCompleted BIT DEFAULT 0,
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    logo VARBINARY(MAX)
);


-- POSTS TABLE
CREATE TABLE Posts (
    JobID VARCHAR(10) PRIMARY KEY,               
    CompanyID VARCHAR(10) NOT NULL,            
    CompanyName NVARCHAR(255) NOT NULL,  
    JobTitle NVARCHAR(255) NOT NULL,
    WorkMode NVARCHAR(50),  
    Location NVARCHAR(255),  
    EmploymentType NVARCHAR(100),  
    JobDescription NVARCHAR(MAX),
    RequiredSkills NVARCHAR(MAX),
    ExperienceLevel NVARCHAR(100),  
    ApplicationDeadline DATE,
    SalaryRange NVARCHAR(100),  
    WorkingHoursShifts NVARCHAR(100),  
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'pending',
    AdminNotes NVARCHAR(MAX) DEFAULT 'No notes provided',

    CONSTRAINT FK_Posts_Company 
        FOREIGN KEY (CompanyID) 
        REFERENCES Company(companyId) 
        ON DELETE CASCADE
);


-- JOB APPLICATIONS
CREATE TABLE JobApplications (
    applicationId VARCHAR(10) PRIMARY KEY,
    jobId VARCHAR(10) NOT NULL,
    seekerId VARCHAR(10) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone NVARCHAR(50),
    coverLetter NVARCHAR(MAX),
    resumeFile NVARCHAR(255),
    appliedAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT 'Pending',

    CONSTRAINT FK_JobApplications_Posts 
        FOREIGN KEY (jobId) 
        REFERENCES Posts(JobID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,

    CONSTRAINT FK_JobApplications_Users 
        FOREIGN KEY (seekerId) 
        REFERENCES Users(userId) 
        ON DELETE NO ACTION 
        ON UPDATE CASCADE
);


-- CV TABLE
CREATE TABLE CV (
    cvId VARCHAR(10) PRIMARY KEY,  
    seekerId VARCHAR(10) NOT NULL,  
    fullName NVARCHAR(100),
    email NVARCHAR(100),
    phone NVARCHAR(50),
    linkedin NVARCHAR(255),
    education NVARCHAR(MAX),
    institute NVARCHAR(255),
    jobTitle NVARCHAR(100),
    company NVARCHAR(100),
    experienceYears NVARCHAR(50),
    skills NVARCHAR(MAX),
    interests NVARCHAR(MAX),
    projects NVARCHAR(MAX),
    certifications NVARCHAR(MAX),
    createdAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_CV_Users 
        FOREIGN KEY (seekerId) 
        REFERENCES Users(userId) 
        ON DELETE CASCADE
);


-- NOTIFICATIONS TABLE
CREATE TABLE Notifications (
    notificationId VARCHAR(10) PRIMARY KEY, 
    companyId VARCHAR(10) NOT NULL,
    jobId VARCHAR(10) NULL, 
    userId VARCHAR(10) NULL,
    message NVARCHAR(500) NOT NULL,
    type NVARCHAR(50) NOT NULL, 
    isRead BIT DEFAULT 0,
    createdAt DATETIME DEFAULT GETDATE(),
    jobTitle NVARCHAR(255),
    adminNotes NVARCHAR(MAX),
);
DROP TABLE Notifications;


--NOTIFICATION TRIGGER
CREATE TRIGGER trg_DeleteRejectedPostNotifications
ON Posts
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Delete notifications for rejected posts that were just deleted
    DELETE FROM Notifications
    WHERE jobId IN (
        SELECT JobID 
        FROM DELETED 
        WHERE Status = 'rejected'
    );
END;
GO

--INTERVIEW TABLE
CREATE TABLE Interview (
    recruiterId VARCHAR(10) PRIMARY KEY,
    applicationId VARCHAR(10) NOT NULL,
    companyId VARCHAR(10) NOT NULL,
    userId VARCHAR(10) NOT NULL,
    jobId VARCHAR(10) NOT NULL,
    interviewer NVARCHAR(255) NOT NULL,
    location NVARCHAR(500),
    mode NVARCHAR(50) NOT NULL CHECK (mode IN ('Online','Offline','Onsite')),
    scheduledAt DATETIME2 NOT NULL,
    durationMinutes INT CHECK (durationMinutes > 0 AND durationMinutes <= 480),
    notes NVARCHAR(MAX),
    status NVARCHAR(50) NOT NULL DEFAULT 'SCHEDULED'
        CHECK (status IN ('SCHEDULED','RESCHEDULED','CANCELLED','COMPLETED')),
    createdAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    updatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    -- Foreign keys
    CONSTRAINT FK_Interview_Application FOREIGN KEY (applicationId)
        REFERENCES JobApplications(applicationId) ON DELETE CASCADE,

    CONSTRAINT FK_Interview_Company FOREIGN KEY (companyId)
        REFERENCES Company(companyId),

    CONSTRAINT FK_Interview_User FOREIGN KEY (userId)
        REFERENCES Users(userId),

    CONSTRAINT FK_Interview_JobPost FOREIGN KEY (jobId)
        REFERENCES Posts(JobID)
);

-- RECRUITER TABLE
CREATE TABLE Recruiter (
    recruiterId VARCHAR(10) PRIMARY KEY,
    userId VARCHAR(10) NOT NULL UNIQUE,
    companyId VARCHAR(10) NOT NULL,
    position NVARCHAR(100),  -- e.g., 'HR Manager'
    bio NVARCHAR(MAX),       -- Additional personal details
    createdAt DATETIME DEFAULT GETDATE(),
    updatedAt DATETIME DEFAULT GETDATE(),
    profileCompleted BIT DEFAULT 0
);
-- add FKs after table creation to control names and options
ALTER TABLE Recruiter
    ADD CONSTRAINT FK_Recruiter_Users FOREIGN KEY (userId) REFERENCES Users(userId) ON DELETE CASCADE;

ALTER TABLE Recruiter
    ADD CONSTRAINT FK_Recruiter_Company FOREIGN KEY (companyId) REFERENCES Company(companyId) ON DELETE NO ACTION;



-- RECRUITER ACTIVITY LOG 
CREATE TABLE RecruiterActivityLog (
    logId VARCHAR(10) PRIMARY KEY,  -- changed from INT IDENTITY
    recruiterId VARCHAR(10) NOT NULL,
    applicationId VARCHAR(10) NOT NULL,
    action NVARCHAR(100) NOT NULL, -- e.g., 'Status Changed to Interview'
    actionDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_RecruiterActivity_Recruiter FOREIGN KEY (recruiterId)
        REFERENCES Recruiter(recruiterId),
    CONSTRAINT FK_RecruiterActivity_Application FOREIGN KEY (applicationId)
        REFERENCES JobApplications(applicationId)
);
GO


-- INSERT ADMIN USER
INSERT INTO Users (userId, fullName, username, email, password, role, phone)
VALUES (
    'A001',
    'Sajana Hasanga',
    'sajana',
    'sajana@gmail.com',
    '123456',
    'Admin',
    '0771234567'
);


-- TEST QUERIES
SELECT * FROM Users;
SELECT * FROM JobSeekerProfile;
SELECT * FROM Company;
SELECT * FROM Posts;
SELECT * FROM JobApplications;
SELECT * FROM Notifications;
SELECT * FROM CV;
SELECT * FROM Recruiter;
SELECT * FROM RecruiterActivityLog;






