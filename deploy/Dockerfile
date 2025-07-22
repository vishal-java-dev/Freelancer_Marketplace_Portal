# Use official Tomcat image
FROM tomcat:9.0-jdk11

# Remove default Tomcat apps (optional but clean)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the ROOT context
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
