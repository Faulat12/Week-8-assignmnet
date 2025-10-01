const db = require('../config/database');

class Course {
  
  static getAll(callback) {
    const query = 'SELECT * FROM courses';
    db.query(query, callback);
  }


  static getById(id, callback) {
    const query = 'SELECT * FROM courses WHERE id = ?';
    db.query(query, [id], callback);
  }

  
  static create(courseData, callback) {
    const { title, description, instructor, credits } = courseData;
    const query = 'INSERT INTO courses (title, description, instructor, credits) VALUES (?, ?, ?, ?)';
    db.query(query, [title, description, instructor, credits], callback);
  }

  
  static update(id, courseData, callback) {
    const { title, description, instructor, credits } = courseData;
    const query = 'UPDATE courses SET title = ?, description = ?, instructor = ?, credits = ? WHERE id = ?';
    db.query(query, [title, description, instructor, credits, id], callback);
  }


  static delete(id, callback) {
    const query = 'DELETE FROM courses WHERE id = ?';
    db.query(query, [id], callback);
  }

 
  static getStudents(courseId, callback) {
    const query = `
      SELECT s.*, e.grade, e.enrollment_date 
      FROM students s 
      INNER JOIN enrollments e ON s.id = e.student_id 
      WHERE e.course_id = ?
    `;
    db.query(query, [courseId], callback);
  }

  
  static enrollStudent(courseId, studentId, callback) {
    const query = 'INSERT INTO enrollments (course_id, student_id) VALUES (?, ?)';
    db.query(query, [courseId, studentId], callback);
  }
}

module.exports = Course;