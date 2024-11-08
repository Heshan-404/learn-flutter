import 'dart:io';

void main() {
  homePage();
}

void homePage() {
  while (true) {
    clearScreen();
    stdout.writeln("+----------------------------------------+");
    stdout.writeln("|\tLibrary Management System\t |");
    stdout.writeln("+----------------------------------------+\n");
    stdout.writeln("\t 1 - Add Book");
    stdout.writeln("\t 2 - Search Book");
    stdout.writeln("\t 3 - Edit Book");
    stdout.writeln("\t 4 - Show Book List");
    stdout.writeln("\t 5 - Delete Book\n");
    stdout.write("Select a option : ");
    String? input = stdin.readLineSync();
    num selectedOption = validateOptionInput(1, 5, input!, "Invalid Input");
    switch (selectedOption) {
      case 1:
        addBook();
        break;
      case 2:
        searchBook();
        break;
      case 3:
        editBook();
        break;
      case 4:
        showBookList();
        break;
      case 5:
        deleteBook();
        break;
      default:
    }
  }
}

void addBook() {
  var bookListInstance = BookList.getBookListInstance();
  addBookLoop:
  while (true) {
    clearScreen();
    stdout.writeln("+----------------------------------------+");
    stdout.writeln("|\t\tAdd Book\t\t |");
    stdout.writeln("+----------------------------------------+\n");
    stdout.write(" - Book Name : ");
    var bookName = stdin.readLineSync();
    stdout.write(" - Author Name : ");
    var bookAuthorName = stdin.readLineSync();
    bookListInstance.addBookToList(new Book(bookName!, bookAuthorName!));
    sleep(Duration(milliseconds: 1000));
    stdout.writeln("Book Added...\n");
    sleep(Duration(milliseconds: 1000));
    break addBookLoop;
  }
}

void searchBook() {
  var bookListInstance = BookList.getBookListInstance();
  searchBookLoop:
  while (true) {
    clearScreen();
    stdout.writeln("+----------------------------------------+");
    stdout.writeln("|\t\tSearch Book\t\t |");
    stdout.writeln("+----------------------------------------+\n");
    stdout.write(" - Book Name : ");
    String bookName = stdin.readLineSync() as String;
    var searchedBookResult = bookListInstance.findBookByBookName(bookName);
    try {
      var searchedBook = searchedBookResult as Book;
      stdout.writeln("\nBook Found");
      stdout.writeln(" - Book ID : " + searchedBook.getBookId().toString());
      stdout.writeln(" - Book Name : " + searchedBook.getName());
      stdout.writeln(" - Author Name : " + searchedBook.getAuthorName());
      sleep(Duration(seconds: 5));
    } catch (e) {
      stdout.writeln("Invalid Book Name");
      sleep(Duration(seconds: 1));
    }
    break searchBookLoop;
  }
}

void showBookList() {
  var bookListInstance = BookList.getBookListInstance();
  showBookListLoop:
  while (true) {
    clearScreen();
    stdout.writeln("+-------------------------------------------------------+");
    stdout.writeln("|\t\t\tBook List\t\t\t|");
    stdout.writeln("+-------------------------------------------------------+");
    stdout.writeln("|  Book ID\t|  Book Name\t|  Book Aurthor Name\t|");
    stdout.writeln("+-------------------------------------------------------+");
    bookListInstance.getBookList().forEach((book) {
      stdout.writeln(
          "|  ${book.getBookId()}\t\t|  ${book.getName()}\t|  ${book.getAuthorName()}\t|");
      stdout
          .writeln("+-------------------------------------------------------+");
    });
    stdout.write("\nPress any key to go back : ");
    stdin.readLineSync();
    break showBookListLoop;
  }
}

void editBook() {
  var bookListInstance = BookList.getBookListInstance();
  editBookLoop:
  while (true) {
    clearScreen();
    stdout.writeln("+----------------------------------------+");
    stdout.writeln("|\t\tEdit Book\t\t |");
    stdout.writeln("+----------------------------------------+\n");
    stdout.write(" - Book Name : ");
    String bookName = stdin.readLineSync() as String;
    var searchedBookResult = bookListInstance.findBookByBookName(bookName);
    try {
      var searchedBook = searchedBookResult as Book;
      stdout.writeln("\nBook Found");
      stdout.writeln(" - Book ID : " + searchedBook.getBookId().toString());
      stdout.writeln(" - Book Name : " + searchedBook.getName());
      stdout.writeln(" - Author Name : " + searchedBook.getAuthorName());
      stdout.writeln("\n 1 - Change Book Name ");
      stdout.writeln(" 2 - Change Author Name ");
      stdout.writeln(" 3 - Change both ");
      stdout.write("\nSelect Option :  ");
      String editChoice = stdin.readLineSync() as String;
      switch (editChoice) {
        case "1":
          stdout.write("\n\t >> Enter New Book Name : ");
          searchedBook.setBookName(stdin.readLineSync() as String);
          break;
        case "2":
          stdout.write("\n\t >> Enter New Author Name : ");
          searchedBook.setBookAuthorName(stdin.readLineSync() as String);
          break;
        case "3":
          stdout.write("\n\t >> Enter New Book Name : ");
          searchedBook.setBookName(stdin.readLineSync() as String);
          stdout.writeln();
          stdout.write("\n\t >> Enter New Author Name : ");
          searchedBook.setBookAuthorName(stdin.readLineSync() as String);
          break;
        default:
          break editBookLoop;
      }
    } catch (e) {
      stdout.writeln("Invalid Book Name");
      sleep(Duration(seconds: 1));
    }
    break editBookLoop;
  }
}

void deleteBook() {
  var bookListInstance = BookList.getBookListInstance();
  deleteBookLoop:
  while (true) {
    clearScreen();
    stdout.writeln("+----------------------------------------+");
    stdout.writeln("|\t\tSearch Book\t\t |");
    stdout.writeln("+----------------------------------------+\n");
    stdout.write(" - Book Name : ");
    String bookName = stdin.readLineSync() as String;
    var searchedBookResult = bookListInstance.findBookByBookName(bookName);
    try {
      var searchedBook = searchedBookResult as Book;
      stdout.writeln("\nBook Found");
      stdout.writeln(" - Book ID : " + searchedBook.getBookId().toString());
      stdout.writeln(" - Book Name : " + searchedBook.getName());
      stdout.writeln(" - Author Name : " + searchedBook.getAuthorName());
      stdout.write("\n - Delete (Y/N) : ");
      String deleteChoice = stdin.readLineSync() as String;
      if (deleteChoice.toLowerCase() == "y") {
        bookListInstance.deleteBook(searchedBook);
      }
    } catch (e) {
      stdout.writeln("Invalid Book Name");
      sleep(Duration(seconds: 1));
    }
    break deleteBookLoop;
  }
}

void clearScreen() {
  stdout.write('\x1B[2J\x1B[0;0H');
}

num validateOptionInput(num start, num end, String input, String errorMsg) {
  num selectedOption = -1;
  try {
    selectedOption = int.parse(input);
    if (selectedOption < start || selectedOption > end) {
      stdout.writeln(errorMsg);
      sleep(Duration(milliseconds: 1000));
    }
  } catch (e) {
    stdout.writeln(errorMsg);
    sleep(Duration(milliseconds: 1000));
  }
  return selectedOption;
}

class Book {
  late num bookId;
  late String name;
  late String authorName;

  Book(String name, String authorName) {
    this.name = name;
    this.authorName = authorName;
  }
  void setBookId(num bookId) {
    this.bookId = bookId;
  }

  void setBookName(String bookName) {
    this.name = bookName;
  }

  void setBookAuthorName(String authorName) {
    this.authorName = authorName;
  }

  String getName() {
    return this.name;
  }

  num getBookId() {
    return this.bookId;
  }

  String getAuthorName() {
    return this.authorName;
  }

  String toString() {
    return this.bookId.toString() + " - " + this.name + " - " + this.authorName;
  }
}

class BookList {
  static List<Book> bookList = [];
  static BookList instance = new BookList();

  static BookList getBookListInstance() {
    return instance;
  }

  Book? findBookByBookName(String bookName) {
    Book? searchedBook = null;
    bookList.forEach((book) {
      if (book.getName() == bookName) {
        searchedBook = book;
      }
    });
    sleep(Duration(seconds: 2));
    return searchedBook;
  }

  void deleteBook(Book book) {
    var remove = bookList.remove(book);
    print(remove);
  }

  void addBookToList(Book book) {
    book.setBookId(bookList.length + 1);
    bookList.add(book);
  }

  List<Book> getBookList() {
    return bookList;
  }

  int getNextBookId() {
    return bookList.length + 1;
  }
}
