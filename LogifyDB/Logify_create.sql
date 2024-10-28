-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-07-12 11:52:48.039

-- tables
-- Table: Attachment
CREATE TABLE Attachment (
    Id int  NOT NULL,
    Message_id int  NOT NULL,
    Document_Id int  NOT NULL,
    CONSTRAINT Attachment_pk PRIMARY KEY  (Id)
);

-- Table: Car
CREATE TABLE Car (
    Number varchar(15)  NOT NULL,
    Model varchar(50)  NULL,
    Brand varchar(50)  NULL,
    Status bit  NOT NULL,
    IsDeleted bit  NOT NULL,
    Employer_User_Id int  NOT NULL,
    CONSTRAINT Car_pk PRIMARY KEY  (Number)
);

-- Table: Cargo
CREATE TABLE Cargo (
    Id int  NOT NULL,
    Status varchar(20)  NOT NULL,
    Creation_Date datetime  NOT NULL,
    Description varchar(1023)  NOT NULL,
    Car_Id varchar(15)  NOT NULL,
    Driver_User_Id int  NOT NULL,
    Employer_User_Id int  NOT NULL,
    CONSTRAINT Cargo_pk PRIMARY KEY  (Id)
);

-- Table: Cargo_Document
CREATE TABLE Cargo_Document (
    Id int  NOT NULL,
    Cargo_Id int  NOT NULL,
    Document_Id int  NOT NULL,
    CONSTRAINT Cargo_Document_pk PRIMARY KEY  (Id)
);

-- Table: Chat
CREATE TABLE Chat (
    Id int  NOT NULL,
    Start_date datetime  NOT NULL,
    Owner_User_Id int  NOT NULL,
    Driver_User_Id int  NOT NULL,
    CONSTRAINT Chat_pk PRIMARY KEY  (Id)
);

-- Table: Document
CREATE TABLE Document (
    Id int  NOT NULL,
    Filename varchar(255)  NOT NULL,
    MongoId int  NOT NULL,
    Filetype varchar(255)  NOT NULL,
    FileURL varchar(255)  NOT NULL,
    CONSTRAINT Document_pk PRIMARY KEY  (Id)
);

-- Table: Driver
CREATE TABLE Driver (
    User_Id int  NOT NULL,
    Status varchar(50)  NOT NULL,
    CONSTRAINT Driver_pk PRIMARY KEY  (User_Id)
);

-- Table: Employer
CREATE TABLE Employer (
    User_Id int  NOT NULL,
    CONSTRAINT Employer_pk PRIMARY KEY  (User_Id)
);

-- Table: EmployerDriverHistory
CREATE TABLE EmployerDriverHistory (
    Id int  NOT NULL,
    Employer_User_Id int  NOT NULL,
    Driver_User_Id int  NOT NULL,
    StartDate datetime  NOT NULL,
    EndDate datetime  NULL,
    CONSTRAINT EmployerDriverHistory_pk PRIMARY KEY  (Id)
);

-- Table: Message
CREATE TABLE Message (
    Id int  NOT NULL,
    Content text  NOT NULL,
    Date_time datetime  NOT NULL,
    User_Id int  NOT NULL,
    Chat_id int  NOT NULL,
    CONSTRAINT Message_pk PRIMARY KEY  (Id)
);

-- Table: Point
CREATE TABLE Point (
    Id int  NOT NULL,
    Label varchar(255)  NOT NULL,
    Latitude int  NOT NULL,
    Longitude int  NOT NULL,
    "Order" int  NOT NULL,
    Cargo_Id int  NOT NULL,
    CONSTRAINT Point_pk PRIMARY KEY  (Id)
);

-- Table: User
CREATE TABLE "User" (
    Id int  NOT NULL,
    Name varchar(40)  NOT NULL,
    Surname varchar(60)  NOT NULL,
    PhoneNumber varchar(15)  NOT NULL,
    Role varchar(15)  NOT NULL,
    PasswordHash varchar(255)  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY  (Id)
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

-- Reference: Chat_Owner (table: Chat)
ALTER TABLE Chat ADD CONSTRAINT Chat_Owner
    FOREIGN KEY (Owner_User_Id)
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

-- Reference: Owner_User (table: Employer)
ALTER TABLE Employer ADD CONSTRAINT Owner_User
    FOREIGN KEY (User_Id)
    REFERENCES "User" (Id);

-- Reference: Point_Cargo (table: Point)
ALTER TABLE Point ADD CONSTRAINT Point_Cargo
    FOREIGN KEY (Cargo_Id)
    REFERENCES Cargo (Id);