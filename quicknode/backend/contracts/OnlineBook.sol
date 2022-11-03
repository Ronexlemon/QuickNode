// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
contract OnlineBookStore is Ownable{
    struct BookStore{
        address payable owner;
       string  bookname;
       string bookDescription;
       uint bookprice;
       uint bookId;
       bool sold;


    }
    mapping(uint256 => BookStore)public bookstore;
    uint bookindex=0 ;
    mapping(uint => bool)private _exists;
    modifier exist(uint index){
        require(_exists[index],"query only books that exists");
        _;
    }

    function addBook(string calldata _bookname,string calldata _bookdescription,uint _bookprice)public{
        BookStore storage  bookArchive = bookstore[bookindex];
         bookArchive.owner = payable(msg.sender);
        bookArchive.bookname = _bookname;
         bookArchive.bookDescription = _bookdescription;
         bookArchive.bookprice= _bookprice;
          bookArchive.bookId = bookindex;
           bookArchive.sold = false;
             _exists[bookindex] = true;

           bookindex = bookindex +1;
         
    }
    function getAllBooks()public view returns(BookStore[] memory props){
        props = new BookStore[](bookindex);
        for(uint index=0; index< bookindex; index++){
            props[index] = bookstore[index];
        }


    }
    function removeBook(uint _bookId)public onlyOwner exist(_bookId) {
    uint newbookindex = bookindex - 1;
    bookindex = newbookindex;
    _exists[newbookindex] = false;
    bookstore[_bookId] = bookstore[newbookindex];
    delete  bookstore[newbookindex];
    }
    
    function buyBook(uint _bookId)public payable{
        require(bookstore[_bookId].owner != msg.sender,"Please you can not buy your own book ");
        bookstore[_bookId].owner.transfer( bookstore[_bookId].bookprice );
        

    }
    function getTotalNumberOfBooks()public view returns(uint){
        return bookindex;
    }
}