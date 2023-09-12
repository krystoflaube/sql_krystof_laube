/*1. Procedure to quickly display all the tables of the database:*/
create proc overview
as
select * from products.albums
select * from products.bands
select * from sales.stock
select * from sales.employees
select * from sales.orders
select * from sales.order_items

exec overview

/*2. This query lists all the rock albums and their bands from the most recent to the most ancient*/
select album_name as 'rock album', band_name, album_release from products.albums 
inner join products.bands on products.albums.band_id = products.bands.band_id 
where products.bands.band_genre like 'rock'
order by album_release desc

/*3. This query creates a view listing the number of albums in stock by bands*/
create view  stock_bands as 
select band_name, sum(in_stock) as 'albums in stock' from sales.stock
left join products.albums on sales.stock.album_id = products.albums.album_id
left join products.bands on products.albums.band_id = products.bands.band_id
group by band_name
select * from stock_bands

/*4. This query lists the three most sold albums (with ties).*/
select top (3) with ties album_name, sum(quantity) as 'albums_sold' from sales.order_items
left join products.albums on products.albums.album_id = sales.order_items.album_id
group by album_name
order by 2 desc
 
/*5.The list of bands that publish an album in the 70es.*/
select band_name from products.bands where band_id in 
(select band_id from products.albums where album_release between 1970 and 1979)

/*6. This query looks for bands that sell their albums on averge at least for 11 euros.*/
select band_name , avg(price)as average_price from products.bands a
join products.albums b on a.band_id = b.band_id
group by band_name
having avg(price) >11

/*7. This query creates a view that evaluates the difference between the order and shipping dates and adds a note.*/
create view shipping as 
select order_id ,datediff(day,ordered, shipped ) as 'shipping delay',
case when datediff(day,ordered, shipped ) > 10 then 'send a promotion code !' when datediff(day,ordered, shipped )< 5 then 'bravo ' else '' end as note 
from sales.orders
select * from shipping

/*8. This query creates a view with average delays in shipping per employee*/
create view average_shipping_delay as 
select name, avg(datediff(day, ordered,shipped))as 'average shipping delay' from sales.orders a
join sales.employees b on a.employee_id = b.employee_id where shipped is not null
group by name

select * from average_shipping_delay

/*9.This creates a procedure to inspect the shipments by employee*/
create proc order_by_employee (@a as int) as
begin 
select * from sales.orders where employee_id = @a
end
exec order_by_employee 2

