-- Movie_Theater_DB --
-- Create Empty Tables --
create table auditorium (
	auditorium_id SERIAL not null primary key,
	auditorium_name VARCHAR(30),
	auditorium_type VARCHAR(30)
);

create table customer (
	cust_id SERIAL not null primary key,
	first_name	VARCHAR(50),
	last_name VARCHAR(50),
	address VARCHAR(150),
	city VARCHAR(50),
	state VARCHAR(50)
);

create table ratings (
	rating_id SERIAL not null primary key,
	rating_desc VARCHAR(50)
);

create table genre (
	genre_id SERIAL not null primary key,
	genre_desc VARCHAR(50)
);

create table concessions (
	concession_id SERIAL not null primary key,
	prod_id VARCHAR(10),
	prod_name VARCHAR(50),
	prod_price NUMERIC(8,2) not null
);

create table theater (
	theater_id SERIAL not null primary key,
	location_id INTEGER not null,
	city VARCHAR(20),
	state VARCHAR(20),
	auditorium_id INTEGER not null,
		foreign key(auditorium_id) references auditorium(auditorium_id),
	concession_id INTEGER not null,
		foreign key(concession_id) references concessions(concession_id)
);

create table movies (
	movie_id SERIAL not null primary key,
	movie_title VARCHAR(200),
	release_date DATE,
	auditorium_id INTEGER not null,
		foreign key(auditorium_id) references auditorium(auditorium_id),
	theater_id INTEGER not null,
		foreign key(theater_id) references theater(theater_id),
	genre_id INTEGER not null,
		foreign key(genre_id) references genre(genre_id),
	rating_id INTEGER not null,
		foreign key(rating_id) references ratings(rating_id)
);

create table showing_schedule (
	sched_id SERIAL not null primary key,
	showing_date DATE,
	showing_time TIME,
	auditorium_id INTEGER not null,
		foreign key(auditorium_id) references auditorium(auditorium_id),
	theater_id INTEGER not null,
		foreign key(theater_id) references theater(theater_id),
	movie_id INTEGER not null,
		foreign key(movie_id) references movies(movie_id)
);

create table production_crew (
	crew_id SERIAL not null primary key,
	crew_fname VARCHAR(30),
	crew_lname VARCHAR(30),
	job_desc VARCHAR(100),
	movie_id INTEGER not null,
		foreign key(movie_id) references movies(movie_id)
);

create table movie_cast (
	actor_id SERIAL not null primary key,
	f_name VARCHAR(50),
	l_name VARCHAR(50),
	gender VARCHAR(1),
	DOB DATE,
	role_char VARCHAR(50),
	movie_id INTEGER not null,
		foreign key(movie_id) references movies(movie_id)
);

create table reservation_hdr (
	reservation_no SERIAL not null primary key,
	reservation_date DATE,
	total_tickets INTEGER not null,
	total_charge NUMERIC(8,2) not null,
	total_paid NUMERIC(8,2) not null,
	status VARCHAR(10),
	reservation_type VARCHAR(10),
	cust_id INTEGER not null,
		foreign key (cust_id) references customer(cust_id),
	movie_id INTEGER not null,
		foreign key(movie_id) references movies(movie_id)
);

create table reservation_dtl (
	ticket_num VARCHAR(10) primary key,
	price NUMERIC(8,2) not null,
	reservation_no INTEGER not null,
		foreign key (reservation_no) references reservation_hdr(reservation_no),
	movie_id INTEGER not null,
		foreign key(movie_id) references movies(movie_id)	
	show_date DATE,
	show_time TIME,
	auditorium_id INTEGER not null,
		foreign key(auditorium_id) references auditorium(auditorium_id)
);

-- alter concessions table to make the (product id) column values unique: 
alter table concessions
	add constraint concession_id unique (prod_id);

-- The above SQL Statement designed to resolve a constraint error below with the concessions table:
create table sales (
	sales_no VARCHAR(10) primary key,
	trans_date DATE,
	item_no VARCHAR(10)
	item_type VARCHAR(10)
	charge_amt NUMERIC(8,2) not null,
	cust_id INTEGER not null,	
		foreign key (cust_id) references customer(cust_id),
	theater_id INTEGER not null,
		foreign key(theater_id) references theater(theater_id)
);

create table payments (
	trans_id VARCHAR(10) primary key,
	payment_date DATE,
	amount_paid NUMERIC(8,2) not null,
	payment_method VARCHAR(10),
	sales_no VARCHAR(10),
		foreign key (sales_no) references sales(sales_no)
);

