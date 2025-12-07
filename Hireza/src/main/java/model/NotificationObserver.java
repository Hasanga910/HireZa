package model;

public interface NotificationObserver {
    void update(JobPost jobPost, String action);
}