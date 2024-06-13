use library;
select * from tbl_library_branch;
select * from tbl_book_copies;
select * from tbl_book;
select * from tbl_borrower;
select * from tbl_book_loans;
select * from tbl_book_authors;
-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
with cte1 as(
select *
FROM tbl_book_copies AS bc
JOIN tbl_book AS tb
ON bc.book_copies_BookID=tb.book_BookID
JOIN tbl_library_branch as lb
ON lb.library_branch_BranchID=bc.book_copies_BranchID)
select book_copies_No_Of_Copies
from cte1
where book_Title='The Lost Tribe' and library_branch_BranchName='Sharpstown';

-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?
with cte2 as(
select *
FROM tbl_book_copies AS bc
JOIN tbl_book AS tb
ON bc.book_copies_BookID=tb.book_BookID
JOIN tbl_library_branch as lb
ON lb.library_branch_BranchID=bc.book_copies_BranchID)
select library_branch_BranchName,count(library_branch_BranchName)*book_copies_No_Of_Copies as lost_tribe_count
from cte2
where book_Title='The Lost Tribe'
group by library_branch_BranchName,book_copies_No_Of_Copies;

-- Retrieve the names of all borrowers who do not have any books checked out.
select borrower_BorrowerName from tbl_borrower
where borrower_CardNo not in (select book_loans_CardNo from tbl_book_loans);


-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address.
-- book title, borrower's name, borrower's address
with cte3 as(
select * from tbl_library_branch as tb
join tbl_book_loans as bl
on tb.library_branch_BranchID=bl.book_loans_BranchID
join tbl_borrower as br
on br.borrower_CardNo=bl.book_loans_CardNo
join tbl_book as book
on book.book_BookID=bl.book_loans_BookID)
select book_Title,borrower_BorrowerName,borrower_BorrowerAddress from cte3
where book_loans_DueDate='2018-02-03' and library_branch_BranchName='Sharpstown';

-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch
with cte4 as(
select * from tbl_library_branch as tlb
join tbl_book_loans as tbl
on tlb.library_branch_BranchID=tbl.book_loans_BranchID)
select library_branch_BranchName,count(library_branch_BranchName) as book_loans
from cte4
group by library_branch_BranchName
order by book_loans desc;

-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
with cte5 as(
select * from tbl_borrower as bor
join tbl_book_loans as tbl
on bor.borrower_CardNo=tbl.book_loans_CardNo)
select borrower_BorrowerName,borrower_BorrowerAddress,count(borrower_CardNo) as Books_check
from cte5
group by borrower_BorrowerName,borrower_BorrowerAddress
having Books_check>5
order by Books_check desc;

-- For each book authored by "Stephen King", retrieve the title and the number of copies 
-- owned by the library branch whose name is "Central".
with cte6 as(
select * from tbl_book_authors as ba
join tbl_book as book
on ba.book_authors_BookID=book.book_BookID
join tbl_book_copies as tbc
on tbc.book_copies_BookID=book.book_BookID
join tbl_library_branch as tlb
on tlb.library_branch_BranchID=tbc.book_copies_BranchID)
select book_Title,count(book_copies_No_Of_Copies)*book_copies_No_Of_Copies as Copies
from cte6
where book_authors_AuthorName='Stephen King' and library_branch_BranchName='Central'
group by book_Title,book_copies_No_Of_Copies;
