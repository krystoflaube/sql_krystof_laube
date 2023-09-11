create database musicshop

create schema products

create table products.bands (
band_id int IDENTITY(2,2) PRIMARY KEY not null, 
band_name varchar (255) not null , 
band_genre varchar(255), 
band_frontman varchar (255), 
band_notes varchar(max)
)
insert into products.bands
values 
('Led Zeppelin', 'rock', 'Robert Plant', 'Jimmy Page can be considered as a frontman'),
('Beethoven', 'classic', null, null),
('Abba', 'pop', null, null),
('Black Sabbath', 'rock', 'Ozzy Osbourne', null),
('Dvorak', 'classic', null, 'Vltava is from Smetana!'),
( 'Jethro Tull', 'rock', 'Ian Anderson', null), 
('Madonna', 'pop', 'Madonna', null), 
('Deep purple', 'rock', null, null), 
('Uriah heep', 'rock', null, null), 
('Edward Grieg','classic', null, null)

create table products.albums (
album_id int IDENTITY(1,2) PRIMARY KEY not null, 
album_name varchar(255) not null, price smallmoney,
band_id int not null, 
album_release smallint,  
album_notes varchar(max) 

foreign key (band_id) references products.bands(band_id)
)

insert into products.albums
values 
('Led zeppelin II',13, 2, 1969, null),
('Led zeppelin I', 11.60, 2, 1969, 'The album reached number 10 on the Billboard chart.'),
('Symphony n. 9',10.99, 4 , 1957, 'Premiered in 1824, the recording is by Otto Klemperer'),
('Waterloo',10.99, 6, 1974, null),
('Salisbury', 10.99, 18, 1971, null),
('Retrun to fantasy',12.60, 18, 1975, null),
('Paranoid',8.50, 8, 1970, null),
('Born again',12,8, 1983, 'recorded with Ian Gillan from Deep Purple, no Ozzy'),
('Technical Ecstasy',9.99, 8, 1976, null),
('Aqualung', 10.99, 12, 1971, 'the band most popular album'),
('Thick as a Brick',9.35, 12, 1972, null),
('Like a Virgin',10.99, 14, 1984, null),
('From the new World',10.99, 10, 2008, 'it is dvorak 9th symphony'),
('Bananas',9.85, 16, 2003, null),
('Come taste the band',10.99, 16, 1975, null)

Create schema sales
create table sales.stock (album_id int not null, in_stock int, foreign key (album_id) references products.albums (album_id))
insert into sales.stock 
values (1,55), (3,98), (5, 5), (7,13), (9, 4 ), (11, 2), (13,8) , (15, 6) , (17, 55) , (19,18), (21,25), (23,4) , (25,0), (27,4),(29,30)

create table sales.employees (employee_id int identity not null primary key, name varchar(255))
insert into sales.employees
values ('Jan Přibyl'), ('Jana Novotná'), ('František Mrázek')

create table sales.orders (order_id int not null identity primary key, order_status tinyint, ordered date, shipped date, employee_id int,
foreign key (employee_id) references sales.employees (employee_id))

insert into sales.orders
values (3, '20220106', '20220116', 1), (3, '20220108', '20220117', 2), (3, '20220124', '20220201', 3), (3, '20220202', '20220214', 2),
(3, '20220216', '20220223', 2), (3, '20220306', '20220312', 2), (3, '20220308', '20220312', 2), (3, '20220315', '20220327', 2), 
(3, '20220402', '20220409', 1), (3, '20220405', '20220407', 3), (3, '20220416', '20220422', 1), (3, '20220420', '20220426', 2), 
(3, '20220425', '20220430', 1), (3, '20220506', '20220509', 3), (2, '20220508', null, 2), (1, '20220518', null, null)


create table sales.order_items (order_id int foreign key references sales.orders (order_id), 
album_id int foreign key references products.albums (album_id) , price smallmoney, quantity smallint)

insert into sales.order_items
values (1, 25, 10.99, 1),(1, 27, 10.99, 1),(1, 15, 10.99, 1),(2, 19, 10.99, 1),(2, 15, 10.99, 1),(3, 1, 10.99, 2),(4, 3, 10.99, 1),(5, 21, 10.99, 1),(5, 15, 10.99, 1),
(6, 5, 10.99, 3),(7, 9, 10.99, 1),(7, 29, 10.99, 1),(8, 21, 10.99, 1),(8, 25, 10.99, 1),
(9, 17, 10.99, 1),(10, 17, 10.99, 1),(11, 1, 10.99, 2),(12, 3, 10.99, 1),(12, 23, 10.99, 1),
(13, 21, 10.99, 12),(13, 15, 10.99, 1),(13, 27, 10.99, 1),(13, 7, 10.99, 2),(14, 19, 10.99, 1),
(14, 17, 10.99, 1),(15, 17, 10.99, 1),(16, 21, 10.99, 1),(16, 15, 10.99, 1)




