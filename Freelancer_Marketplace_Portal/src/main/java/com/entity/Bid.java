package com.entity;

public class Bid {
    private int id;
    private int projectId;
    private String projectTitle;
    private int clientId;
    private int freelancerId;
    private String freelancerName;    // Added for display
    private String freelancerEmail;   // Added for display
    private double bidAmount;
    private String message;
    private String bidDate;
    private String bid_message;
    private int timeline; // ✅ in days
    private String coverLetter; // ✅ message or proposal
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
	public String getProjectTitle() {
		return projectTitle;
	}
	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}
	public int getFreelancerId() {
		return freelancerId;
	}
	public void setFreelancerId(int freelancerId) {
		this.freelancerId = freelancerId;
	}
	public String getFreelancerName() {
		return freelancerName;
	}
	public void setFreelancerName(String freelancerName) {
		this.freelancerName = freelancerName;
	}
	public String getFreelancerEmail() {
		return freelancerEmail;
	}
	public void setFreelancerEmail(String freelancerEmail) {
		this.freelancerEmail = freelancerEmail;
	}
	public double getBidAmount() {
		return bidAmount;
	}
	public void setBidAmount(double bidAmount) {
		this.bidAmount = bidAmount;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getBidDate() {
		return bidDate;
	}
	public void setBidDate(String bidDate) {
		this.bidDate = bidDate;
	}
	public String getBid_message() {
		return bid_message;
	}
	public void setBid_message(String bid_message) {
		this.bid_message = bid_message;
	}
	public int getTimeline() {
		return timeline;
	}
	public void setTimeline(int timeline) {
		this.timeline = timeline;
	}
	public String getCoverLetter() {
		return coverLetter;
	}
	public void setCoverLetter(String coverLetter) {
		this.coverLetter = coverLetter;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	
}
