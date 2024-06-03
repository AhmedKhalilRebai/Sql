const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database(':memory:');

db.serialize(() => {
  db.run(`
    CREATE TABLE Gymnasium (
      GymID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name TEXT,
      Address TEXT,
      PhoneNumber TEXT
    )
  `);

  db.run(`
    CREATE TABLE Member (
      MemberID INTEGER PRIMARY KEY AUTOINCREMENT,
      LastName TEXT,
      FirstName TEXT,
      Address TEXT,
      DateOfBirth DATE,
      Gender TEXT,
      GymID INTEGER,
      FOREIGN KEY (GymID) REFERENCES Gymnasium(GymID)
    )
  `);

  db.run(`
    CREATE TABLE Coach (
      CoachID INTEGER PRIMARY KEY AUTOINCREMENT,
      LastName TEXT,
      FirstName TEXT,
      Age INTEGER,
      Specialty TEXT
    )
  `);

  db.run(`
    CREATE TABLE Session (
      SessionID INTEGER PRIMARY KEY AUTOINCREMENT,
      SportType TEXT,
      Schedule DATETIME,
      GymID INTEGER,
      MaxMembers INTEGER DEFAULT 20,
      FOREIGN KEY (GymID) REFERENCES Gymnasium(GymID)
    )
  `);

  db.run(`
    CREATE TABLE SessionCoach (
      SessionID INTEGER,
      CoachID INTEGER,
      PRIMARY KEY (SessionID, CoachID),
      FOREIGN KEY (SessionID) REFERENCES Session(SessionID),
      FOREIGN KEY (CoachID) REFERENCES Coach(CoachID)
    )
  `);

  db.run(`
    CREATE TABLE SessionMember (
      SessionID INTEGER,
      MemberID INTEGER,
      PRIMARY KEY (SessionID, MemberID),
      FOREIGN KEY (SessionID) REFERENCES Session(SessionID),
      FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
    )
  `);
});

module.exports = db;
