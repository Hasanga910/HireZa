<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Recruiter, dao.RecruiterDAO, model.User, dao.UserDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String userId = request.getParameter("userId");
    RecruiterDAO recruiterDAO = new RecruiterDAO();
    UserDAO userDAO = new UserDAO();
    Recruiter recruiter = null;
    User recUser = null;
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");

    if (userId != null && !userId.isEmpty()) {
        recruiter = recruiterDAO.getRecruiterByUserId(userId);
        recUser = userDAO.getUserById(userId);
    }
%>

<div id="recruiter-details-modal" class="recruiter-details-modal">
    <div class="recruiter-details-modal-content">
        <span class="close" onclick="closeRecruiterDetailsModal()">&times;</span>
        <h2>Recruiter Details</h2>
        <% if (recruiter == null || recUser == null) { %>
        <p class="no-data">Recruiter not found.</p>
        <% } else { %>
        <div class="recruiter-details-content">
            <div class="profile-image">
                <% if (recruiter.getProfileImage() != null && !recruiter.getProfileImage().isEmpty()) { %>
                <img src="${pageContext.request.contextPath}/Recruiter/images/<%= recruiter.getProfileImage() %>"
                     alt="Profile Image" title="<%= recUser.getFullName() != null ? recUser.getFullName() : recUser.getUsername() %>">
                <% } else { %>
                <div class="profile-image-placeholder">
                    <i class="fas fa-user"></i>
                </div>
                <% } %>
            </div>
            <div class="details">
                <p><strong>Full Name:</strong> <%= recUser.getFullName() != null ? recUser.getFullName() : "Not set" %></p>
                <p><strong>Email:</strong> <%= recUser.getEmail() %></p>
                <p><strong>Recruiter ID:</strong> <%= recruiter.getRecruiterId() %></p>
                <p><strong>Company ID:</strong> <%= recruiter.getCompanyId() %></p>
                <p><strong>Created At:</strong> <%= recruiter.getCreatedAt() != null ? dateFormat.format(recruiter.getCreatedAt()) : "Not available" %></p>
                <p><strong>Position:</strong> <%= recruiter.getPosition() != null ? recruiter.getPosition() : "Not set" %></p>
                <p><strong>Bio:</strong> <%= recruiter.getBio() != null ? recruiter.getBio() : "Not set" %></p>
            </div>
        </div>
        <% } %>
        <div class="modal-actions">
            <button class="cancel-btn" onclick="closeRecruiterDetailsModal()">Close</button>
        </div>
    </div>
</div>

<style>
    .recruiter-details-modal {
        display: none;
        position: fixed;
        z-index: 1100;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        overflow: auto;
    }

    .recruiter-details-modal-content {
        background-color: white;
        margin: 5% auto;
        padding: 20px;
        border-radius: 8px;
        width: 90%;
        max-width: 500px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        position: relative;
        text-align: left;
    }

    .recruiter-details-modal-content .close {
        position: absolute;
        top: 15px;
        right: 20px;
        font-size: 1.5rem;
        cursor: pointer;
        color: #aaa;
    }

    .recruiter-details-modal-content .close:hover {
        color: #000;
    }

    .recruiter-details-modal-content h2 {
        font-size: 1.4rem;
        margin: 0 0 1rem;
        color: #007bff;
        text-align: center;
    }

    .recruiter-details-content {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1rem;
    }

    .recruiter-details-content .profile-image {
        text-align: center;
    }

    .recruiter-details-content .profile-image img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #007bff;
    }

    .recruiter-details-content .profile-image .profile-image-placeholder {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: #e0e0e0;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 2px solid #007bff;
    }

    .recruiter-details-content .profile-image .profile-image-placeholder i {
        color: #666;
        font-size: 2.5rem;
    }

    .recruiter-details-content .details {
        width: 100%;
    }

    .recruiter-details-content .details p {
        margin: 0.5rem 0;
        font-size: 0.95rem;
        color: #333;
    }

    .recruiter-details-content .details p strong {
        color: #555;
    }

    .modal-actions {
        text-align: center;
        margin-top: 1.5rem;
    }

    .modal-actions .cancel-btn {
        background-color: #6c757d;
        color: white;
        padding: 0.5rem 1.5rem;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 0.9rem;
        transition: background-color 0.3s;
    }

    .modal-actions .cancel-btn:hover {
        background-color: #545b62;
    }

    .no-data {
        text-align: center;
        color: #999;
        font-style: italic;
        font-size: 1rem;
        margin: 1rem 0;
    }

    @media (max-width: 480px) {
        .recruiter-details-modal-content {
            width: 95%;
            padding: 15px;
        }

        .recruiter-details-modal-content h2 {
            font-size: 1.2rem;
        }

        .recruiter-details-content .profile-image img,
        .recruiter-details-content .profile-image .profile-image-placeholder {
            width: 80px;
            height: 80px;
        }

        .recruiter-details-content .profile-image .profile-image-placeholder i {
            font-size: 2rem;
        }

        .recruiter-details-content .details p {
            font-size: 0.9rem;
        }
    }
</style>