create table doctors (
	doctor_id int unsigned not null,
    doctor_subject varchar(20),
    doctor_name varchar(10) not null,
    doctor_gender varchar(5) not null,
    doctor_phone varchar(14),
    doctor_email varchar(20),
    doctor_rank varchar(10) not null,
    primary key(doctor_id)
);

create table nurses(
	nurse_id int unsigned not null,
    nurse_subject varchar(20),
    nurse_name varchar(10) not null,
    nurse_gender varchar(5) not null,
    nurse_phone varchar(14),
    nurse_email varchar(20),
    nurse_rank varchar(10) not null,
    primary key(nurse_id)
);

create table patients(
	patient_id int unsigned not null,
    nurse_id int unsigned not null,
    doctor_id int unsigned not null,
    patient_name varchar(10) not null ,
    patient_gender varchar(5) not null,
    patient_socialnumber char(14),
    patient_address varchar(20),
    patient_phone varchar(14),
    patient_email varchar(20),
    patient_job varchar(10),
    primary key(patient_id)
);

create table diagnosis(
	diagnosis_id int unsigned not null,
    patient_id int unsigned not null,
    doctor_id int unsigned not null,
    diagnosis_content varchar(100),
    diagnosis_date date not null
);
alter table diagnosis add primary key (diagnosis_id);

create table charts(
	chart_number int unsigned not null,
    diagnosis_id int unsigned not null,
	doctor_id int unsigned not null,
    patient_id int unsigned not null,
	nurse_id int unsigned not null,
    chart_content varchar(100)
);
alter table charts add primary key (chart_number);

alter table patients add foreign key(nurse_id) references nurses(nurse_id);
alter table patients add foreign key(doctor_id) references doctors(doctor_id);

alter table diagnosis add foreign key(patient_id) references patients(patient_id);
alter table diagnosis add foreign key(doctor_id) references doctors(doctor_id);

-- alter table diagnosis add unique index(diagnosis_id, patient_id, doctor_id); 
alter table diagnosis add unique key (diagnosis_id, patient_id, doctor_id);

alter table charts add foreign key(diagnosis_id) references diagnosis(diagnosis_id);
alter table charts add foreign key(doctor_id) references doctors(doctor_id);
alter table charts add foreign key(patient_id) references patients(patient_id);

alter table charts add unique key (chart_number, diagnosis_id, doctor_id, patient_id);

drop index diagnosis_id_2 on diagnosis;
