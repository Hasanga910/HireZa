//Concrete Observer
//When a new job application is submitted, it automatically creates a notification for the recruiter
package observer;
import dao.JobNotificationDAO;
import dao.JobPostDAO;
import model.JobApplication;
import model.JobPost;

public class InAppApplicationObserver implements ApplicationObserver{
    // Database helpers to save notifications
    private final JobNotificationDAO notificationDAO = new JobNotificationDAO();
    private final JobPostDAO jobPostDAO = new JobPostDAO();

    @Override
    public void update(JobApplication application) {
        //  Safety check - is the application valid?

        if (application == null) {
            System.err.println("️ Application is null, cannot create notification.");
            return;
        }

        System.out.println(" Observer triggered for: " + application.getFullName());
        //  Find which job was applied for
        // Get job details to find company ID
        JobPost job = jobPostDAO.getJobPostById(application.getJobId());

        if (job == null) {
            System.err.println(" Could not find job with ID: " + application.getJobId());
            return;
        }
        // Get company that posted the job
        String companyId = job.getCompanyId();
        if (companyId == null || companyId.trim().isEmpty()) {
            System.err.println(" Job has no company ID");
            return;
        }
        // Create notification message
        String message = " New application from " + application.getFullName()
                + " for job: " + job.getJobTitle();
        //  Save notification to database
        // Pass all 4 required parameters: companyId, applicationId, jobId, message
        boolean inserted = notificationDAO.addNotification(
                companyId,
                application.getApplicationId(),
                application.getJobId(),
                message
        );
        // Check if it worked
        if (inserted) {
            System.out.println(" Notification created for company: " + companyId);
        } else {
            System.err.println(" Failed to create notification");
        }
    }
}