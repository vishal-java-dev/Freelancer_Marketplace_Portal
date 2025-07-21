# 💼 Freelancer Marketplace Portal

This is a "Java-based Freelancer Marketplace" web application that connects clients with freelancers. It allows users to post projects, place bids, chat, review each other, and track earnings — all through a multi-role portal.

---

## 🚀 Technologies Used

- **Backend**: Java (Servlet + JSP), JDBC
- **Frontend**: HTML, CSS, Bootstrap, JavaScript
- **Database**: MySQL
- **Tools**: Eclipse IDE, Apache Tomcat (v9+)

---

## 📦 Features

✅ Multi-role system: Admin, Client, Freelancer  
✅ Project posting & bidding system  
✅ Private messaging/chat module  
✅ Review & rating system  
✅ Freelancer earnings tracking & report  
✅ Admin dashboard & analytics  
✅ Mobile-friendly UI using Bootstrap

---

## 🛠️ How to Run

1. Import project into **Eclipse** as a **Dynamic Web Project**
2. Import the SQL file from `db/freelancer_marketplace.sql` into your **MySQL database**
3. Configure database credentials in `com.db.DBConnect.java`
4. Deploy the project on **Apache Tomcat Server (9 or above)**
5. Run from browser: `http://localhost:8080/Freelancer_Marketplace_Portal/`

---

## 📁 Folder Structure
Freelancer_Marketplace_Portal/
├── src/
│ ├── com.dao/
│ ├── com.db/
│ ├── com.entity/
│ └── com.servlet/
├── WebContent/
│ ├── admin/
│ ├── client/
│ ├── freelancer/
│ ├── components/
│ └── index.jsp
├── db/
│ └── freelancer_marketplace.sql
├── README.md
└── .gitignore


---
## 🖼️ Screenshots

### 📌 Dashboard View
![Freel-home](https://github.com/user-attachments/assets/17cc4ea7-0fee-43e8-b727-ec2939fb052a)
![home2](https://github.com/user-attachments/assets/0d48ab05-efb0-48b3-a7ff-8d9a781ee924)

![home3](https://github.com/user-attachments/assets/74c6fd0b-da69-4423-a447-6af110ee1341)

### 📌 Admin Page
![admin-log](https://github.com/user-attachments/assets/4fefb16c-8129-4bdc-b33d-eeb0e80867e8)
![ad-db](https://github.com/user-attachments/assets/1ec4b87f-82f0-491b-b916-391286b7d762)
![ad-pos-pr](https://github.com/user-attachments/assets/e4845e31-ff60-4408-8c1d-2075c69f0587)
![ad-pr-dtls](https://github.com/user-attachments/assets/48a164a7-e7d6-4fbc-8353-562258530bd4)
![ad-cmpl-pr](https://github.com/user-attachments/assets/03038675-d6b0-4b07-a9b2-f3a4b65b490a)
![ad-fr](https://github.com/user-attachments/assets/47413964-022c-4480-a83c-771a8cd0b6f1)
![ad-vfr](https://github.com/user-attachments/assets/d829c5c9-c71e-4765-b520-e8bd7957ad15)
![ad-cl](https://github.com/user-attachments/assets/9b6ea481-08f9-4acc-a076-7cf7dd988bd0)
![ad-vcl](https://github.com/user-attachments/assets/58dd0566-f5ab-4d02-9ca6-2847d6a2d400)
![ad-pmnt](https://github.com/user-attachments/assets/a31b8730-fd22-49f1-abc4-dfbb032be6ca)

### 📌 Client Page
![cli-reg](https://github.com/user-attachments/assets/4929cba8-566e-4987-a586-16177635ba6e)
![cli-log](https://github.com/user-attachments/assets/259630aa-ad34-40cb-b251-f640ec035c09)
![cl-db](https://github.com/user-attachments/assets/f73b9dd3-fd1e-4f88-850c-6c589dfb4097)
![cl-ppr](https://github.com/user-attachments/assets/f9b82f9a-fb5a-4e00-9c1a-30e2e6cf7665)
![cl-mpr](https://github.com/user-attachments/assets/fa9f5dbd-9dc2-412d-b1b6-50eb6627006c)
![cl-pr](https://github.com/user-attachments/assets/38b1be9d-6d60-4a53-b944-32879b071424)
![cl-bid](https://github.com/user-attachments/assets/25c8595a-82ed-4f4b-874f-9582053fce74)
![cl-fr-p](https://github.com/user-attachments/assets/924a3e6d-6ede-44cf-b646-4e9c7558b111)
![cl-message](https://github.com/user-attachments/assets/13c8ca77-eedb-47fe-8a76-683e5bdb82f9)
![cl-prof](https://github.com/user-attachments/assets/038c13b2-6c39-46cd-af21-78bf38c07788)
![cl-ed-prof](https://github.com/user-attachments/assets/f3919395-1171-4171-8505-41000bd9d6f1)
![cl-chp](https://github.com/user-attachments/assets/e66a4cab-4924-4dff-a806-d849b7b62771)

### 📌 
Freelancer Page
![free-reg](https://github.com/user-attachments/assets/62c721bb-41d3-4c13-8d3e-2fa2ab829c27)
![free-log](https://github.com/user-attachments/assets/a5452ff2-f08a-4255-a2a6-7ea756e8d5f8)
![free-db](https://github.com/user-attachments/assets/31087c24-3f48-4812-9c41-b14f882b8bc4)
![fr-pr](https://github.com/user-attachments/assets/2d65158e-9133-4f96-8c49-d4ea68c05616)
![fr-assn-pr](https://github.com/user-attachments/assets/496b8065-48c1-4578-a9d7-b86e457b318f)
![fr-bid](https://github.com/user-attachments/assets/b8f34158-e844-4c17-b600-cd8617dc60c3)
![fr-message](https://github.com/user-attachments/assets/c3597007-b951-4d11-8005-601f5ad98741)
![fr-ern](https://github.com/user-attachments/assets/6840c344-e00c-4540-aa2e-7877fcce48f1)
![fr-cl-rting](https://github.com/user-attachments/assets/38126970-f65f-4140-a466-246198015f41)
![fr-chp](https://github.com/user-attachments/assets/32f2c8ad-ffbb-44ac-81e1-66fd083fba4d)


## 🙋‍♂️ Author

**Vishal Yadav**  
📧 Email: [mr.vishalyadav03@gmail.com](mr.vishalyadav0311@gmail.com)  
🔗 GitHub: [github.com/vishal-java-dev](https://github.com/vishal-java-dev)  
🔗 LinkedIn: [linkedin.com/in/vishal-java-developer](https://www.linkedin.com/in/vyadav03)

---

## 📜 License

This project is open-source and free to use for learning and educational purposes.

---

## 🌟 Show Your Support

If you like this project, give it a ⭐ on [GitHub](https://github.com/vishal-java-dev/Freelancer_Marketplace_Portal)!


