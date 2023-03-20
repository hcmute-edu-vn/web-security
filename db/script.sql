
DROP DATABASE IF EXISTS TFcT8GlodF;
CREATE DATABASE TFcT8GlodF;
use TFcT8GlodF;


-- Create tables 
create table ProductTypes (
    type_id char(10) primary key,
    type_name varchar(50) not null 
);

create table Categories (
    category_id char(10) primary key,
    category_name varchar(255) not null,
    product_type char(10),
    -- ProductTypes vs Categories
    constraint fk_categories_product_type
    foreign key (product_type) 
    references ProductTypes(type_id)
    on delete set null
    on update cascade
);

create table Colors (
    color_id char(10) primary key,
    color_name varchar(255) not null
);

create table Sizes (
    size_id char(10) primary key, 
    size_name varchar(255) not null
);

create table Roles (
    role_id char(10) primary key,
    role_name varchar(255) not null
);

insert into Roles
values('ROL0', N'Tất cả');
insert into Roles
values('ROL1', N'Khách hàng');
insert into Roles
values('ROL2', N'Quản trị viên');
insert into Roles
values('ROL3', N'Nhân viên');

create table Products (
    product_id char(10) primary key,
    product_type char(10), 
    product_name varchar(255) not null,
    old_price int not null,
    new_price int not null,
    main_image_url text not null,
    `description` text, 
    meterial varchar(255), 
    origin varchar(255), 
    pattern varchar(255), 
    is_active bit not null default 0, 
    is_delete bit not null default 0,
    category_id char(10),
    -- Add constraint  Products vs Categories
    constraint fk_product_category_id 
    foreign key (category_id)
    REFERENCES `Categories`(category_id) 
    on delete set null
    on update cascade,
    
    -- ProductTypes vs Products
    constraint fk_product_product_type
    foreign key (product_type) 
    references ProductTypes(type_id)
    on delete set null
    on update cascade
);
 
create table ProductImages (
    image_id char(10) primary key,
    image_url text not null,
    product_id char(10),
     -- Add constraint Products vs ProductImages
    constraint fk_product_product_id
    foreign key (product_id)
    REFERENCES `Products`(product_id) 
    on delete set null
    on update cascade
);

create table `Options`(
    option_id char(10) primary key,
    available_quantity int not null,
    product_id char(10), 
    color_id char(10), 
    size_id char(10),
    -- Add constraint Products vs Options
    constraint fk_option_product_id
    foreign key (product_id)
    REFERENCES `Products`(product_id) 
    on delete set null
    on update cascade,
    
    -- Colors vs Options
    constraint fk_option_color_id
    foreign key (color_id) 
    references `Colors`(color_id)
    on delete set null
    on update cascade,
    
    -- Sizes vs Options
    constraint fk_option_size_id
    foreign key (size_id) 
    references `Sizes`(size_id)
    on delete set null
    on update cascade
);

create table Users (
    user_id char(10) primary key,
    email char(255) not null unique, 
    `password` char(255) not null, 
    fullname varchar(50) not null, 
    address varchar(255) not null, 
    phonenumber char(10) not null, 
    is_active_acc bit not null default(0), 
    is_delete_acc bit not null default(0),
     `code` char(10) DEFAULT NULL,
    role_id char(10),
    
    -- Roles vs Users
    constraint fk_user_role_id
    foreign key (role_id) 
    references `Roles`(role_id)
    on delete set null
    on update cascade
);

create table Bills (
    bill_id char(10) primary key,
    `date` datetime not null, 
    total_price int not null,  
    status_bill bit default 0,
    user_id char(10),
    -- Users vs Bills
    constraint fk_bill_user_id
    foreign key (user_id) 
    references `Users`(user_id)
    on delete set null
    on update cascade
);

create table Orders (
    order_id char(10) primary key, 
    `date` datetime not null, 
    ordered_quantity int not null, 
    price int not null,
    bill_id char(10),
    option_id char(10),
    
    -- Bills vs Orders
    constraint fk_order_bill_id
    foreign key (bill_id) 
    references Bills(bill_id)
    on delete set null
    on update cascade,
    
    -- Options vs Orders
    constraint fk_order_option_id
    foreign key (option_id) 
    references `Options`(option_id)
    on delete set null
    on update cascade
);

-- insert user admin
insert into `Users`
values('U0001', 'admin1@gmail.com', '12345', 'Admin 1', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL2');
insert into `Users`
values('U0002', 'admin2@gmail.com', '12345', 'Admin 2', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL2');
insert into `Users`
values('U0003', 'admin3@gmail.com', '12345', 'Admin 3', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL2');
insert into `Users`
values('U0004', 'admin4@gmail.com', '12345', 'Admin 4', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL2');

-- insert user employee
insert into `Users`
values('U1011', 'employee1@gmail.com', '12345', 'Nhân viên 1', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1012', 'employee2@gmail.com', '12345', 'Nhân viên 2', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1013', 'employee3@gmail.com', '12345', 'Nhân viên 2', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1014', 'employee4@gmail.com', '12345', 'Nhân viên 4', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1015', 'employee5@gmail.com', '12345', 'Nhân viên 5', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1016', 'employee6@gmail.com', '12346', 'Nhân viên 6', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1017', 'employee7@gmail.com', '12345', 'Nhân viên 7', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1018', 'employee8@gmail.com', '12345', 'Nhân viên 8', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1019', 'employee9@gmail.com', '12345', 'Nhân viên 9', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1020', 'employee10@gmail.com', '12345', 'Nhân viên 10', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');
insert into `Users`
values('U1021', 'employee11@gmail.com', '12345', 'Nhân viên 11', 'Đăk Nông', '0123456798', 0, 0, '123456', 'ROL3');




-- -- insert user customer
insert into `Users`
values('U2011', 'doduongthaituan@gmail.com', '12345', 'Đỗ Dương Thái Tuấn', 'Hà Nội', '0987654321', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2012', 'phamnguyennhuttruong@gmail.com', '12345', 'Phạm Nguyễn Nhựt Trường', 'Hà Nội', '0123456789', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2013', 'buthanhduy@gmail.com', '12345', 'Bùi Thanh Duy', 'Phú Yên', '0123456798', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2014', 'vuhoanganh@gmail.com', '12345', 'Vũ Hoàng Anh', 'Đồng Nai', '0123456798', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2015', 'tranchimy@gmail.com', '12345', 'Trần Chí Mỹ', 'Bình Thuận', '0345698710', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2016', 'nguyenducanh@gmail.com', '12345', 'Nguyễn Đức Anh', 'Quảng Nam', '0123457698', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2017', 'nguyendieulinh@gmail.com', '12345', 'Nguyễn Diệu Linh', 'Bình Phước', '0124356798', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2018', 'lehongnhung@gmail.com', '12345', 'Lê Hồng Nhung', 'Phú Yên', '0213456798', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2019', 'nguyenthihang@gmail.com', '12345', 'Nguyễn Thị Hằng', 'Phú Yên', '0123654798', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2020', 'phungthihau@gmail.com', '12345', 'Phùng Thị Hậu', 'Quảng Bình', '0129866798', 0, 0, '123456', 'ROL1');
insert into `Users`
values('U2021', 'huonglethi@gmail.com', '12345', 'Lê Thị Hương', 'Bến Tre', '0129866798', 0, 0, '123456', 'ROL1');

-- Insert data to ProductTypes Table
INSERT INTO ProductTypes(type_id, type_name)
VALUE ('AO', 'Áo');
INSERT INTO ProductTypes(type_id, type_name)
VALUE ('QUAN', 'Quần');
INSERT INTO ProductTypes(type_id, type_name)
VALUE ('ALL', 'Tất cả');

-- Insert data to Categories Table
-- Áo 
INSERT INTO Categories(category_id, category_name, product_type)
VALUES('AO1', N'Áo sơ mi', 'AO');

INSERT INTO Categories(category_id, category_name, product_type)
VALUES('AO2', N'Áo thun', 'AO');

INSERT INTO Categories(category_id, category_name, product_type)
VALUES('AO3', N'Áo khoác', 'AO');

INSERT INTO Categories(category_id, category_name, product_type)
VALUES('AO4', N'Áo POLO', 'AO');
INSERT INTO Categories(category_id, category_name, product_type)
VALUES('AO5', N'Tất cả lại áo', 'AO');

-- Quần
INSERT INTO Categories(category_id, category_name, product_type)
VALUES('QUAN1', N'Quần Jeans','QUAN');

INSERT INTO Categories(category_id, category_name, product_type)
VALUES('QUAN2', N'Quần tây','QUAN');

INSERT INTO Categories(category_id, category_name, product_type)
VALUES('QUAN3', N'Quần short','QUAN');

INSERT INTO Categories(category_id, category_name, product_type)
VALUES('QUAN4', N'Tất cả loại quần','QUAN');
-- Insert data for product  table
-- shirt
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO01', 'AO', 'CAMERA T-SHIRT/ROSE GREY', 420000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_the_sign-rose_1_8b832848dcbd4de8ba6546e420038f6f_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');
--
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO02', 'AO', 'II UPGRADE PLAY T-SHIRT/RED' , 320000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_1_1a43709e0acd491ab20181841e40b73b_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO03', 'AO', 'OVERALL T-SHIRT/DARK GREEN' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_vv31-grn-1_62dea3a49b124793a4d147b69badba7c_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id,meterial, origin, pattern)
VALUES('PRO04', 'AO', 'UPGRADE PLAY T-SHIRT/RED' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_1_df951b2ad8fd4e2d8d9f1a635a58f6d9_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO05', 'AO', 'UPGRADE PLAY T-SHIRT/BROW' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-brown_1_dea98a74358a4aa383a9b92fbbed1f1a_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO06', 'AO', 'CHILDHOOD T-SHIRT/BLACK' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_blk_1_e3511d22d99d4a999093a4251aa7a04c_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO07', 'AO', 'CHILDHOOD T-SHIRT/WHITE' , 200000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_wht_1_b697e689be0f4fc1b5ced5469025a80c_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO08', 'AO', 'SMILE T-SHIRT/ROSE GREY' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v72-rose_1_2f1495bce99541d794cc225b85b17e82_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO09', 'AO', 'SPLIT T-SHIRT/BLACK' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-net-blk_1_7e0b40d55baf4b8198d43782af84dc04_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO10', 'AO', 'MELTING T-SHIRT/DARK GREEN' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-vv05-grn_1_a1cd9e37283744aeac0729b1ab686351_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO11', 'AO', 'ILLUSION T-SHIRT/DARK RED' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v10_1_55b06c4bcbfc4cfbb42695fe2f58616a_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO12', 'AO', 'FLOWER T-SHIRT/WHITE' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-flower_wht_1_c2392d51f6a94eac9ad16aef5095f1f7_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO13', 'AO', 'ILLUSION T-SHIRT/DARK BROWN' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_brown_2_1072285cd0594283b6e4c0a77958cda8_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO14', 'AO', 'ILLUSION T-SHIRT/DARK GREY' , 300000, 69000, 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_grey_2_9db2b338764c48c38340daaf14cf8180_large.jpg', 'AO2', 'PREMIUM COTTON', 'VIETNAM', 'IN LỤA U.S.A INK');

-- INSERT SHIRTS DATA
--
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO15','AO' , 'MULTICOLOL BASIC SHIRT/GREY', 250000,150000, 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-grey_1_1367c9fa2d6f493eb96f3c10c14fc060_large.jpg', 'AO1', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO16','AO' , 'MULTICOLOL BASIC SHIRT/DARK GREEN', 250000,150000, 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-green_1_58611e2946ef4a5d8efb68e3f06923a9_large.jpg', 'AO1', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO17','AO' , 'MULTICOLOL BASIC SHIRT/BLACK', 250000,150000, 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-blk_1_a026d1578b114bb48f5de06dc41ca8c7_large.jpg', 'AO1', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO18','AO' , 'MULTICOLOL BASIC SHIRT/WHITE', 250000,150000, 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-wht_1_b9a2bbc4f55942f38c225b6b27d94ebb_large.jpg', 'AO1', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO19','AO' , 'MULTICOLOL BASIC SHIRT/DARK RED', 250000,150000, 'https://product.hstatic.net/200000305259/product/shirt_logo_tpr-red_1_2001a9632dab42dfa5aa5cd133af6653_large.jpg', 'AO1', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO20','AO' , 'MULTICOLOL BASIC SHIRT/BEGEI', 250000,150000, 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-beige_1_dd667357619c496599f077be2469272b_large.jpg', 'AO1', 'COTTON','VETNAM', 'NONE');

-- INSERT POLO DATA
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO21','AO' , 'SMALL SIGNATURE POLO/DARK GREEN', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_green_1_cc7ed12f32c24c98a9fcf72076b9ecde_large.jpg', 'AO4', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO22','AO' , 'SMALL SIGNATURE POLO/BLACK', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_1_b021a20669774f9dab37bc437dbd8567_large.jpg', 'AO4', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO23','AO' , 'SMALL SIGNATURE POLO/BLACK', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_1_b021a20669774f9dab37bc437dbd8567_large.jpg', 'AO4', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO24','AO' , 'SMALL SIGNATURE POLO/BLACK', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_1_b021a20669774f9dab37bc437dbd8567_large.jpg', 'AO4', 'COTTON','VETNAM', 'NONE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO25','AO' , 'SMALL SIGNATURE POLO/BLACK', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_1_b021a20669774f9dab37bc437dbd8567_large.jpg', 'AO4', 'COTTON','VETNAM', 'NONE');

-- INSERT DATA JACKET
--
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO26','AO' , 'COAT JACKET/BEGEI', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_brown_1_251a24c599d44dd4a1a76126865fe035_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO27','AO' , 'COAT JACKET/BLACK', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_blk_1_14de2dfa7b4242319fdd519cade253e7_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO28','AO' , 'COAT JACKET/DARK GREEN', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_green_1_e1bc57dc5e274f479e4d86b199203b7c_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO29','AO' , 'COAT JACKET/GREY', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_grey_1_1d50e821bd31422182bf78c70b7a54b7_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO30','AO' , 'COAT JACKET/MINT', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_mint_1_544dd39f4a794b1fa18a79f59cfdad4c_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO31','AO' , 'COAT JACKET/PINK', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_org_pnk_1_cfe638f2fb4e41fe806fbd316e2868c2_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO32','AO' , 'COAT JACKET/WHITE', 500000,299000, 'https://product.hstatic.net/200000305259/product/vgc-mockup_jacket_wht_1_5d97fef01bb040fb8352149d624a97fc_large.jpg', 'AO3', 'POLY','VETNAM', 'LOGO RUBBER SIGNATURE');

-- INSERT DATA SHORT
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO33','QUAN' , 'ESSENTIAL SHORT/BEGEI', 300000, 200000, 'https://product.hstatic.net/200000305259/product/vgc-short_pants-brown_1_17cfb2f161334beb847f785cb17d66e8_large.jpg', 'QUAN3', 'FRENCH TERRY COTTON','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO34','QUAN' , 'ESSENTIAL SHORT/BLACK', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-pant_blk_1_c1c1a72179fb46e4b8b9f5d6fa97cf40_large.jpg', 'QUAN3', 'FRENCH TERRY COTTON','VETNAM', 'LOGO RUBBER SIGNATURE');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO35','QUAN' , 'ESSENTIAL SHORT/GREY', 300000,200000, 'https://product.hstatic.net/200000305259/product/vgc-short_pants-grey_1_8f4bb61d2783492eab797454f3730de5_large.jpg', 'QUAN3', 'FRENCH TERRY COTTON','VETNAM', 'LOGO RUBBER SIGNATURE');

-- Quan tay
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO36','QUAN' , 'Quần Tây Slimfit - Cropped', 595000, 300000, 
'https://4men.com.vn/thumbs/2022/11/quan-tay-slimfit-cropped-tui-nho-qt048-mau-den-21948-p.JPG', 
'QUAN2', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO37','QUAN' , 'Quần Tây Regular Detail QT047 Màu Đen', 595000, 300000,
'https://4men.com.vn/thumbs/2022/10/quan-tay-regular-detail-qt047-mau-den-21887-p.JPG', 
'QUAN2', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO38','QUAN' , 'QT Slimfit Basic Pocket QT043', 595000, 300000,
'https://4men.com.vn/thumbs/2022/09/qt-slimfit-basic-pocket-qt043-21521-p.JPG', 
'QUAN2', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO39','QUAN' , 'Quần Tây Regular Trơn Tag Kim Loại QT041', 595000, 300000,
'https://4men.com.vn/thumbs/2022/07/quan-tay-regular-tron-tag-kim-loai-qt041-mau-xanh-den-21147-p.JPG', 
'QUAN2', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO40','QUAN' , 'Quần Tây Slimfit Túi Mini Kiểu QT039', 595000, 300000,
'https://4men.com.vn/thumbs/2022/06/quan-tay-slimfit-tui-mini-kieu-qt039-mau-be-20994-p.JPG', 
'QUAN2', 'Polyester','VETNAM', 'Regular Fit');

-- Quan Jeans
INSERT INTO Products(product_id, product_type, product_name, old_price, new_price,  main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO41','QUAN' , 'Quần Jeans Regular Mid - Blue Geometric', 595000, 300000,
'https://4men.com.vn/thumbs/2022/11/quan-jeans-regular-mid-blue-geometric-qj071-21945-p.JPG', 
'QUAN1', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name,  old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO42','QUAN' , 'Quần Jeans Slimfit Grey Faded QJ070', 595000, 300000,
'https://4men.com.vn/thumbs/2022/10/quan-jeans-slimfit-grey-faded-qj070-21874-p.JPG', 
'QUAN1', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name,old_price, new_price,  main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO43','QUAN' , 'Quần Jeans Blue Regular Túi Kiểu QJ069', 595000, 300000,
'https://4men.com.vn/thumbs/2022/10/quan-jeans-blue-regular-tui-kieu-qj069-21872-p.JPG', 
'QUAN1', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO44','QUAN' , 'Quần Tây Slimfit Túi Mini Kiểu QT039', 595000, 300000,
'https://4men.com.vn/thumbs/2022/06/quan-tay-slimfit-tui-mini-kieu-qt039-mau-be-20994-p.JPG', 
'QUAN1', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO45','QUAN' , 'QJ Slimfit Lightblue QJ064', 595000, 300000,
'https://4men.com.vn/thumbs/2022/09/qj-slimfit-lightblue-qj064-21525-p.JPG', 
'QUAN1', 'Polyester','VETNAM', 'Regular Fit');

INSERT INTO Products(product_id, product_type, product_name, old_price, new_price, main_image_url, category_id, meterial, origin, pattern)
VALUES('PRO46','QUAN' , 'Quần Jeans Slimfit Rách Gối QJ068 Màu Đen', 595000, 300000,
'https://4men.com.vn/thumbs/2022/08/quan-jeans-slimfit-rach-goi-qj068-mau-den-21331-p.JPG', 
'QUAN1', 'Polyester','VETNAM', 'Regular Fit');


-- Insert data to Sizes table
INSERT INTO Sizes(size_id, size_name)
VALUES('SIZES', N'S');
INSERT INTO Sizes(size_id, size_name)
VALUES('SIZEM', N'M');
INSERT INTO Sizes(size_id, size_name)
VALUES('SIZEL', N'L');
INSERT INTO Sizes(size_id, size_name)
VALUES('SIZEXL', N'XL');

-- Insert data to Colors table
INSERT INTO Colors(color_id, color_name)
VALUES('COL1', N'RED');
INSERT INTO Colors(color_id, color_name)
VALUES('COL2', N'BLACK');
INSERT INTO Colors(color_id, color_name)
VALUES('COL3', N'ROSE GREY');
INSERT INTO Colors(color_id, color_name)
VALUES('COL4', N'DARK GREEN');
INSERT INTO Colors(color_id, color_name)
VALUES('COL5', N'BROW');
INSERT INTO Colors(color_id, color_name)
VALUES('COL6', N'WHITE');
INSERT INTO Colors(color_id, color_name)
VALUES('COL7', N'DARK RED');
INSERT INTO Colors(color_id, color_name)
VALUES('COL8', N'DARK BROW');
INSERT INTO Colors(color_id, color_name)
VALUES('COL9', N'BLUE');
INSERT INTO Colors(color_id, color_name)
VALUES('COL10', N'PINK');
INSERT INTO Colors(color_id, color_name)
VALUES('COL11', N'PURPLE PINK');
INSERT INTO Colors(color_id, color_name)
VALUES('COL12', N'MATCHA');

-- Insert data to Option tables
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP1', 100, 'PRO01', 'COL3', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP2', 110, 'PRO01', 'COL3', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP3', 50, 'PRO01', 'COL3', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP4', 100, 'PRO02', 'COL1', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP5', 90, 'PRO02', 'COL1', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP6', 200, 'PRO02', 'COL3', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP7', 103, 'PRO03', 'COL4', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP8', 118, 'PRO03', 'COL4', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP9', 114, 'PRO03', 'COL4', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP10', 100, 'PRO04', 'COL1', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP11', 100, 'PRO04', 'COL1', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP12', 100, 'PRO05', 'COL5', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP13', 100, 'PRO05', 'COL5', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP14', 100, 'PRO06', 'COL2', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP15', 100, 'PRO06', 'COL2', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP16', 100, 'PRO06', 'COL2', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP17', 100, 'PRO07', 'COL6', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP18', 100, 'PRO07', 'COL6', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP19', 100, 'PRO08', 'COL3', 'SIZES');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP20', 100, 'PRO08', 'COL3', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP21', 100, 'PRO09', 'COL2', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP22', 100, 'PRO10', 'COL4', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP23', 100, 'PRO11', 'COL7', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP24', 100, 'PRO12', 'COL6', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP25', 100, 'PRO13', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP26', 100, 'PRO14', 'COL3', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP27', 100, 'PRO15', 'COL3', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP28', 100, 'PRO16', 'COL4', 'SIZEXL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP29', 100, 'PRO17', 'COL2', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP30', 100, 'PRO18', 'COL6', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP31', 100, 'PRO19', 'COL7', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP32', 100, 'PRO20', 'COL10', 'SIZEXL');

-- Option quan tay (PRO36 - PRO40)
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP33', 100, 'PRO36', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP34', 100, 'PRO36', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP35', 100, 'PRO36', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP36', 100, 'PRO37', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP37', 100, 'PRO37', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP38', 100, 'PRO38', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP39', 100, 'PRO38', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP40', 100, 'PRO38', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP41', 100, 'PRO39', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP42', 100, 'PRO39', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP43', 100, 'PRO39', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP44', 100, 'PRO40', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP45', 100, 'PRO40', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP46', 100, 'PRO40', 'COL10', 'SIZEXL');

-- Option quan jean(PRO41 - PRO46)
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP47', 100, 'PRO41', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP48', 100, 'PRO41', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP49', 100, 'PRO41', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP50', 100, 'PRO42', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP51', 100, 'PRO42', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP52', 100, 'PRO42', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP53', 100, 'PRO43', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP54', 100, 'PRO43', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP55', 100, 'PRO43', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP56', 100, 'PRO44', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP57', 100, 'PRO44', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP58', 100, 'PRO44', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP59', 100, 'PRO45', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP60', 100, 'PRO45', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP61', 100, 'PRO45', 'COL10', 'SIZEXL');

INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP62', 100, 'PRO46', 'COL8', 'SIZEM');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP63', 100, 'PRO46', 'COL9', 'SIZEL');
INSERT INTO `Options`(option_id, available_quantity, product_id, color_id, size_id)
VALUES('OP64', 100, 'PRO46', 'COL10', 'SIZEXL');

-- insert images
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI01', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_the_sign-rose_3_887c23310a294c99b96e44fd72c43f08_master.jpg', 'PRO01');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI02', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_the_sign-rose_2_cf7f7ae2e66649d598bd512111fda26a_master.jpg', 'PRO01');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI03', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_the_sign-rose_4_931c38e4d7f5499781923b109a6f4a55_master.jpg', 'PRO01');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI04', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_3_e8863745d76247b2bab68d5212c724bb_master.jpg', 'PRO02');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI05', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_2_bebaf030cc2c4a859e04831371096797_master.jpg', 'PRO02');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI06', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_4_1ddac1c3f36d49deb185896bc4d8d478_master.jpg', 'PRO02');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI07', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_vv31-grn-3_e183a0893e984d8d87b89d0e309b9858_master.jpg', 'PRO03');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI08', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_vv31-grn-2_3457eb918fed4b5aa233c1c8df409937_master.jpg', 'PRO03');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI09', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_vv31-grn-4_155a12edf5b448ff8e05f028b99eabee_master.jpg', 'PRO03');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI10', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_3_a14974ab5d374fb984eb960bb43a4cd8_master.jpg', 'PRO04');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI11', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_2_ead479c0ce384a5b889d1f977fdbf6be_master.jpg', 'PRO04');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI12', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-red_4_d6d80e53367947bba16ffb82a42ee892_master.jpg', 'PRO04');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI13', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-brown_3_d60963441c034c64a5351d2eaa5d8663_master.jpg', 'PRO05');

INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI14', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-brown_2_7a43b4ffa4c74be986f5d5d22a752492_master.jpg', 'PRO05');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI15', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_play-brown_4_f978908d26574f0fb84e28cc1411a295_master.jpg', 'PRO05');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI16', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_blk_3_09e22a1a268d453ca1b2d49c0ff5c5d5_master.jpg', 'PRO06');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI17', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_blk_2_2640c77bc93c416bbd76cbb5fe8953e4_master.jpg', 'PRO06');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI18', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_blk_4_a521c67b13084e4c9d865c1682603eb7_master.jpg', 'PRO06');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI19', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_wht_3_a605ddccd89448d1bcd68a45bad45c43_master.jpg', 'PRO07');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI20', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_wht_2_5d3fbced373b45f6a9383efa5b70bb73_master.jpg', 'PRO07');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI21', 'https://product.hstatic.net/200000305259/product/vgc-tee_mockup_sep22-art_my_summer_wht_4_a0810738c1b74bb18623ba4b793c8c23_master.jpg', 'PRO07');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI22', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v72-rose_2_2258e71714284e80b3fa1fc0b3ed0e8b_master.jpg', 'PRO08');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI23', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v72-rose_3_cfffae08b8a04f02968a20486ec5fed6_master.jpg', 'PRO08');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI24', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v72-rose_6_d6e7b9c1b30d46cfb32a4faa4286588b_master.jpg', 'PRO08');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI25', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-net-blk_3_5543527a9fca414ca77e44020dd1a8ee_master.jpg', 'PRO09');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI26', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-net-blk_2_50b4ae1ada644708a77d45ac78a92dad_master.jpg', 'PRO09');

INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI27', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-net-blk_4_13a4027d591b49bf8dffe4abad0fd1bf_master.jpg', 'PRO09');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI28', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-vv05-grn_3_be35262e5e544253a688fe98ab16a7c6_master.jpg', 'PRO10');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI39', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-vv05-grn_2_9a82752be9404a1686e71e039c9864e0_master.jpg', 'PRO10');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI30', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-vv05-grn_4_766ae3cc110d4753a951d22dd5f98fbb_master.jpg', 'PRO10');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI31', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v10_3_01b0f63d9c6745e9aba17830a63a65df_master.jpg', 'PRO11');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI32', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v10_2_a1a8da21e4244095bcfd98743b97e686_master.jpg', 'PRO11');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI33', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-v10_4_079264035e9b4e58a74e6c65e1a9b00c_master.jpg', 'PRO11');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI34', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-flower_wht_3_2ada55c9035e4745a400514f0e5eb28d_master.jpg', 'PRO12');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI35', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-flower_wht_2_9ed40cdc56bb4a11a18062612a9cfe05_master.jpg', 'PRO12');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI36', 'https://product.hstatic.net/200000305259/product/vgc-mockup_tee_aug22-flower_wht_4_42bd2218e1de4d9788a721427ae2a0b1_master.jpg', 'PRO12');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI37', 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_brown_1_f8900f57b4b144aa9c0c65378f593301_master.jpg', 'PRO13');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI38', 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_brown_4_f7892d17345f495f8fdf950773dea6d8_master.jpg', 'PRO13');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI52', 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_brown_3_356834f38e8c4d998a8d622613482e7a_master.jpg', 'PRO13');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI40', 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_grey_1_e150e09a024e47d2b75a945574aa61a8_master.jpg', 'PRO14');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI41', 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_grey_4_1e6801718431400f814ae3c514877739_master.jpg', 'PRO14');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI42', 'https://product.hstatic.net/200000305259/product/vgv-tee_art_v10_grey_3_60313ec1905b4a6ca1d029b268be075f_master.jpg', 'PRO14');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI43', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-grey_2_1e622c6bb05249d2ae03b0e99e418fbe_master.jpg', 'PRO15');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI44', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-grey_5_85253a043df34ed5983c8632a439f4d8_master.jpg', 'PRO15');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI45', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-grey_4_50a53cc6f58f4696a280a17cd1350d0c_master.jpg', 'PRO15');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI46', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-green_2_76710d507d184c84b000f48fa7fc09ed_master.jpg', 'PRO16');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI47', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-green_5_acecf9b119654cf7bf62d1b1340c174f_master.jpg', 'PRO16');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI48', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-green_4_2ccf7bf92c0445c5b9773368f2f7d5d0_master.jpg', 'PRO16');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI49', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-blk_2_7ebb8fb54d9642109e8d7570aa747c89_master.jpg', 'PRO17');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI50', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-blk_5_58b8a6576a4043a79863f81cc718525c_master.jpg', 'PRO17');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI51', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-blk_4_2b59ae61d3c74d7aa1fc107f83fefaed_master.jpg', 'PRO17');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI53', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-wht_2_86aaf37d8b6b42d787f50d6cb2832e74_master.jpg', 'PRO18');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI54', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-wht_5_b9911dbba67740b5bcd50a06b2b7f270_master.jpg', 'PRO18');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI55', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-wht_4_0a0b05105c3a4b0aa08fb93995b00809_master.jpg', 'PRO18');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI56', 'https://product.hstatic.net/200000305259/product/shirt_logo_tpr-red_2_9b795b907cbe4771bef84f55f3c9637d_master.jpg', 'PRO19');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI57', 'https://product.hstatic.net/200000305259/product/shirt_logo_tpr-red_5_ef73ef3c0d014321b5cb9859ea3b74e4_master.jpg', 'PRO19');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI58', 'https://product.hstatic.net/200000305259/product/shirt_logo_tpr-red_4_df8eeeb8f2f944b792f7879b2e1323f2_master.jpg', 'PRO19');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI59', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-beige_2_d978a7d7501b483980b94c3edc537e28_master.jpg', 'PRO20');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI60', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-beige_5_3f8246a3acf84bb1b42a928b3a3b4554_master.jpg', 'PRO20');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI61', 'https://product.hstatic.net/200000305259/product/l57bh1o8-1-y6dc-shirt_tpr-beige_4_4233945051fe49fd90f530d070f532c3_master.jpg', 'PRO20');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI62', 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_green_3_e7a8c28f1a834296b7a2d47c51f1aee1_master.jpg', 'PRO21');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI63', 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_green_6_42f1813c91a2407c80f2efb2613e42f7_master.jpg', 'PRO21');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI64', 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_green_4_b459ff4463cb463aaa58d7de4c362372_master.jpg', 'PRO21');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI65', 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_3_11a4af0a173e4d64a30b51f83daa4b4c_master.jpg', 'PRO22');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI66', 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_6_82a02d481c93443d988597a5b952e816_master.jpg', 'PRO22');
INSERT INTO ProductImages(image_id, image_url, product_id)
VALUES('PI67', 'https://product.hstatic.net/200000305259/product/vgc-mockup_polo_tpr_blk_4_ff730a8cfbb24ec19a77d0c4f36cecd7_master.jpg', 'PRO22');

-- Insert Bills
insert into Bills 
values('B201100', '2022-12-20', 450000, 0, 'U2011');
insert into Bills 
values('B201101', '2022-12-20', 500000, 0, 'U2011');
insert into Bills 
values('B201102', '2022-12-21', 600000, 0, 'U2012');
insert into Bills 
values('B201103', '2022-12-22', 700000, 0, 'U2012');
insert into Bills 
values('B201104', '2022-12-22', 69000, 0, 'U2012');
insert into Bills 
values('B201105', '2022-12-25', 900000, 0, 'U2013');
insert into Bills 
values('B201106', '2022-12-24', 135000, 0, 'U2013');
insert into Bills 
values('B201107', '2022-12-20', 450000, 0, 'U2014');
insert into Bills 
values('B201108', '2022-12-20', 350000, 0, 'U2015');
insert into Bills 
values('B201109', '2022-12-26', 600000, 0, 'U2015');
insert into Bills 
values('B201110', '2022-12-27', 800000, 0, 'U2015');
insert into Bills 
values('B201111', '2022-12-20', 320000, 0, 'U2016');
insert into Bills 
values('B201112', '2022-12-22', 320000, 0, 'U2016');
insert into Bills 
values('B201113', '2022-10-22', 320000, 0, 'U2016');
insert into Bills 
values('B201114', '2022-1-22', 420000, 0, 'U2017');
insert into Bills 
values('B201115', '2022-1-22', 620000, 0, 'U2017');
insert into Bills 
values('B201116', '2022-6-22', 720000, 0, 'U2017');
insert into Bills 
values('B201117', '2022-9-22', 920000, 0, 'U2017');
insert into Bills 
values('B201118', '2022-12-22', 120000, 0, 'U2018');
insert into Bills 
values('B201119', '2022-10-22', 120000, 0, 'U2018');
insert into Bills 
values('B201120', '2022-10-22', 350000, 0, 'U2018');
insert into Bills 
values('B201121', '2022-10-22', 520000, 0, 'U2018');
insert into Bills 
values('B201122', '2022-10-22', 240000, 0, 'U2019');
insert into Bills 
values('B201123', '2022-10-22', 260000, 0, 'U2019');
insert into Bills 
values('B201124', '2022-10-22', 280000, 0, 'U2019');
insert into Bills 
values('B201125', '2022-10-22', 290000, 0, 'U2019');
insert into Bills 
values('B201126', '2022-10-22', 300000, 0, 'U2020');
insert into Bills 
values('B201127', '2022-10-22', 920000, 0, 'U2020');
insert into Bills 
values('B201128', '2022-10-22', 840000, 0, 'U2021');
insert into Bills 
values('B201129', '2022-10-22', 670000, 0, 'U2021');
insert into Bills 
values('B201130', '2022-10-22', 830000, 0, 'U2021');
insert into Bills 
values('B201131', '2022-10-22', 290000, 0, 'U2021');
