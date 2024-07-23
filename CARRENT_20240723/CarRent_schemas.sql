create table rentcompany(
	rentcompany_id int unsigned not null comment '캠핑카대여회사ID',
    rentcompany_name varchar(20) not null comment '회사명',
    rentcompany_address varchar(20) comment '주소',
    rentcompany_phone varchar(15) comment '전화번호',
    manager_name varchar(10) not null comment '담당자이름',
    manager_email varchar(20) comment '담당자이메일',
    primary key(rentcompany_id)
);



create table repairshop(
	repairshop_id int unsigned not null comment '정비소ID',
    repairshop_name varchar(10) not null comment '정비소명',
    repairshop_address varchar(20) comment '정비소주소',
    repairshop_phone varchar(15) comment '정비소전화번호',
    manager_name varchar(10) not null comment '담당자이름',
    manager_email varchar(20) comment '담당자이메일',
    primary key(repairshop_id)
);


create table customer(
	license varchar(15) not null comment '운전면허증',
    customer_name varchar(10) not null comment '고객명',
    customer_address varchar(20) comment '고객주소',
    customer_phone varchar(15) not null comment '고객전화번호',
    customer_email varchar(20) comment '고객이메일',
    beforeusedate date comment '이전캠핑카사용날짜',
    beforeusecartype varchar(15) comment '이전사용캠핑카종류',
    primary key(license)
);


create table campingcar(
	campingcar_id int unsigned not null comment '캠핑카등록ID',
    rentcompany_id int unsigned,
    campingcar_name varchar(10) unique not null comment '캠핑카이름',
    campingcar_number varchar(15) unique not null comment '캠핑카차량번호',
    campingcar_passengernum int unique not null comment '캠핑카승차인원',
    campingcar_image varchar(50) comment '캠핑카이미지',
    campingcar_price int unique not null comment '캠핑카대여비용',
    campingcar_regi_date date not null comment '캠핑카등록일자'
);
alter table campingcar add primary key(campingcar_id, rentcompany_id);

create table carrent(
	rentnumber int unsigned not null comment '대여번호',
    campingcar_id int unsigned,
    license varchar(15),
    rentcompany_id int unsigned,
    rent_startdate date not null comment '대여시작일',
    Rental_period int unsigned not null comment '대여기간',
    billing_price int unsigned not null comment '청구요금',
    payment_due_date date unique not null comment '납입기한',
    Other_billing varchar(50) comment '기타청구내역',
    other_price int comment '기타청구요금',
    primary key(rentnumber)
);


create table carinformation(
	repair_number int unsigned unique not null comment '정비번호',
    campingcar_id int unsigned unique,
    repairshop_id int unsigned unique,
    rentcompany_id int unsigned unique,
    license varchar(15),
    repair_list varchar(100) comment '정비내역',
    repair_date date comment '수리날짜',
    repir_price int unsigned comment '수리비용',
    payment_due_date date unique not null comment '납입기한',
    other_repair_list varchar(100) comment '기타정비내역',
	primary key(repair_number)
);

alter table campingcar add foreign key(rentcompany_id) references rentcompany(rentcompany_id);
-- alter table campingcar drop foreign key campingcar_ibfk_2;

alter table carrent add foreign key(campingcar_id, rentcompany_id) references campingcar(campingcar_id, rentcompany_id);
alter table carrent add foreign key(license) references customer (license);

alter table carinformation add foreign key(campingcar_id, rentcompany_id) references campingcar(campingcar_id, rentcompany_id);
alter table carinformation add foreign key(repairshop_id) references repairshop(repairshop_id);
alter table carinformation add foreign key(license) references customer(license);

commit;
