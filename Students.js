const db = require('../config/database');

class Student {
  static getAll(callback) {
    const query = 'SELECT * FROM students';
    db.query(query, callback);
  }

  static getById(id, callback) {
    const query = 'SELECT * FROM students WHERE id = ?';
    db.query(query, [id], callback);
  }

  static create(studentData, callback) {
    const { name, email, age, grade } = studentData;
    const query = 'INSERT INTO students (name, email, age, grade) VALUES (?, ?, ?, ?)';
    db.query(query, [name, email, age, grade], callback);
  }

  static update(id, studentData, callback) {
    const { name, email, age, grade } = studentData;
    const query = 'UPDATE students SET name = ?, email = ?, age = ?, grade = ? WHERE id = ?';
    db.query(query, [name, email, age, grade, id], callback);
  }

  static delete(id, callback) {
    const query = 'DELETE FROM students WHERE id = ?';
    db.query(query, [id], callback);
  }

  static getCourses(studentId, callback) {
    const query = `
      SELECT c.*, e.grade, e.enrollment_date 
      FROM courses c 
      INNER JOIN enrollments e ON c.id = e.course_id 
      WHERE e.student_id = ?
    `;
    db.query(query, [studentId], callback);
  }
}

module.exports = Student;