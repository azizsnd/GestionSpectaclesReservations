# **GestionSpectaclesReservations**

## **Project Overview**  
This project is a comprehensive **Database Management System** (DBMS) designed and implemented using **Oracle SQL** and **PL/SQL**. It is built to streamline the process of managing shows, reservations and ticketing. The system provides a robust, scalable solution for event managers to add, modify, and cancel shows, track reservations, manage tickets, and more, all while maintaining data integrity through advanced Oracle features.

The project demonstrates a strong understanding of **database design**, **SQL**, and **PL/SQL programming**, using techniques like **stored procedures**, **triggers**, **sequences**, and **cursor-based operations** to automate critical tasks and enforce business rules.

---

## **Features**

This system includes a range of functionalities tailored for event management, which enhances the reliability, flexibility, and ease of use:

### **1. Core Functionalities**  
- **Show Management**:  
  Manage shows by adding, modifying, deleting, or searching for them. Show details include event date, time, performers, and venue information.
  
- **Reservation Management**:  
  Handle customer reservations with the ability to specify ticket categories, seat assignments, and pricing options.
  
- **Artist and Rubric Tracking**:  
  Manage artist data, including their availability for shows, and track rubrics assigned to each performance.

### **2. Advanced Database Techniques**  
- **Triggers**:  
  Ensure data integrity by automatically managing actions like reservation cancellations, show changes, or data validation. Triggers are used to handle complex business logic such as preventing overbooking or ensuring that show times do not overlap.
  
  ```sql
  CREATE OR REPLACE TRIGGER check_reservation_date
  BEFORE INSERT ON reservations
  FOR EACH ROW
  BEGIN
    IF :new.show_date < SYSDATE THEN
      RAISE_APPLICATION_ERROR(-20001, 'Reservation date cannot be in the past');
    END IF;
  END;
  ```
## 4. Scalability and Flexibility
The system is designed to scale effortlessly for both small and large-scale operations. Whether you're managing a local theater, a large conference, or an international event, the system adapts to diverse requirements. 

With its modular design, the solution can be expanded to accommodate new features or adjusted to handle increasing workloads, making it ideal for various event types and sizes.

## Technology Stack
- **Database**: Oracle 11g/12c
- **Programming Languages**: SQL, PL/SQL

## Installation and Setup

### 1. Database Setup
To get started, import the provided `.sql` files to create the necessary database schema, tables, and initial data. These files include:
- The structure for **shows**, **reservations**, **artists**, **ticket categories**, and more.
  
To import the files:
- Open your Oracle SQL Developer or any compatible Oracle database tool.
- Execute the `.sql` files to set up the database tables.

### 2. Execute Scripts
After the database schema is set up, you need to run the provided PL/SQL scripts. These scripts will:
- Create the necessary **packages**, **triggers**, and **stored procedures**.
- Handle critical tasks such as **data validation**, **event scheduling**, and **reservation management**.

To execute the scripts:
- Open your Oracle SQL Developer or another compatible tool.
- Run each script sequentially to ensure everything is set up correctly.

### 3. Connect to the Database
Once the database is set up and the scripts have been executed, you can connect to the Oracle database and begin using the system. To interact with the system:
- Use **Oracle SQL Developer** or any compatible database management tool (e.g., TOAD, SQLcl).
- Perform various queries to manage shows, reservations, tickets, and more.
  
You can now start managing shows, reservations, and all related components directly through your connected database tool.
