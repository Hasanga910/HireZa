//Subject
//Keeps a list of all observers and notifies them when a new job application is submitted
package observer;
import model.JobApplication;
import java.util.ArrayList;
import java.util.List;

public class JobApplicationNotifier {
    private final List<ApplicationObserver> observers = new ArrayList<>();

    public void attach(ApplicationObserver observer) {
        observers.add(observer);
    }

    public void detach(ApplicationObserver observer) {
        observers.remove(observer);
    }

    public void applicationSubmitted(JobApplication application) {
        //Notify all observers when an event happens
        for (ApplicationObserver observer : observers) {
            observer.update(application);
        }
    }
}



