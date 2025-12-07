package model;

import java.util.ArrayList;
import java.util.List;

public class NotificationSubject {
    private List<NotificationObserver> observers = new ArrayList<>();

    public void addObserver(NotificationObserver observer) {
        observers.add(observer);
    }

    public void removeObserver(NotificationObserver observer) {
        observers.remove(observer);
    }

    public void notifyObservers(JobPost jobPost, String action) {
        for (NotificationObserver observer : observers) {
            observer.update(jobPost, action);
        }
    }
}