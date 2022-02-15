-- Movie_Theater_DB --
-- ALTER TABLE 'theater' to remove Foreign Keys
alter table theater
	drop column auditorium_id,
	drop column concession_id;

-- ALTER TABLE 'theater' to add a new column
alter table theater
	add theater_name VARCHAR(50),
	add auditorium1 INTEGER not null default 0,
	add	auditorium2 INTEGER not null default 0,
	add	auditorium3 INTEGER not null default 0,
	add	auditorium4 INTEGER not null default 0,
	add	auditorium5 INTEGER not null default 0;

alter table theater  
	add foreign key (auditorium1) references auditorium(auditorium_id),
	add foreign key (auditorium2) references auditorium(auditorium_id),
	add foreign key (auditorium3) references auditorium(auditorium_id),
	add foreign key (auditorium4) references auditorium(auditorium_id),
	add foreign key (auditorium5) references auditorium(auditorium_id);
	
-- ALTER TABLE 	'concessions' to remove PK 'concession_id'
alter table concessions 
	drop column concession_id;
	
-- ALTER TABLE 'concessions' to modify prod_id column to primary key
alter table concessions 
	add primary key (prod_id);

-- ALTER TABLE 'reservation_hdr' to add 1 column
alter table reservation_hdr  
	add purchase_method VARCHAR(10),
	add theater_id INTEGER;
alter table reservation_hdr  
	add foreign key (theater_id) references theater(theater_id);

-- ALTER TABLE 'reservation_hdr' to remove 1 column
alter table reservation_hdr  
	drop movie_id;

-- ALTER TABLE 'sales'
alter table sales 
	add reservation_no INTEGER;
alter table sales
	add foreign key (reservation_no) references sales(reservation_no);

-- ALTER TABLE 'payments' to remove it
drop table payments;

-- CREATE TABLE 'payment_dtl' to replace 'payments' TABLE.
create table payment_dtl (
	dtl_id SERIAL not null primary key,
	payment_num INTEGER not null,
	trans_date DATE not null ,
	dtl_payment NUMERIC(8,2) not null,
	payment_date DATE not null,
	payment_method VARCHAR(10) not null,
	item_no VARCHAR(10),
	item_type VARCHAR(12),
	sales_no VARCHAR(10),
		foreign key (sales_no) references sales(sales_no)
);
