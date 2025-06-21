# HappenIn: Event Management System

HappenIn is a full‑stack Event Management Web Application designed to facilitate seamless creation, management, and tracking of events. It provides both user(customer and organizer)‑facing and admin interfaces for comprehensive event organization, analytics, and control.

---

## Table of Contents

- [Tech Stack](#tech-stack)  
- [Features](#features)  
- [Installation](#installation)  
- [Project Structure](#project-structure)  
- [Usage](#usage)  
- [Documentation](#documentation)  
- [Contributors](#contributors)  
- [License](#license)  

---

## Tech Stack

- **Backend:** Django (Python)  
- **Frontend:** JavaScript, HTML, CSS  
- **Database:** PostgreSQL  
- **Deployment & Hosting:** Supabase  

---

## Features

For detailed features and functional specifications, see the **Business Requirement Document**:  
📄 [Business_Requirement.md](https://github.com/Atin1704/Happenin-Event_management-/blob/main/Business_Requirement.md)

### Key Functionalities
- **Users & Organizers**  
  - Registration, login, profile management (OTP‑verified email & phone).  
  - Browse and filter events; secure booking with QR e‑tickets.  
- **Event Management**  
  - Create, update, cancel events; integrated payment & refund flows.  
- **Admin Dashboard**  
  - Verify/ban organizers; handle complaints; view system‑wide analytics.  
- **Analytics & Stats**  
  - Real‑time stats: total users, companies with jobs, total jobs.  
  - Drill‑down by company or user; download per‑risk analysis reports.  
- **Notifications & Feedback**  
  - Automated alerts (bookings, cancellations, refunds).  
  - Ratings, comments, complaints, and resolutions.  

---

## Installation

1. **Clone the repo**  
   ```bash
   git clone https://github.com/Atin1704/Happenin-Event_management-.git
   cd Happenin-Event_management-

2. **Backend Setup** 
   cd backend
   pip install -r requirements.txt
   cp .env.example .env   # configure your DB and secret keys
   python manage.py migrate
   python manage.py runserver

3. **Frontend Setup** 
   cd ../frontend
   # serve `index.html` via your favorite static server, or open directly in browser

4. **Database**
   Ensure PostgreSQL is running.

---

## Project Structure

- **backend/**
  - Contains all Django backend code
  - `manage.py`: Django's command-line utility

- **frontend/**
  - Contains all frontend files
  - `index.html`: Main entry point
  -  Images and other media files

- **Documentation Files**
  - `Business_Requirement.md`: Detailed feature specifications
  - `ER_Model.png`: Visual database schema
  - `Relational_Model.png`: Database table relationships

---

## Usage
- Serve index.html after setting up everythin and login either as user or organizer or admin to use functionalities for respective users.

---

## Documentation
- **Business Requirement/** : https://github.com/Atin1704/Happenin-Event_management-/blob/main/Business_Requirement.md

- **ER Model/** : https://github.com/Atin1704/Happenin-Event_management-/blob/main/ER_Model.png

- **Documentation Files** : https://github.com/Atin1704/Happenin-Event_management-/blob/main/Relational_Model.png

---

## Contributors
- Abhinav Kashyap, abhinav23022@iiitd.ac.in

- Aryan Vashishtha, aryan23148@iiitd.ac.in

- Atin Aggarwal, atin23157@iiitd.ac.in

- Samayra Meena, samayra23476@iiitd.ac.in

---

## License

- This project is developed for academic purposes as part of a university course. No formal open-source license is applied.















