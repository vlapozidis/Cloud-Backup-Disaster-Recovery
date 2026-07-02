/* ---------- 1. Departments ---------- */
CREATE TABLE Departments (
    DepartmentID    INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName  NVARCHAR(150) NOT NULL,
    Building        NVARCHAR(100) NULL,
    Budget          DECIMAL(15,2) NULL
);
GO

/* ---------- 2. Students ---------- */
CREATE TABLE Students (
    StudentID       INT IDENTITY(1,1) PRIMARY KEY,
    FirstName       NVARCHAR(100) NOT NULL,
    LastName        NVARCHAR(100) NOT NULL,
    Email           NVARCHAR(150) NOT NULL UNIQUE,
    DateOfBirth     DATE NOT NULL,
    EnrollmentDate  DATE NOT NULL DEFAULT GETDATE(),
    DepartmentID    INT NOT NULL,
    CONSTRAINT FK_Students_Departments
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

/* ---------- 3. Professors ---------- */
CREATE TABLE Professors (
    ProfessorID     INT IDENTITY(1,1) PRIMARY KEY,
    FirstName       NVARCHAR(100) NOT NULL,
    LastName        NVARCHAR(100) NOT NULL,
    Email           NVARCHAR(150) NOT NULL UNIQUE,
    HireDate        DATE NOT NULL,
    DepartmentID    INT NOT NULL,
    Title           NVARCHAR(50) NOT NULL
        CHECK (Title IN ('Assistant Professor', 'Associate Professor', 'Full Professor', 'Lecturer')),
    CONSTRAINT FK_Professors_Departments
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

/* ---------- 4. Classrooms ---------- */
CREATE TABLE Classrooms (
    ClassroomID     INT IDENTITY(1,1) PRIMARY KEY,
    BuildingName    NVARCHAR(100) NOT NULL,
    RoomNumber      NVARCHAR(20) NOT NULL,
    Capacity        INT NOT NULL CHECK (Capacity > 0)
);
GO

/* ---------- 5. Courses ---------- */
CREATE TABLE Courses (
    CourseID        INT IDENTITY(1,1) PRIMARY KEY,
    CourseName      NVARCHAR(150) NOT NULL,
    Credits         INT NOT NULL CHECK (Credits BETWEEN 1 AND 10),
    DepartmentID    INT NOT NULL,
    Semester        TINYINT NOT NULL CHECK (Semester BETWEEN 1 AND 8),
    MaxCapacity     INT NOT NULL DEFAULT 100,
    CONSTRAINT FK_Courses_Departments
        FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

/* ---------- 6. CourseSections ---------- */
CREATE TABLE CourseSections (
    SectionID       INT IDENTITY(1,1) PRIMARY KEY,
    CourseID        INT NOT NULL,
    ProfessorID     INT NOT NULL,
    AcademicYear    NVARCHAR(9) NOT NULL,   
    Semester        NVARCHAR(10) NOT NULL CHECK (Semester IN ('×åéìåñéíü', 'Åáñéíü')),
    ClassroomID     INT NULL,
    Schedule        NVARCHAR(200) NULL,    
    CONSTRAINT FK_Sections_Courses
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CONSTRAINT FK_Sections_Professors
        FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID),
    CONSTRAINT FK_Sections_Classrooms
        FOREIGN KEY (ClassroomID) REFERENCES Classrooms(ClassroomID)
);
GO

/* ---------- 7. Enrollments ---------- */
CREATE TABLE Enrollments (
    EnrollmentID    INT IDENTITY(1,1) PRIMARY KEY,
    StudentID       INT NOT NULL,
    SectionID       INT NOT NULL,
    EnrollmentDate  DATE NOT NULL DEFAULT GETDATE(),
    Status          NVARCHAR(20) NOT NULL DEFAULT 'active'
        CHECK (Status IN ('active', 'withdrawn', 'completed')),
    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Enrollments_Sections
        FOREIGN KEY (SectionID) REFERENCES CourseSections(SectionID),
    CONSTRAINT UQ_Enrollment UNIQUE (StudentID, SectionID)
);
GO

/* ---------- 8. Grades ---------- */
CREATE TABLE Grades (
    GradeID         INT IDENTITY(1,1) PRIMARY KEY,
    EnrollmentID    INT NOT NULL,
    GradeValue      DECIMAL(4,2) NULL CHECK (GradeValue BETWEEN 0 AND 10),
    GradeDate       DATE NOT NULL DEFAULT GETDATE(),
    ExamType        NVARCHAR(20) NOT NULL
        CHECK (ExamType IN ('midterm', 'final', 'coursework')),
    CONSTRAINT FK_Grades_Enrollments
        FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);
GO

/* ---------- 9. Advisors ---------- */
CREATE TABLE Advisors (
    AdvisorID       INT IDENTITY(1,1) PRIMARY KEY,
    ProfessorID     INT NOT NULL,
    StudentID       INT NOT NULL,
    AssignedDate    DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Advisors_Professors
        FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID),
    CONSTRAINT FK_Advisors_Students
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT UQ_Advisor_Student UNIQUE (StudentID) 
);
GO

/* ============================================================
   Indexes on critical columns (performance baseline)
   ============================================================ */
CREATE INDEX IX_Students_DepartmentID ON Students(DepartmentID);
CREATE INDEX IX_Students_EnrollmentDate ON Students(EnrollmentDate);
CREATE INDEX IX_Professors_DepartmentID ON Professors(DepartmentID);
CREATE INDEX IX_Courses_DepartmentID ON Courses(DepartmentID);
CREATE INDEX IX_Sections_CourseID ON CourseSections(CourseID);
CREATE INDEX IX_Sections_ProfessorID ON CourseSections(ProfessorID);
CREATE INDEX IX_Enrollments_StudentID ON Enrollments(StudentID);
CREATE INDEX IX_Enrollments_SectionID ON Enrollments(SectionID);
CREATE INDEX IX_Grades_EnrollmentID ON Grades(EnrollmentID);
GO
