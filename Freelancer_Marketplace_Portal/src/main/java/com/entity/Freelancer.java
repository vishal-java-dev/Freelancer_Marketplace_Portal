package com.entity;

public class Freelancer {
    private int id;
    private String fullname;
    private String email;
    private String skills;
    private int experience;
    private String password;
    private String regDate;

    // Default Constructor
    public Freelancer() {}

    // Parameterized Constructor
    public Freelancer(int id, String fullname, String email, String skills, int experience, String password, String regDate) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.skills = skills;
        this.experience = experience;
        this.password = password;
        this.regDate = regDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
}
