create database library;

use library;

create table tbl_publisher(
publisher_PublisherName varchar(50) primary key,
publisher_PublisherAddress varchar(100),
publisher_PublisherPhone varchar(50)
); 

create table tbl_borrower(
borrower_CardNo int primary key auto_increment,
borrower_BorrowerName varchar(50),
borrower_BorrowerAddress varchar(100),
borrower_BorrowerPhone varchar(50)
);

create table tbl_book_authors(
book_authors_AuthorID  int primary key auto_increment,
book_authors_BookID int,
book_authors_AuthorName varchar(50),
foreign key (book_authors_AuthorID)
references tbl_book(book_BookID) on delete cascade
);

create table tbl_book(
book_BookID int primary key auto_increment,
book_Title varchar(50),
book_PublisherName varchar(50),
foreign key (book_PublisherName)
references tbl_publisher(publisher_PublisherName) on delete cascade
);

create table tbl_book_copies(
book_copies_CopiesID int primary key auto_increment,
book_copies_BookID int,
book_copies_BranchID int,
book_copies_No_Of_Copies int,
foreign key (book_copies_BookID)
references tbl_book(book_BookID) on delete cascade,
foreign key (book_copies_BranchID)
references tbl_library_branch(library_branch_BranchID) on delete cascade
);

create table tbl_library_branch(
library_branch_BranchID int primary key auto_increment,
library_branch_BranchName varchar(50),
library_branch_BranchAddress varchar(100)
);

create table tbl_book_loans(
book_loans_LoansID int primary key auto_increment,
book_loans_BookID int,
book_loans_BranchID int,
book_loans_CardNo int,
book_loans_DateOut varchar(50),
book_loans_DueDate varchar(50),
foreign key (book_loans_BookID)
references tbl_book(book_BookID) on delete cascade,
foreign key (book_loans_BranchID)
references tbl_library_branch(library_branch_BranchID) on delete cascade,
foreign key (book_loans_CardNo)
references tbl_borrower(borrower_CardNo) on delete cascade
);

select * from tbl_book_authors;

insert into tbl_book_authors(book_authors_BookID,book_authors_AuthorID,book_authors_AuthorName) values
(1,1,'Patrick Rothfuss'),
(2,2,'Stephen King'),
(3,3,'Stephen King'),
(4,4,'Frank Herbert'),
(5,5,'J.R.R. Tolkien'),
(6,6,'Christopher Paolini'),
(7,7,'Patrick Rothfuss'),
(8,8,'J.K. Rowling'),
(9,9,'Haruki Murakami'),
(10,10,'Shel Silverstein'),
(11,11,'Douglas Adams'),
(12,12,'Aldous Huxley'),
(13,13,'William Goldman'),
(14,14,'Chuck Palahniuk'),
(15,15,'Louis Sachar'),
(16,16,'J.K. Rowling'),
(17,17,'J.K. Rowling'),
(18,18,'J.R.R. Tolkien'),
(19,19,'George R.R. Martin'),
(20,20,'Mark Lee');

-- Add a new column for the date in DATE format
ALTER TABLE tbl_book_loans
ADD COLUMN new_date_column1 DATE,
ADD COLUMN new_date_column2 DATE;

-- Update the new column using STR_TO_DATE
UPDATE tbl_book_loans
SET new_date_column1 = STR_TO_DATE(book_loans_DateOut, '%m-%d-%Y'),
new_date_column2 = STR_TO_DATE(book_loans_DueDate, '%m-%d-%Y');

-- ALTER TABLE your_table DROP COLUMN date_string;
alter table tbl_book_loans
drop column book_loans_DateOut,
drop column book_loans_DueDate;

-- Changing the names of old columns into new ones
alter table tbl_book_loans
change new_date_column1 book_loans_DateOut date,
change new_date_column2 book_loans_DueDate date;




