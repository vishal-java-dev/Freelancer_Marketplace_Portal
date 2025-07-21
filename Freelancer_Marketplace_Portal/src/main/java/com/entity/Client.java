package com.entity;

public class Client {
    private int id;
    private String fullname;
    private String email;
    private String password;   // for authentication
    private String company;
    private String skills;     // relevant to project posting
    private String regDate;

    // Constructors
    public Client() {}

    public Client(int id, String fullname, String email, String password, String company, String skills, String regDate) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.company = company;
        this.skills = skills;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getSkills() {
		return skills;
	}

	public void setSkills(String skills) {
		this.skills = skills;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

   
    
   }
