CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    membership_date DATE NOT NULL,
    membership_status ENUM('Active', 'Suspended', 'Expired') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year YEAR,
    death_year YEAR,
    nationality VARCHAR(50),
    biography TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) UNIQUE NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    website VARCHAR(200),
    established_year YEAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    edition VARCHAR(20),
    publication_year YEAR,
    genre VARCHAR(50) NOT NULL,
    language VARCHAR(30) DEFAULT 'English',
    page_count INT,
    description TEXT,
    publisher_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign key constraint
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE RESTRICT
);

CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    contribution_type ENUM('Primary', 'Co-author', 'Editor', 'Translator') DEFAULT 'Primary',
    
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

CREATE TABLE book_copies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    copy_number INT NOT NULL,
    acquisition_date DATE NOT NULL,
    price DECIMAL(10,2),
    condition ENUM('New', 'Good', 'Fair', 'Poor', 'Damaged') DEFAULT 'Good',
    location VARCHAR(50),
    status ENUM('Available', 'Checked Out', 'Reserved', 'Under Repair', 'Lost') DEFAULT 'Available',
    
    -- Unique constraint for book and copy number combination
    UNIQUE KEY unique_book_copy (book_id, copy_number),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

ONE-TO-MANY RELATIONSHIPS:
Publishers → Books (1:N)

One publisher publishes many books

RESTRICT delete to prevent orphaned books

Books → Book Copies (1:N)

One book has multiple physical copies

CASCADE delete copies when book is deleted

Books → Reservations (1:N)

One book gets many reservations

CASCADE delete reservations when book deleted

MANY-TO-MANY RELATIONSHIPS:
Books ↔ Authors (N:M via book_authors)

Books can have multiple authors

Authors can write multiple books

CASCADE delete relationships

Books ↔ Categories (N:M via book_categories)

Books can be in multiple categories

Categories contain multiple books

CASCADE delete relationships