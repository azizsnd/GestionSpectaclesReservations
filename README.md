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

### **Explanation of Markdown**:
1. **Code Blocks**: 
   - Use triple backticks (```` ``` ````) to create code blocks.
   - You can specify the programming language after the opening backticks (e.g., ```sql for SQL code blocks) to provide syntax highlighting.
   
2. **Inline Code**:  
   - Use single backticks for inline code (e.g., `SHOW TABLES;`).

### **Preview**:
When rendered on GitHub, the code snippets will appear as nicely formatted blocks with syntax highlighting, making the README visually appealing and easy to read. You can adjust the formatting to suit your needs based on the types of code you want to display.

Let me know if you need any more adjustments!
