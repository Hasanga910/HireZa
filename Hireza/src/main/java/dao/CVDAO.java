//package dao;
//
//import com.itextpdf.text.*;
//import com.itextpdf.text.pdf.*;
//import model.CV;
//import model.JobSeekerProfile;
//import util.DBConnection;
//
//import java.io.OutputStream;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//public class CVDAO {
//
//    // Modern color palette
//    private static final BaseColor DARK_BLUE = new BaseColor(30, 58, 138);      // Primary dark blue
//    private static final BaseColor LIGHT_BLUE = new BaseColor(59, 130, 246);    // Accent blue
//    private static final BaseColor GRAY_900 = new BaseColor(17, 24, 39);        // Dark text
//    private static final BaseColor GRAY_600 = new BaseColor(75, 85, 99);        // Medium text
//    private static final BaseColor GRAY_100 = new BaseColor(243, 244, 246);     // Light background
//    private static final BaseColor WHITE = BaseColor.WHITE;
//
//    // Insert new CV
//    public boolean saveCV(CV cv) {
//        String sql = "INSERT INTO CV (seekerId, fullName, email, phone, linkedin, education, institute, " +
//                "jobTitle, company, experienceYears, skills, interests, projects, certifications) " +
//                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setString(1, cv.getSeekerId());
//            ps.setString(2, cv.getFullName());
//            ps.setString(3, cv.getEmail());
//            ps.setString(4, cv.getPhone());
//            ps.setString(5, cv.getLinkedin());
//            ps.setString(6, cv.getEducation());
//            ps.setString(7, cv.getInstitute());
//            ps.setString(8, cv.getJobTitle());
//            ps.setString(9, cv.getCompany());
//            ps.setString(10, cv.getExperienceYears());
//            ps.setString(11, cv.getSkills());
//            ps.setString(12, cv.getInterests());
//            ps.setString(13, cv.getProjects());
//            ps.setString(14, cv.getCertifications());
//
//            return ps.executeUpdate() > 0;
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    // Update existing CV
//    public boolean updateCV(CV cv) {
//        String sql = "UPDATE CV SET fullName=?, email=?, phone=?, linkedin=?, education=?, institute=?, " +
//                "jobTitle=?, company=?, experienceYears=?, skills=?, interests=?, projects=?, certifications=? " +
//                "WHERE seekerId=?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setString(1, cv.getFullName());
//            ps.setString(2, cv.getEmail());
//            ps.setString(3, cv.getPhone());
//            ps.setString(4, cv.getLinkedin());
//            ps.setString(5, cv.getEducation());
//            ps.setString(6, cv.getInstitute());
//            ps.setString(7, cv.getJobTitle());
//            ps.setString(8, cv.getCompany());
//            ps.setString(9, cv.getExperienceYears());
//            ps.setString(10, cv.getSkills());
//            ps.setString(11, cv.getInterests());
//            ps.setString(12, cv.getProjects());
//            ps.setString(13, cv.getCertifications());
//            ps.setString(14, cv.getSeekerId());
//
//            return ps.executeUpdate() > 0;
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//
//    // Get CV by seekerId
//    public CV getCVBySeekerId(String seekerId) {
//        String sql = "SELECT * FROM CV WHERE seekerId=?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setString(1, seekerId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                CV cv = new CV();
//                cv.setCvId(rs.getInt("cvId"));
//                cv.setSeekerId(rs.getString("seekerId"));
//                cv.setFullName(rs.getString("fullName"));
//                cv.setEmail(rs.getString("email"));
//                cv.setPhone(rs.getString("phone"));
//                cv.setLinkedin(rs.getString("linkedin"));
//                cv.setEducation(rs.getString("education"));
//                cv.setInstitute(rs.getString("institute"));
//                cv.setJobTitle(rs.getString("jobTitle"));
//                cv.setCompany(rs.getString("company"));
//                cv.setExperienceYears(rs.getString("experienceYears"));
//                cv.setSkills(rs.getString("skills"));
//                cv.setInterests(rs.getString("interests"));
//                cv.setProjects(rs.getString("projects"));
//                cv.setCertifications(rs.getString("certifications"));
//                return cv;
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    // Generate professional CV PDF
//    public void generateCV(JobSeekerProfile profile, CV cv, OutputStream outputStream) {
//        try {
//            Document document = new Document(PageSize.A4, 50, 50, 50, 50);
//            PdfWriter.getInstance(document, outputStream);
//            document.open();
//
//            float pageWidth = document.getPageSize().getWidth() - 100;
//
//            // Header
//            createHeader(document, cv, pageWidth);
//
//            // Main Layout
//            createTwoColumnLayout(document, cv, pageWidth);
//
//            document.close();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    // --- PDF helper methods ---
//    private void createHeader(Document document, CV cv, float pageWidth) throws DocumentException {
//        Font nameFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, DARK_BLUE);
//        Paragraph name = new Paragraph(cv.getFullName().toUpperCase(), nameFont);
//        name.setAlignment(Element.ALIGN_CENTER);
//        name.setSpacingAfter(5);
//        document.add(name);
//
//        if (cv.getJobTitle() != null && !cv.getJobTitle().trim().isEmpty()) {
//            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.ITALIC, GRAY_600);
//            Paragraph title = new Paragraph(cv.getJobTitle(), titleFont);
//            title.setAlignment(Element.ALIGN_CENTER);
//            title.setSpacingAfter(8);
//            document.add(title);
//        }
//
//        Font contactFont = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);
//
//        Paragraph email = new Paragraph("Email: " + cv.getEmail(), contactFont);
//        email.setAlignment(Element.ALIGN_CENTER);
//        email.setSpacingAfter(2);
//        document.add(email);
//
//        Paragraph phone = new Paragraph("Phone: " + cv.getPhone(), contactFont);
//        phone.setAlignment(Element.ALIGN_CENTER);
//        phone.setSpacingAfter(2);
//        document.add(phone);
//
//        String linkedinDisplay = cv.getLinkedin();
//        if (linkedinDisplay != null && linkedinDisplay.contains("linkedin.com/")) {
//            linkedinDisplay = linkedinDisplay.substring(linkedinDisplay.lastIndexOf('/') + 1);
//            if (linkedinDisplay.isEmpty()) {
//                linkedinDisplay = "LinkedIn Profile";
//            }
//        }
//        Paragraph linkedin = new Paragraph("LinkedIn: " + linkedinDisplay, contactFont);
//        linkedin.setAlignment(Element.ALIGN_CENTER);
//        linkedin.setSpacingAfter(12);
//        document.add(linkedin);
//
//        addSeparatorLine(document, pageWidth);
//    }
//
//    private void createTwoColumnLayout(Document document, CV cv, float pageWidth) throws DocumentException {
//        PdfPTable mainTable = new PdfPTable(2);
//        mainTable.setWidths(new float[]{1.2f, 0.8f});
//        mainTable.setWidthPercentage(100);
//        mainTable.setSpacingBefore(15);
//
//        // LEFT COLUMN
//        PdfPCell leftColumn = new PdfPCell();
//        leftColumn.setBorder(Rectangle.NO_BORDER);
//        leftColumn.setPaddingRight(20);
//
//        leftColumn.addElement(createSectionTitle("PROFESSIONAL EXPERIENCE"));
//        leftColumn.addElement(createExperienceBlock(cv));
//
//        leftColumn.addElement(createSectionTitle("EDUCATION"));
//        leftColumn.addElement(createEducationBlock(cv));
//
//        if (cv.getProjects() != null && !cv.getProjects().trim().isEmpty()) {
//            leftColumn.addElement(createSectionTitle("PROJECTS"));
//            leftColumn.addElement(createProjectsBlock(cv));
//        }
//
//        if (cv.getCertifications() != null && !cv.getCertifications().trim().isEmpty()) {
//            leftColumn.addElement(createSectionTitle("CERTIFICATIONS"));
//            leftColumn.addElement(createCertificationsBlock(cv));
//        }
//
//        // RIGHT COLUMN
//        PdfPCell rightColumn = new PdfPCell();
//        rightColumn.setBorder(Rectangle.NO_BORDER);
//        rightColumn.setBackgroundColor(GRAY_100);
//        rightColumn.setPadding(20);
//
//        rightColumn.addElement(createSectionTitle("CORE SKILLS"));
//        rightColumn.addElement(createSkillsBlock(cv));
//
//        rightColumn.addElement(createSectionTitle("INTERESTS"));
//        rightColumn.addElement(createInterestsBlock(cv));
//
//        mainTable.addCell(leftColumn);
//        mainTable.addCell(rightColumn);
//        document.add(mainTable);
//    }
//
//    private void addSeparatorLine(Document document, float pageWidth) throws DocumentException {
//        PdfPTable separatorTable = new PdfPTable(3);
//        separatorTable.setWidths(new float[]{1f, 2f, 1f});
//        separatorTable.setWidthPercentage(60);
//        separatorTable.setHorizontalAlignment(Element.ALIGN_CENTER);
//        separatorTable.setSpacingAfter(25);
//
//        PdfPCell leftCell = new PdfPCell();
//        leftCell.setBorder(Rectangle.NO_BORDER);
//        leftCell.setBorderWidthBottom(1f);
//        leftCell.setBorderColorBottom(LIGHT_BLUE);
//        leftCell.setFixedHeight(3);
//
//        PdfPCell centerCell = new PdfPCell();
//        centerCell.setBorder(Rectangle.NO_BORDER);
//        centerCell.setBorderWidthBottom(3f);
//        centerCell.setBorderColorBottom(DARK_BLUE);
//        centerCell.setFixedHeight(3);
//
//        PdfPCell rightCell = new PdfPCell();
//        rightCell.setBorder(Rectangle.NO_BORDER);
//        rightCell.setBorderWidthBottom(1f);
//        rightCell.setBorderColorBottom(LIGHT_BLUE);
//        rightCell.setFixedHeight(3);
//
//        separatorTable.addCell(leftCell);
//        separatorTable.addCell(centerCell);
//        separatorTable.addCell(rightCell);
//        document.add(separatorTable);
//    }
//
//    private Paragraph createSectionTitle(String title) {
//        Font sectionFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, DARK_BLUE);
//        Paragraph section = new Paragraph(title, sectionFont);
//        section.setSpacingBefore(15);
//        section.setSpacingAfter(8);
//
//        section.add(new Chunk("\n"));
//        Chunk underline = new Chunk("_________________");
//        underline.setFont(FontFactory.getFont(FontFactory.HELVETICA, 8, LIGHT_BLUE));
//        section.add(underline);
//        section.setSpacingAfter(10);
//
//        return section;
//    }
//
//    private PdfPTable createExperienceBlock(CV cv) {
//        PdfPTable table = new PdfPTable(1);
//        table.setWidthPercentage(100);
//
//        PdfPCell cell = new PdfPCell();
//        cell.setBorder(Rectangle.LEFT);
//        cell.setBorderWidthLeft(3f);
//        cell.setBorderColorLeft(LIGHT_BLUE);
//        cell.setPadding(8);
//
//        Font jobFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, GRAY_900);
//        Paragraph jobTitle = new Paragraph(cv.getJobTitle(), jobFont);
//        jobTitle.setSpacingAfter(2);
//        cell.addElement(jobTitle);
//
//        Font companyFont = FontFactory.getFont(FontFactory.HELVETICA, 9, LIGHT_BLUE);
//        Paragraph company = new Paragraph(cv.getCompany() + " • " + cv.getExperienceYears(), companyFont);
//        cell.addElement(company);
//
//        table.addCell(cell);
//        return table;
//    }
//
//    private PdfPTable createEducationBlock(CV cv) {
//        PdfPTable table = new PdfPTable(1);
//        table.setWidthPercentage(100);
//
//        PdfPCell cell = new PdfPCell();
//        cell.setBorder(Rectangle.LEFT);
//        cell.setBorderWidthLeft(3f);
//        cell.setBorderColorLeft(LIGHT_BLUE);
//        cell.setPadding(8);
//
//        Font degreeFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, GRAY_900);
//        Paragraph degree = new Paragraph(cv.getEducation(), degreeFont);
//        degree.setSpacingAfter(2);
//        cell.addElement(degree);
//
//        Font instituteFont = FontFactory.getFont(FontFactory.HELVETICA, 9, GRAY_600);
//        Paragraph institute = new Paragraph(cv.getInstitute(), instituteFont);
//        cell.addElement(institute);
//
//        table.addCell(cell);
//        return table;
//    }
//
//    private PdfPTable createProjectsBlock(CV cv) {
//        PdfPTable table = new PdfPTable(1);
//        table.setWidthPercentage(100);
//
//        String[] projects = cv.getProjects().split(",");
//        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);
//
//        for (String project : projects) {
//            PdfPCell cell = new PdfPCell();
//            cell.setBorder(Rectangle.NO_BORDER);
//            cell.setPaddingBottom(5);
//
//            Paragraph para = new Paragraph("• " + project.trim(), font);
//            cell.addElement(para);
//            table.addCell(cell);
//        }
//
//        return table;
//    }
//
//    private PdfPTable createCertificationsBlock(CV cv) {
//        PdfPTable table = new PdfPTable(1);
//        table.setWidthPercentage(100);
//
//        String[] certs = cv.getCertifications().split(",");
//        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);
//
//        for (String cert : certs) {
//            PdfPCell cell = new PdfPCell();
//            cell.setBorder(Rectangle.NO_BORDER);
//            cell.setPaddingBottom(5);
//
//            Paragraph para = new Paragraph("• " + cert.trim(), font);
//            cell.addElement(para);
//            table.addCell(cell);
//        }
//
//        return table;
//    }
//
//    private PdfPTable createSkillsBlock(CV cv) {
//        PdfPTable table = new PdfPTable(1);
//        table.setWidthPercentage(100);
//
//        String[] skills = cv.getSkills().split(",");
//
//        for (String skill : skills) {
//            PdfPCell skillCell = new PdfPCell();
//            skillCell.setBorder(Rectangle.NO_BORDER);
//            skillCell.setBorderWidthBottom(1f);
//            skillCell.setBorderColorBottom(new BaseColor(220, 220, 220));
//            skillCell.setPadding(6);
//            skillCell.setPaddingLeft(0);
//
//            PdfPTable skillTable = new PdfPTable(2);
//            try {
//                skillTable.setWidths(new float[]{3f, 1f});
//            } catch (DocumentException e) {
//                e.printStackTrace();
//            }
//            skillTable.setWidthPercentage(100);
//
//            PdfPCell nameCell = new PdfPCell();
//            nameCell.setBorder(Rectangle.NO_BORDER);
//
//            Font skillFont = FontFactory.getFont(FontFactory.HELVETICA, 9, GRAY_900);
//            Paragraph skillName = new Paragraph(skill.trim(), skillFont);
//            nameCell.addElement(skillName);
//
//            PdfPCell levelCell = new PdfPCell();
//            levelCell.setBorder(Rectangle.NO_BORDER);
//            Font barFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 6, LIGHT_BLUE);
//            Paragraph bars = new Paragraph("████", barFont);
//            bars.setAlignment(Element.ALIGN_RIGHT);
//            levelCell.addElement(bars);
//
//            skillTable.addCell(nameCell);
//            skillTable.addCell(levelCell);
//
//            skillCell.addElement(skillTable);
//            table.addCell(skillCell);
//        }
//
//        return table;
//    }
//
//    private PdfPTable createInterestsBlock(CV cv) {
//        PdfPTable table = new PdfPTable(1);
//        table.setWidthPercentage(100);
//
//        String[] interests = cv.getInterests().split(",");
//        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);
//
//        for (String interest : interests) {
//            PdfPCell cell = new PdfPCell();
//            cell.setBorder(Rectangle.NO_BORDER);
//            cell.setPaddingBottom(5);
//
//            Paragraph para = new Paragraph("• " + interest.trim(), font);
//            cell.addElement(para);
//            table.addCell(cell);
//        }
//
//        return table;
//    }
//}


package dao;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import model.CV;
import model.JobSeekerProfile;
import util.DBConnection;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CVDAO {

    // Modern color palette
    private static final BaseColor DARK_BLUE = new BaseColor(30, 58, 138);      // Primary dark blue
    private static final BaseColor LIGHT_BLUE = new BaseColor(59, 130, 246);    // Accent blue
    private static final BaseColor GRAY_900 = new BaseColor(17, 24, 39);        // Dark text
    private static final BaseColor GRAY_600 = new BaseColor(75, 85, 99);        // Medium text
    private static final BaseColor GRAY_100 = new BaseColor(243, 244, 246);     // Light background
    private static final BaseColor WHITE = BaseColor.WHITE;

    // Generate next unique CV ID (CV001, CV002, ...)
    public String generateCVId() {
        String sql = "SELECT TOP 1 cvId FROM CV ORDER BY cvId DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("cvId"); // e.g., CV012
                int num = Integer.parseInt(lastId.substring(2)) + 1;
                return "CV" + String.format("%03d", num); // CV013
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "CV001"; // first ID if table is empty
    }

    // Insert new CV
    public boolean saveCV(CV cv) {
        String cvId = generateCVId(); // Generate unique CV ID

        String sql = "INSERT INTO CV (cvId, seekerId, fullName, email, phone, linkedin, education, institute, " +
                "jobTitle, company, experienceYears, skills, interests, projects, certifications) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cvId);
            ps.setString(2, cv.getSeekerId());
            ps.setString(3, cv.getFullName());
            ps.setString(4, cv.getEmail());
            ps.setString(5, cv.getPhone());
            ps.setString(6, cv.getLinkedin());
            ps.setString(7, cv.getEducation());
            ps.setString(8, cv.getInstitute());
            ps.setString(9, cv.getJobTitle());
            ps.setString(10, cv.getCompany());
            ps.setString(11, cv.getExperienceYears());
            ps.setString(12, cv.getSkills());
            ps.setString(13, cv.getInterests());
            ps.setString(14, cv.getProjects());
            ps.setString(15, cv.getCertifications());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update existing CV
    public boolean updateCV(CV cv) {
        String sql = "UPDATE CV SET fullName=?, email=?, phone=?, linkedin=?, education=?, institute=?, " +
                "jobTitle=?, company=?, experienceYears=?, skills=?, interests=?, projects=?, certifications=?, updatedAt=GETDATE() " +
                "WHERE seekerId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cv.getFullName());
            ps.setString(2, cv.getEmail());
            ps.setString(3, cv.getPhone());
            ps.setString(4, cv.getLinkedin());
            ps.setString(5, cv.getEducation());
            ps.setString(6, cv.getInstitute());
            ps.setString(7, cv.getJobTitle());
            ps.setString(8, cv.getCompany());
            ps.setString(9, cv.getExperienceYears());
            ps.setString(10, cv.getSkills());
            ps.setString(11, cv.getInterests());
            ps.setString(12, cv.getProjects());
            ps.setString(13, cv.getCertifications());
            ps.setString(14, cv.getSeekerId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get CV by seekerId
    public CV getCVBySeekerId(String seekerId) {
        String sql = "SELECT * FROM CV WHERE seekerId=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, seekerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CV cv = new CV();
                cv.setCvId(rs.getString("cvId"));  // Changed to getString
                cv.setSeekerId(rs.getString("seekerId"));
                cv.setFullName(rs.getString("fullName"));
                cv.setEmail(rs.getString("email"));
                cv.setPhone(rs.getString("phone"));
                cv.setLinkedin(rs.getString("linkedin"));
                cv.setEducation(rs.getString("education"));
                cv.setInstitute(rs.getString("institute"));
                cv.setJobTitle(rs.getString("jobTitle"));
                cv.setCompany(rs.getString("company"));
                cv.setExperienceYears(rs.getString("experienceYears"));
                cv.setSkills(rs.getString("skills"));
                cv.setInterests(rs.getString("interests"));
                cv.setProjects(rs.getString("projects"));
                cv.setCertifications(rs.getString("certifications"));
                return cv;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Generate professional CV PDF
    public void generateCV(JobSeekerProfile profile, CV cv, OutputStream outputStream) {
        try {
            Document document = new Document(PageSize.A4, 50, 50, 50, 50);
            PdfWriter.getInstance(document, outputStream);
            document.open();

            float pageWidth = document.getPageSize().getWidth() - 100;

            // Header
            createHeader(document, cv, pageWidth);

            // Main Layout
            createTwoColumnLayout(document, cv, pageWidth);

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --- PDF helper methods ---
    private void createHeader(Document document, CV cv, float pageWidth) throws DocumentException {
        Font nameFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, DARK_BLUE);
        Paragraph name = new Paragraph(cv.getFullName().toUpperCase(), nameFont);
        name.setAlignment(Element.ALIGN_CENTER);
        name.setSpacingAfter(5);
        document.add(name);

        if (cv.getJobTitle() != null && !cv.getJobTitle().trim().isEmpty()) {
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.ITALIC, GRAY_600);
            Paragraph title = new Paragraph(cv.getJobTitle(), titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(8);
            document.add(title);
        }

        Font contactFont = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);

        Paragraph email = new Paragraph("Email: " + cv.getEmail(), contactFont);
        email.setAlignment(Element.ALIGN_CENTER);
        email.setSpacingAfter(2);
        document.add(email);

        Paragraph phone = new Paragraph("Phone: " + cv.getPhone(), contactFont);
        phone.setAlignment(Element.ALIGN_CENTER);
        phone.setSpacingAfter(2);
        document.add(phone);

        if (cv.getLinkedin() != null && !cv.getLinkedin().trim().isEmpty()) {
            String linkedinDisplay = cv.getLinkedin();
            if (linkedinDisplay.contains("linkedin.com/")) {
                linkedinDisplay = linkedinDisplay.substring(linkedinDisplay.lastIndexOf('/') + 1);
                if (linkedinDisplay.isEmpty()) {
                    linkedinDisplay = "LinkedIn Profile";
                }
            }
            Paragraph linkedin = new Paragraph("LinkedIn: " + linkedinDisplay, contactFont);
            linkedin.setAlignment(Element.ALIGN_CENTER);
            linkedin.setSpacingAfter(12);
            document.add(linkedin);
        }

        addSeparatorLine(document, pageWidth);
    }

    private void createTwoColumnLayout(Document document, CV cv, float pageWidth) throws DocumentException {
        PdfPTable mainTable = new PdfPTable(2);
        mainTable.setWidths(new float[]{1.2f, 0.8f});
        mainTable.setWidthPercentage(100);
        mainTable.setSpacingBefore(15);

        // LEFT COLUMN
        PdfPCell leftColumn = new PdfPCell();
        leftColumn.setBorder(Rectangle.NO_BORDER);
        leftColumn.setPaddingRight(20);

        leftColumn.addElement(createSectionTitle("PROFESSIONAL EXPERIENCE"));
        leftColumn.addElement(createExperienceBlock(cv));

        leftColumn.addElement(createSectionTitle("EDUCATION"));
        leftColumn.addElement(createEducationBlock(cv));

        if (cv.getProjects() != null && !cv.getProjects().trim().isEmpty()) {
            leftColumn.addElement(createSectionTitle("PROJECTS"));
            leftColumn.addElement(createProjectsBlock(cv));
        }

        if (cv.getCertifications() != null && !cv.getCertifications().trim().isEmpty()) {
            leftColumn.addElement(createSectionTitle("CERTIFICATIONS"));
            leftColumn.addElement(createCertificationsBlock(cv));
        }

        // RIGHT COLUMN
        PdfPCell rightColumn = new PdfPCell();
        rightColumn.setBorder(Rectangle.NO_BORDER);
        rightColumn.setBackgroundColor(GRAY_100);
        rightColumn.setPadding(20);

        rightColumn.addElement(createSectionTitle("CORE SKILLS"));
        rightColumn.addElement(createSkillsBlock(cv));

        if (cv.getInterests() != null && !cv.getInterests().trim().isEmpty()) {
            rightColumn.addElement(createSectionTitle("INTERESTS"));
            rightColumn.addElement(createInterestsBlock(cv));
        }

        mainTable.addCell(leftColumn);
        mainTable.addCell(rightColumn);
        document.add(mainTable);
    }

    private void addSeparatorLine(Document document, float pageWidth) throws DocumentException {
        PdfPTable separatorTable = new PdfPTable(3);
        separatorTable.setWidths(new float[]{1f, 2f, 1f});
        separatorTable.setWidthPercentage(60);
        separatorTable.setHorizontalAlignment(Element.ALIGN_CENTER);
        separatorTable.setSpacingAfter(25);

        PdfPCell leftCell = new PdfPCell();
        leftCell.setBorder(Rectangle.NO_BORDER);
        leftCell.setBorderWidthBottom(1f);
        leftCell.setBorderColorBottom(LIGHT_BLUE);
        leftCell.setFixedHeight(3);

        PdfPCell centerCell = new PdfPCell();
        centerCell.setBorder(Rectangle.NO_BORDER);
        centerCell.setBorderWidthBottom(3f);
        centerCell.setBorderColorBottom(DARK_BLUE);
        centerCell.setFixedHeight(3);

        PdfPCell rightCell = new PdfPCell();
        rightCell.setBorder(Rectangle.NO_BORDER);
        rightCell.setBorderWidthBottom(1f);
        rightCell.setBorderColorBottom(LIGHT_BLUE);
        rightCell.setFixedHeight(3);

        separatorTable.addCell(leftCell);
        separatorTable.addCell(centerCell);
        separatorTable.addCell(rightCell);
        document.add(separatorTable);
    }

    private Paragraph createSectionTitle(String title) {
        Font sectionFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, DARK_BLUE);
        Paragraph section = new Paragraph(title, sectionFont);
        section.setSpacingBefore(15);
        section.setSpacingAfter(8);

        section.add(new Chunk("\n"));
        Chunk underline = new Chunk("_________________");
        underline.setFont(FontFactory.getFont(FontFactory.HELVETICA, 8, LIGHT_BLUE));
        section.add(underline);
        section.setSpacingAfter(10);

        return section;
    }

    private PdfPTable createExperienceBlock(CV cv) {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.LEFT);
        cell.setBorderWidthLeft(3f);
        cell.setBorderColorLeft(LIGHT_BLUE);
        cell.setPadding(8);

        Font jobFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, GRAY_900);
        Paragraph jobTitle = new Paragraph(cv.getJobTitle() != null ? cv.getJobTitle() : "Not Specified", jobFont);
        jobTitle.setSpacingAfter(2);
        cell.addElement(jobTitle);

        Font companyFont = FontFactory.getFont(FontFactory.HELVETICA, 9, LIGHT_BLUE);
        String companyText = (cv.getCompany() != null ? cv.getCompany() : "Not Specified") +
                " • " + (cv.getExperienceYears() != null ? cv.getExperienceYears() : "0 years");
        Paragraph company = new Paragraph(companyText, companyFont);
        cell.addElement(company);

        table.addCell(cell);
        return table;
    }

    private PdfPTable createEducationBlock(CV cv) {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.LEFT);
        cell.setBorderWidthLeft(3f);
        cell.setBorderColorLeft(LIGHT_BLUE);
        cell.setPadding(8);

        Font degreeFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, GRAY_900);
        Paragraph degree = new Paragraph(cv.getEducation() != null ? cv.getEducation() : "Not Specified", degreeFont);
        degree.setSpacingAfter(2);
        cell.addElement(degree);

        Font instituteFont = FontFactory.getFont(FontFactory.HELVETICA, 9, GRAY_600);
        Paragraph institute = new Paragraph(cv.getInstitute() != null ? cv.getInstitute() : "Not Specified", instituteFont);
        cell.addElement(institute);

        table.addCell(cell);
        return table;
    }

    private PdfPTable createProjectsBlock(CV cv) {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        String[] projects = cv.getProjects().split(",");
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);

        for (String project : projects) {
            if (project.trim().isEmpty()) continue;

            PdfPCell cell = new PdfPCell();
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setPaddingBottom(5);

            Paragraph para = new Paragraph("• " + project.trim(), font);
            cell.addElement(para);
            table.addCell(cell);
        }

        return table;
    }

    private PdfPTable createCertificationsBlock(CV cv) {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        String[] certs = cv.getCertifications().split(",");
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);

        for (String cert : certs) {
            if (cert.trim().isEmpty()) continue;

            PdfPCell cell = new PdfPCell();
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setPaddingBottom(5);

            Paragraph para = new Paragraph("• " + cert.trim(), font);
            cell.addElement(para);
            table.addCell(cell);
        }

        return table;
    }

    private PdfPTable createSkillsBlock(CV cv) {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        String[] skills = cv.getSkills().split(",");

        for (String skill : skills) {
            if (skill.trim().isEmpty()) continue;

            PdfPCell skillCell = new PdfPCell();
            skillCell.setBorder(Rectangle.NO_BORDER);
            skillCell.setBorderWidthBottom(1f);
            skillCell.setBorderColorBottom(new BaseColor(220, 220, 220));
            skillCell.setPadding(6);
            skillCell.setPaddingLeft(0);

            PdfPTable skillTable = new PdfPTable(2);
            try {
                skillTable.setWidths(new float[]{3f, 1f});
            } catch (DocumentException e) {
                e.printStackTrace();
            }
            skillTable.setWidthPercentage(100);

            PdfPCell nameCell = new PdfPCell();
            nameCell.setBorder(Rectangle.NO_BORDER);

            Font skillFont = FontFactory.getFont(FontFactory.HELVETICA, 9, GRAY_900);
            Paragraph skillName = new Paragraph(skill.trim(), skillFont);
            nameCell.addElement(skillName);

            PdfPCell levelCell = new PdfPCell();
            levelCell.setBorder(Rectangle.NO_BORDER);
            Font barFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 6, LIGHT_BLUE);
            Paragraph bars = new Paragraph("████", barFont);
            bars.setAlignment(Element.ALIGN_RIGHT);
            levelCell.addElement(bars);

            skillTable.addCell(nameCell);
            skillTable.addCell(levelCell);

            skillCell.addElement(skillTable);
            table.addCell(skillCell);
        }

        return table;
    }

    private PdfPTable createInterestsBlock(CV cv) {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        String[] interests = cv.getInterests().split(",");
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10, GRAY_900);

        for (String interest : interests) {
            if (interest.trim().isEmpty()) continue;

            PdfPCell cell = new PdfPCell();
            cell.setBorder(Rectangle.NO_BORDER);
            cell.setPaddingBottom(5);

            Paragraph para = new Paragraph("• " + interest.trim(), font);
            cell.addElement(para);
            table.addCell(cell);
        }

        return table;
    }
}