Flask App with Terraform and OCI Deployment

This project demonstrates the setup and deployment of a Flask web application on Oracle Cloud Infrastructure (OCI) using Terraform for infrastructure provisioning. 
The application is served using Gunicorn and managed by a systemd service for automatic startup. The focus was more on deploying an app, so it is a very simple "Hello world" page.

Tools Used

- Flask: A lightweight Python web framework used to build the web application.
- Gunicorn: A Python WSGI HTTP server to serve the Flask app.
- Terraform: Infrastructure-as-Code (IaC) tool used to automate the deployment of OCI resources.
- Oracle Cloud Infrastructure (OCI): Cloud platform used for hosting the Flask app.
- systemd: A system and service manager for Linux, used to manage the automatic startup of the Flask app on system boot.
- Git: Version control system to manage and deploy the project code to GitHub.

Project Overview

**Flask App**

- A basic Flask application was created to serve web pages and handle HTTP requests.
- The app is served using Gunicorn for better performance and scalability.

**OCI Deployment**

- Terraform is used to automate the creation of necessary cloud resources on Oracle Cloud Infrastructure (OCI).
- Resources provisioned with Terraform include compute instances, networking configurations, and other infrastructure elements required to run the Flask app.

**Gunicorn Setup**

- Gunicorn is used to serve the Flask application. It’s set up with multiple worker processes to handle multiple requests efficiently.
- The Flask app is bound to `0.0.0.0:8000` for accessibility on the public IP of the instance.

**systemd Service**

- A `flask_app.service` systemd service file was created to ensure the Flask app starts automatically when the cloud instance boots.
- The service runs the Gunicorn server and is configured to restart automatically if it crashes.

Overall, this was a fun project that I used extensive AI, Google, and documentation research to get my hands on some IaC work, get more experience using Git as well as learning how to set up service automation. 
While the Flask app is simple for now, I'm looking forward to building it out in the future to see how I can adapt everything to a more complex application.

