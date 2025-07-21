package com.entity;

import java.sql.Timestamp;

public class PaymentLog {

    private int id;
    private int projectId;
    private int clientId;
    private int freelancerId;
    private double amount;
    private String markedBy;          // "client" or "admin"
    private Timestamp markedOn;
    private String paymentMode;
    private String transactionId;
    private String notes;

    // Constructors
    public PaymentLog() {}

    public PaymentLog(int projectId, int clientId, int freelancerId, double amount, String markedBy,
                      String paymentMode, String transactionId, String notes) {
        this.projectId = projectId;
        this.clientId = clientId;
        this.freelancerId = freelancerId;
        this.amount = amount;
        this.markedBy = markedBy;
        this.paymentMode = paymentMode;
        this.transactionId = transactionId;
        this.notes = notes;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getProjectId() {
        return projectId;
    }
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getClientId() {
        return clientId;
    }
    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public int getFreelancerId() {
        return freelancerId;
    }
    public void setFreelancerId(int freelancerId) {
        this.freelancerId = freelancerId;
    }

    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getMarkedBy() {
        return markedBy;
    }
    public void setMarkedBy(String markedBy) {
        this.markedBy = markedBy;
    }

    public Timestamp getMarkedOn() {
        return markedOn;
    }
    public void setMarkedOn(Timestamp markedOn) {
        this.markedOn = markedOn;
    }

    public String getPaymentMode() {
        return paymentMode;
    }
    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getTransactionId() {
        return transactionId;
    }
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getNotes() {
        return notes;
    }
    public void setNotes(String notes) {
        this.notes = notes;
    }
}
