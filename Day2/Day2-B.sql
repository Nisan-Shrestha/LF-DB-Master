create table
    publishers (publisher_id int primary key, publisher_name varchar(100), country varchar(50));

create table
    books (book_id int primary key, title Varchar(100), genre varchar(50), publisher_id int, publication_year date, foreign key (publisher_id) references publishers (publisher_id));

create table
    customers (customer_id int primary key, customer_name varchar(50) not null, email varchar(150) unique, address varchar(50));

create table
    authors (author_id int primary key, author_name varchar(50) not null, birth_date date, nationality varchar(50));

create table
    orders (order_id int primary key, order_date date default current_date, customer_id int, total_amount int default 1, foreign key (customer_id) references customers (customer_id));

create table
    book_authors (book_id int, author_id int, primary key (book_id, author_id), foreign key (book_id) references books (book_id), foreign key (author_id) references authors (author_id));

create table
    order_items (order_id int, book_id int, primary key (order_id, book_id), foreign key (book_id) references books (book_id), foreign key (order_id) references orders (order_id));