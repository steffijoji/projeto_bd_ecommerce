use ecommerce;
show tables;


insert into Clients (Fname, Minit, Lname, CPF, Address)
	values ('Maria', 'M', 'Silva', '69639457051', 'Av José Alves 345 Salvador/BA'),
			('Kevin', 'B', 'Gonçalves', '15365760930', 'R Arlindo 36 Natal/RN'),
            ('Isabella', 'P', 'Sebastiana', '12875328964', 'Rua Camaipi 3223 - Itabuna BA'),
            ('Victor', 'L', 'Arthur', '52820435998', 'Bento XVI 5 Rio de Janeiro/RJ'),
            ('Emilly', 'M', 'Levi', '03569360903', 'R Portela 18 - São Paulo SP'),
            ('Giovanni', 'E', 'Nascimento', '39644506936', 'Quadra 806 - Palmas TO');

insert into product(Pname, classification_kids, category, avaliação, size) values
						('Fone de Ouvido', false, 'Eletrônico', '4', null),
                        ('Barbie Elsa', true, 'Brinquedos', '3', null),
                        ('Body Carters', false, 'Vestimenta', '5', null),
                        ('Microfone Vedo', false, 'Eletrônico', '4', null),
                        ('Sofá retrpatil', false, 'Móveis', '3', '3x57x80'),
                        ('Farinha de arroz', false, 'Alimentos', '2', null);

insert into orders(idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
						(1, 37, default, 'compra via aplicativo', null, 1),
                        (2, 38, default, 'compra via aplicativo', 50, 0),
                        (3, 39, 'Confirmado', null, null, 1),
                        (4, 40, default, 'compra via web site', 150, 0);
                 
select * from orders;
update orders set idOPayment = 3 where idOrder = 12;

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						(1,1,2, null),
                        (2,1,1, null),
                        (3,2,1, null);
                        					
insert into productStorage (storageLocation, quantity) values
						('Rio de Janeiro', 1000),
                        ('Rio de Janeiro', 500),
                        ('São Paulo', 10),
                        ('Salvador', 100),
                        ('Belo Horizonte', 10),
                        ('São Paulo', 60);

insert into storageLocation (idLproduct, idLstorage, location) values
						(1, 2, 'RJ'),
                        (2, 6, 'GO');
                        
insert into supplier(SocialName, CNPJ, contact) values
						('Almeida e Filhos', 95508897000175, '9550889700'),
                        ('Eletrônicos Silva', 63842794000150, '9550884568'),
                        ('Eletrônicos Valma', 25415590000144, '1234598526');
                        
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						(1, 1, 500),
                        (1, 2, 400),
                        (2, 4, 633),
                        (3, 3, 5),
                        (2, 5, 10);

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
						('Tech Eletronics', null, 25415590000144, 25415590000, 'Rio de Janeiro', 9995632450 ),
                        ('Boutique Durgas', null, null, 92406715007, 'Rio de Janeiro', 9240671500),
                        ('Kids World', null, 12019880000127, null, 'São Paulo', 1201988000);
                        
insert into productSeller (idPseller, idPproduct, prodQuantity) values
						(1, 6, 80),
                        (2, 5, 10);
                        
insert into payments (idPayClient, idPayment, typePayment, limitAvaiable) values
						(37, 1, 'Pix', 1000),
                        (40, 2, 'Cartão de Crédito', 5000),
                        (42, 3, 'Cartão de Débito', 4000);
                        
insert into delivery (idDelivery, idDelOrder, statusDelivery, codDelivery) values
						(1, 4, true, '55555'),
                        (2, 1, true, '12345'),
                        (3, 10, false, null);

-- querys
--
--
-- Relação de Cliente, Status do Pedido e Código de Entrega
select idClient id, concat(Fname, ' ', Lname) Client, orderStatus Order_status, codDelivery Delivery_code from clients
			inner join orders on idClient = idOrderClient
            inner join delivery on idOrder = idDelOrder;
            
-- Algum vendedor também é fornecedor?
select se.idSeller as id, se.SocialName as Seller_SocialName, su.SocialName as Supplier_SocialName from seller se, supplier su
			where idSupplier = idSeller
            order by Seller_SocialName;
            
-- Verdadeiro se o vendedor também é fornecedor:
select se.SocialName, su.SocialName, 
			case when se.idSeller = su.idSupplier then 'True'
			else 'False'
			end as 'Its_the_same'
            from seller se, supplier su;
            
-- Relação de produtos, fornecedores e estoques
select Pname as Product, SocialName as Supplier, quantity as Quantity_in_stock from product
			inner join supplier on idProduct = idSupplier
            inner join productSupplier on idSupplier = idPsSupplier;

-- Fornecedores fornecem quais produtos?
select SocialName as Supplier_name, Pname as Product, category as Product_type from supplier
			inner join product on idSupplier = idProduct
            order by Supplier_name asc, Product asc;
            
-- Quais cliente não possuem forma de pagamento cadastradas?
select Fname Client, CPF, Address, typePayment from clients
			left outer join payments
            on idClient = idPayClient
            where idPayClient is null;

-- Quantidade de produtos em estoque maiores que 100
select * from productstorage
			group by quantity
            having (quantity) > 100;
            
-- Quantidade de pedidos por cliente      
select c.idCLient, Fname, count(*) as Number_of_orders from clients c 
			inner join orders o on c.idClient = o.idOrderClient
			inner join productOrder p on p.idPOorder = o.idOrder;
            
-- Quantidade de Produtos por Categoria
select category, count(*) as Number_of_products from product
group by category;

-- querys de ajuda para conferência de dados:
show tables;
desc product;
select * from supplier;
select * from clients, orders where idClient = idOrderClient;










            



        







                        