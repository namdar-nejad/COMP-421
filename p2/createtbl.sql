-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.

CREATE TABLE Mother
(
    HcId        INT         NOT NULL,
    Name        VARCHAR(30) NOT NULL,
    Phone       VARCHAR(15) NOT NULL,
    DoB         DATE        NOT NULL,
    Addr        VARCHAR(50) NOT NULL,
    Email       VARCHAR(30) NOT NULL UNIQUE,
    Profession  VARCHAR(20) NOT NULL,
    DueD        DATE        NOT NULL,

    BloodT      VARCHAR(4),

    PRIMARY KEY (HcId)
);

CREATE TABLE Father
(
    Fid         INT NOT NULL,
    Name        VARCHAR(30) NOT NULL,
    Phone       VARCHAR(15) NOT NULL,
    DoB         DATE        NOT NULL,
    Profession  VARCHAR(20) NOT NULL,

    Addr        VARCHAR(50),
    Email       VARCHAR(30),
    BloodT      VARCHAR(4),
    Hid         INT,

    PRIMARY KEY (Fid)
);

CREATE TABLE Couple
(
    Cid         INT NOT NULL,
    HcId        INT NOT NULL,

    Fid         INT,
    Appr        BOOLEAN with default FALSE, --approved

    PRIMARY KEY (Cid),
    FOREIGN KEY (HcId) REFERENCES Mother,
    FOREIGN KEY (Fid)  REFERENCES Father
);

CREATE TABLE Facilities
(
    Hid         INT NOT NULL,
    Name        VARCHAR(30) NOT NULL,
    Addr        VARCHAR(50) NOT NULL,
    Email       VARCHAR(30) NOT NULL,
    Phone       VARCHAR(15) NOT NULL,
    Web         VARCHAR(30) NOT NULL,

    PRIMARY KEY (Hid)
);

CREATE TABLE CommClinic
(
    Hid         INT NOT NULL,
    PRIMARY KEY (Hid),
    FOREIGN KEY (Hid) REFERENCES Facilities
);

CREATE TABLE BirthCenter
(
    Hid         INT NOT NULL,
    Capacity    INT,
    PRIMARY KEY (Hid),
    FOREIGN KEY (Hid) REFERENCES Facilities
);

CREATE TABLE Midwife
(
    MidId       INT NOT NULL,
    Hid         INT NOT NULL,
    Name        VARCHAR(30) NOT NULL,
    Phone       VARCHAR(15) NOT NULL,
    Email       VARCHAR(30) NOT NULL UNIQUE,

    PRIMARY KEY (MidId),
    FOREIGN KEY (Hid) REFERENCES Facilities
);

CREATE TABLE Technician
(
    TechId      INT NOT NULL,
    Name        VARCHAR(50) NOT NULL,
    Phone       VARCHAR(15),

    PRIMARY KEY (TechId)
);

CREATE TABLE Pregnancy
(
    Cid         INT NOT NULL,
    Num         INT NOT NULL,
    PrimID      INT NOT NULL,
    BackupID    INT,
    Status      VARCHAR(50) NOT NULL,
    Hid         INT,
    Interested  BOOLEAN,
    HomeBirth   BOOLEAN with default FALSE,
    DONE        BOOLEAN with default FALSE,

    -- CHECK (NOT PrimID = BackupID),

    PRIMARY KEY (Cid, Num),
    FOREIGN KEY (Hid) REFERENCES BirthCenter,
    FOREIGN KEY (Cid) REFERENCES Couple,
    FOREIGN KEY (PrimID) REFERENCES Midwife,
    FOREIGN KEY (BackupID) REFERENCES Midwife
);

CREATE TABLE DueDates
(
    Cid         INT NOT NULL,
    Num         INT NOT NULL,
    ApproxD     DATE NOT NULL,
    Info        VARCHAR(2000),

    PRIMARY KEY (Cid, Num, ApproxD),
    FOREIGN KEY (Cid, Num) REFERENCES Pregnancy
);

CREATE TABLE Baby
(
    Bid         INT NOT NULL,
    Cid         INT NOT NULL,
    Num         INT NOT NULL,

    Name        VARCHAR(50),
    Gender      VARCHAR(50),
    DoB         DATE,
    BTime       TIME,
    BloodT      VARCHAR(4),

    PRIMARY KEY (Bid),
    FOREIGN KEY (Cid, Num) REFERENCES Pregnancy
);

CREATE TABLE Appointment
(
    Aid         INT NOT NULL,
    Date        DATE NOT NULL,
    Time        TIME NOT NULL,
    Num         INT NOT NULL,
    Cid         INT NOT NULL,
    MidId       INT NOT NULL,

    PRIMARY KEY (Aid),
    FOREIGN KEY (Cid, Num) REFERENCES Pregnancy,
    FOREIGN KEY (MidId) REFERENCES Midwife
);

CREATE TABLE InfoSess
(
    Iid         INT NOT NULL,
    MidId       INT NOT NULL,
    Date        DATE NOT NULL,
    Time        TIME NOT NULL,
    Lang        VARCHAR(30) NOT NULL,
    Capacity    INT NOT NULL,

    PRIMARY KEY (Iid),
    FOREIGN KEY (MidId) REFERENCES Midwife
);

CREATE TABLE InfoRegisteration
(
    Iid        INT NOT NULL,
    Cid        INT NOT NUll,
    Attended   BOOLEAN,

    PRIMARY KEY (Iid, Cid),
    FOREIGN KEY (Cid) REFERENCES Couple,
    FOREIGN KEY (Iid) REFERENCES InfoSess
);

CREATE TABLE Notes
(
    Aid         INT NOT NULL,
    Date        Date NOT NULL,
    Time        Time NOT NULL,
    Text        VARCHAR(2000) NOT NUll,

    PRIMARY KEY (Aid, Date, Time),
    FOREIGN KEY (Aid) REFERENCES Appointment
);

CREATE TABLE Tests
(
    Tid         INT NOT NULL,
    MidId       INT NOT NULL,
    Num         INT NOT NULL,
    Cid         INT NOT NULL,
    Ttype       VARCHAR(50) NOT NULL,
    PresDate    DATE NOT NULL,
    SampDate    DATE,
    LabDate     DATE,
    TechId      INT,
    Bid         INT,
    Results     VARCHAR(50),

    -- CHECK(PresDate > SampDate),

    PRIMARY KEY (Tid),
    FOREIGN KEY (MidId) REFERENCES Midwife,
    FOREIGN KEY (Cid, Num) REFERENCES Pregnancy,
    FOREIGN KEY (Bid) REFERENCES Baby,
    FOREIGN KEY (TechId) REFERENCES Technician
);

