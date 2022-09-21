-- criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;


-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;

-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(30) not null,
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null, 
    avaliação float default 0,
    size varchar(10) -- size equivale a dimensão do produto
);

alter table product modify Pname varchar(30);

-- para ser cont no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no esquema relacional
-- criar constraints relacionadas ao pagamento

-- criar tabela pagamentos
create table payments(
	idPayClient int,
    idPayment int,
    typePayment enum('Pix', 'Cartão de Crédito', 'Cartão de Débito'),
    limitAvaiable float,
    primary key (idPayClient, idPayment),
    constraint fk_payments_client foreign key (idPayClient) references clients (idClient)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
	orderStatus enum('Cancelado', 'Confirmado', 'Em Processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    -- idPayment  (aceitar q seja null, da mesma forma de gerente, foreign key
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

alter table orders add column idOPayment int; 

-- criar tabela estoque
create table productStorage (
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- dica desafio: criar uma generalização de pessoa júridica para supllier e seller
-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(14) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(14),
    CPF char(11),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- criar tabela produto/vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
desc productSeller;

-- criar tabela produto/pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOProduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- criar tabela local da loja
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- criar tabela produto/fornecedor
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);
alter table productSupplier add column quantity int;

-- criar tabela entrega
create table delivery(
	idDelivery int,
    idDelOrder int,
    statusDelivery boolean default false,
    codDelivery char(5),
    primary key (idDelivery, idDelOrder),
    constraint fk_delivery_order foreign key (idDelOrder) references orders (idOrder)
);

desc delivery;
alter table delivery modify column statusDelivery boolean default false;


show databases;
show tables;
use information_schema;
desc REFERENTIAL_CONSTRAINTS;
select * from REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = 'ecommerce';