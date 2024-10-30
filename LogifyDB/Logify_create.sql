-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-07-12 11:52:48.039

-- tables
CREATE TABLE Attachment (
    Id INT IDENTITY(1,1) NOT NULL,
    Message_id INT NOT NULL,
    Document_Id INT NOT NULL,
    CONSTRAINT Attachment_pk PRIMARY KEY (Id)
);

-- Table: Car
CREATE TABLE Car (
    Number VARCHAR(15) NOT NULL,
    Model VARCHAR(50) NULL,
    Brand VARCHAR(50) NULL,
    Status BIT NOT NULL,
    IsDeleted BIT NOT NULL,
    Employer_User_Id INT NOT NULL,
    CONSTRAINT Car_pk PRIMARY KEY (Number)
);

-- Table: Cargo
CREATE TABLE Cargo (
    Id INT IDENTITY(1,1) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Creation_Date DATETIME NOT NULL,
    Description VARCHAR(1023) NOT NULL,
    Car_Id VARCHAR(15) NOT NULL,
    Driver_User_Id INT NOT NULL,
    Employer_User_Id INT NOT NULL,
    CONSTRAINT Cargo_pk PRIMARY KEY (Id)
);

-- Table: Cargo_Document
CREATE TABLE Cargo_Document (
    Id INT IDENTITY(1,1) NOT NULL,
    Cargo_Id INT NOT NULL,
    Document_Id INT NOT NULL,
    CONSTRAINT Cargo_Document_pk PRIMARY KEY (Id)
);

-- Table: Chat
CREATE TABLE Chat (
    Id INT IDENTITY(1,1) NOT NULL,
    Start_date DATETIME NOT NULL,
    Employer_User_Id INT NOT NULL,
    Driver_User_Id INT NOT NULL,
    CONSTRAINT Chat_pk PRIMARY KEY (Id)
);

-- Table: Document
CREATE TABLE Document (
    Id INT IDENTITY(1,1) NOT NULL,
    Filename VARCHAR(255) NOT NULL,
    MongoId VARCHAR(255) NOT NULL,
    Filetype VARCHAR(255) NOT NULL,
    FileURL VARCHAR(255) NOT NULL,
    CONSTRAINT Document_pk PRIMARY KEY (Id)
);


-- Table: Driver
CREATE TABLE Driver (
    User_Id INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    CONSTRAINT Driver_pk PRIMARY KEY (User_Id)
);

-- Table: Employer
CREATE TABLE Employer (
    User_Id INT NOT NULL,
    CONSTRAINT Employer_pk PRIMARY KEY (User_Id)
);

-- Table: EmployerDriverHistory
CREATE TABLE EmployerDriverHistory (
    Id INT IDENTITY(1,1) NOT NULL,
    Employer_User_Id INT NOT NULL,
    Driver_User_Id INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NULL,
    CONSTRAINT EmployerDriverHistory_pk PRIMARY KEY (Id)
);

-- Table: Message
CREATE TABLE Message (
    Id INT IDENTITY(1,1) NOT NULL,
    Content TEXT NOT NULL,
    Date_time DATETIME NOT NULL,
    User_Id INT NOT NULL,
    Chat_id INT NOT NULL,
    CONSTRAINT Message_pk PRIMARY KEY (Id)
);

-- Table: Point
CREATE TABLE Point (
    Id INT IDENTITY(1,1) NOT NULL,
    Label VARCHAR(255) NOT NULL,
    Latitude INT NOT NULL,
    Longitude INT NOT NULL,
    "Order" INT NOT NULL,
    Cargo_Id INT NOT NULL,
    CONSTRAINT Point_pk PRIMARY KEY (Id)
);

-- Table: User
CREATE TABLE "User" (
    Id INT IDENTITY(1,1) NOT NULL,
    Name VARCHAR(40) NOT NULL,
    Surname VARCHAR(60) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Role VARCHAR(15) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (Id)
);

-- foreign keys
-- Reference: Attachment_Document (table: Attachment)
ALTER TABLE Attachment ADD CONSTRAINT Attachment_Document
    FOREIGN KEY (Document_Id)
    REFERENCES Document (Id);

-- Reference: Attachment_Message (table: Attachment)
ALTER TABLE Attachment ADD CONSTRAINT Attachment_Message
    FOREIGN KEY (Message_id)
    REFERENCES Message (Id);

-- Reference: Car_Employer (table: Car)
ALTER TABLE Car ADD CONSTRAINT Car_Employer
    FOREIGN KEY (Employer_User_Id)
    REFERENCES Employer (User_Id);

-- Reference: Cargo_Car (table: Cargo)
ALTER TABLE Cargo ADD CONSTRAINT Cargo_Car
    FOREIGN KEY (Car_Id)
    REFERENCES Car (Number);

-- Reference: Cargo_Document_Cargo (table: Cargo_Document)
ALTER TABLE Cargo_Document ADD CONSTRAINT Cargo_Document_Cargo
    FOREIGN KEY (Cargo_Id)
    REFERENCES Cargo (Id);

-- Reference: Cargo_Document_Document (table: Cargo_Document)
ALTER TABLE Cargo_Document ADD CONSTRAINT Cargo_Document_Document
    FOREIGN KEY (Document_Id)
    REFERENCES Document (Id);

-- Reference: Cargo_Driver (table: Cargo)
ALTER TABLE Cargo ADD CONSTRAINT Cargo_Driver
    FOREIGN KEY (Driver_User_Id)
    REFERENCES Driver (User_Id);

-- Reference: Cargo_Employer (table: Cargo)
ALTER TABLE Cargo ADD CONSTRAINT Cargo_Employer
    FOREIGN KEY (Employer_User_Id)
    REFERENCES Employer (User_Id);

-- Reference: Chat_Driver (table: Chat)
ALTER TABLE Chat ADD CONSTRAINT Chat_Driver
    FOREIGN KEY (Driver_User_Id)
    REFERENCES Driver (User_Id);

-- Reference: Chat_Employer (table: Chat)
ALTER TABLE Chat ADD CONSTRAINT Chat_Employer
    FOREIGN KEY (Employer_User_Id)
    REFERENCES Employer (User_Id);

-- Reference: Driver_User (table: Driver)
ALTER TABLE Driver ADD CONSTRAINT Driver_User
    FOREIGN KEY (User_Id)
    REFERENCES "User" (Id);

-- Reference: EmployerDriverHistory_Driver (table: EmployerDriverHistory)
ALTER TABLE EmployerDriverHistory ADD CONSTRAINT EmployerDriverHistory_Driver
    FOREIGN KEY (Driver_User_Id)
    REFERENCES Driver (User_Id);

-- Reference: EmployerDriverHistory_Employer (table: EmployerDriverHistory)
ALTER TABLE EmployerDriverHistory ADD CONSTRAINT EmployerDriverHistory_Employer
    FOREIGN KEY (Employer_User_Id)
    REFERENCES Employer (User_Id);

-- Reference: Message_Chat (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_Chat
    FOREIGN KEY (Chat_id)
    REFERENCES Chat (Id);

-- Reference: Message_User (table: Message)
ALTER TABLE Message ADD CONSTRAINT Message_User
    FOREIGN KEY (User_Id)
    REFERENCES "User" (Id);

-- Reference: Employer_User (table: Employer)
ALTER TABLE Employer ADD CONSTRAINT Employer_User
    FOREIGN KEY (User_Id)
    REFERENCES "User" (Id);

-- Reference: Point_Cargo (table: Point)
ALTER TABLE Point ADD CONSTRAINT Point_Cargo
    FOREIGN KEY (Cargo_Id)
    REFERENCES Cargo (Id);