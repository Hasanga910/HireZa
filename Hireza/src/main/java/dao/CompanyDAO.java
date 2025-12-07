package dao;

import model.Company;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CompanyDAO {

    // ✅ Generate next company ID like C001, C002, ...
    private String generateNextCompanyId(Connection conn) throws SQLException {
        String sql = "SELECT TOP 1 companyId FROM Company ORDER BY companyId DESC";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("companyId"); // e.g., "C005"
                int number = Integer.parseInt(lastId.substring(1)); // remove "C"
                return String.format("C%03d", number + 1);
            } else {
                return "C001"; // first company
            }
        }
    }

    // ✅ Check if company profile is completed
    public boolean isCompanyProfileCompleted(String userId) {
        String sql = "SELECT profileCompleted FROM Company WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("profileCompleted");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Save new company profile with generated custom companyId
    public boolean saveCompanyProfile(Company company) {
        String sql = "INSERT INTO Company (companyId, userId, companyName, industry, description, website, address, city, state, zipCode, contactNumber, companySize, foundedYear, workMode, employmentTypes, companyEmail, aboutUs, profileCompleted, createdAt, updatedAt, logo) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, GETDATE(), GETDATE(), ?)";
        try (Connection conn = DBConnection.getConnection()) {

            // Generate unique company ID
            String newCompanyId = generateNextCompanyId(conn);
            company.setCompanyId(newCompanyId);

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, company.getCompanyId());
                stmt.setString(2, company.getUserId());
                stmt.setString(3, company.getCompanyName());
                stmt.setString(4, company.getIndustry());
                stmt.setString(5, company.getDescription());
                stmt.setString(6, company.getWebsite());
                stmt.setString(7, company.getAddress());
                stmt.setString(8, company.getCity());
                stmt.setString(9, company.getState());
                stmt.setString(10, company.getZipCode());
                stmt.setString(11, company.getContactNumber());
                stmt.setString(12, company.getCompanySize());
                stmt.setInt(13, company.getFoundedYear());
                stmt.setString(14, company.getWorkMode());
                stmt.setString(15, company.getEmploymentTypes());
                stmt.setString(16, company.getCompanyEmail());
                stmt.setString(17, company.getAboutUs());
                if (company.getLogo() != null) {
                    stmt.setBytes(18, company.getLogo());
                } else {
                    stmt.setNull(18, java.sql.Types.BINARY);
                }

                return stmt.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Update existing company profile
    public boolean updateCompanyProfile(Company company) {
        String sql = "UPDATE Company SET companyName = ?, industry = ?, description = ?, website = ?, address = ?, city = ?, state = ?, zipCode = ?, contactNumber = ?, companySize = ?, foundedYear = ?, workMode = ?, employmentTypes = ?, companyEmail = ?, aboutUs = ?, updatedAt = GETDATE(), logo = ? WHERE userId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, company.getCompanyName());
            stmt.setString(2, company.getIndustry());
            stmt.setString(3, company.getDescription());
            stmt.setString(4, company.getWebsite());
            stmt.setString(5, company.getAddress());
            stmt.setString(6, company.getCity());
            stmt.setString(7, company.getState());
            stmt.setString(8, company.getZipCode());
            stmt.setString(9, company.getContactNumber());
            stmt.setString(10, company.getCompanySize());
            stmt.setInt(11, company.getFoundedYear());
            stmt.setString(12, company.getWorkMode());
            stmt.setString(13, company.getEmploymentTypes());
            stmt.setString(14, company.getCompanyEmail());
            stmt.setString(15, company.getAboutUs());
            if (company.getLogo() != null) {
                stmt.setBytes(16, company.getLogo());
            } else {
                stmt.setNull(16, java.sql.Types.BINARY);
            }
            stmt.setString(17, company.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Delete company profile
    public boolean deleteCompanyProfile(String userId) {
        String sql = "DELETE FROM Company WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Get company by userId
    public Company getCompanyByUserId(String userId) {
        String sql = "SELECT * FROM Company WHERE userId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Company company = new Company();
                company.setCompanyId(rs.getString("companyId"));
                company.setUserId(rs.getString("userId"));
                company.setCompanyName(rs.getString("companyName"));
                company.setIndustry(rs.getString("industry"));
                company.setDescription(rs.getString("description"));
                company.setWebsite(rs.getString("website"));
                company.setAddress(rs.getString("address"));
                company.setCity(rs.getString("city"));
                company.setState(rs.getString("state"));
                company.setZipCode(rs.getString("zipCode"));
                company.setContactNumber(rs.getString("contactNumber"));
                company.setCompanySize(rs.getString("companySize"));
                company.setFoundedYear(rs.getInt("foundedYear"));
                company.setWorkMode(rs.getString("workMode"));
                company.setEmploymentTypes(rs.getString("employmentTypes"));
                company.setCompanyEmail(rs.getString("companyEmail"));
                company.setAboutUs(rs.getString("aboutUs"));
                company.setProfileCompleted(rs.getBoolean("profileCompleted"));
                company.setLogo(rs.getBytes("logo"));
                return company;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get company by companyId
    public Company getCompanyByCompanyId(String companyId) {
        String sql = "SELECT * FROM Company WHERE companyId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Company company = new Company();
                company.setCompanyId(rs.getString("companyId"));
                company.setUserId(rs.getString("userId"));
                company.setCompanyName(rs.getString("companyName"));
                company.setIndustry(rs.getString("industry"));
                company.setDescription(rs.getString("description"));
                company.setWebsite(rs.getString("website"));
                company.setAddress(rs.getString("address"));
                company.setCity(rs.getString("city"));
                company.setState(rs.getString("state"));
                company.setZipCode(rs.getString("zipCode"));
                company.setContactNumber(rs.getString("contactNumber"));
                company.setCompanySize(rs.getString("companySize"));
                company.setFoundedYear(rs.getInt("foundedYear"));
                company.setWorkMode(rs.getString("workMode"));
                company.setEmploymentTypes(rs.getString("employmentTypes"));
                company.setCompanyEmail(rs.getString("companyEmail"));
                company.setAboutUs(rs.getString("aboutUs"));
                company.setProfileCompleted(rs.getBoolean("profileCompleted"));
                company.setLogo(rs.getBytes("logo"));
                return company;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get industry by company ID
    public String getIndustryByCompanyId(String companyId) {
        String sql = "SELECT industry FROM Company WHERE companyId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, companyId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("industry");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Count all employers (from Users)
    public static int getEmployersCount() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role = 'Employer'";
        int count = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // ✅ Count total companies
    public int getCompaniesCount() {
        String sql = "SELECT COUNT(*) FROM Company";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
