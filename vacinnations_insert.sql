
select * from categorie_vaccin;
select * from ecoles;
select * from centres_medicaux;
select * from medecins;
select * from specialites;
select * from enfants;
select * from vaccinations;
select * from medecins_Specialites;
select * from medecins_ecoles;



####
##Les medecins scolaires suivent les enfants d'un département
####

select * from centres_medicaux CM join medecins M 
on CM.centre_medicaux_id = M.centre_medicaux_id
join vaccinations V 
on M.medecins_id = V.medecins_id
join enfants E 

on V.enfant_id = E.enfant_id;

;

####
##chaque médecin dépend d'un des centres médicaux
####

select * from medecins M  left join  centres_medicaux CM
on  M.centre_medicaux_id = CM.centre_medicaux_id
where CM.centre_medicaux_id is null
;

select M.medecins_id,count(M.medecins_id) from medecins M  left join  centres_medicaux CM
on  M.centre_medicaux_id = CM.centre_medicaux_id
group by M.medecins_id,CM.centre_medicaux_id
;

####
##chaque médecin peut avoir aucune ou plusieurs spécialités
####

select * from medecins M left join medecins_Specialites MS
on M.medecins_id  = MS.medecins_id
where MS.medecins_id is null ;

select  M.medecins_id,count(M.medecins_id) as nb_specialite from medecins M join medecins_Specialites MS
on M.medecins_id  = MS.medecins_id
group by M.medecins_id
having count(M.medecins_id)  > 1
;



####
##chaque médecin est affecté à aucune ou plusieurs écoles pour une année donnée
####




select * from medecins M left join medecins_ecoles ME 
on M.medecins_id = ME.medecins_id
where ME.medecins_id is null;

select M.medecins_id ,count(M.medecins_id) as nb_ecoles from medecins M  join medecins_ecoles ME 
on M.medecins_id = ME.medecins_id
group by M.medecins_id
having count(M.medecins_id) > 1;

####
##une école peut avoir un ou plusieurs médecin rattaché
####

select E.ecole_id,count(E.ecole_id) as nb_medecins from ecoles E join medecins_ecoles ME
on E.ecole_id = ME.ecole_id 

group by E.ecole_id
order by count(E.ecole_id) desc
;

####
##les médecins ont la charge de la vaccination des enfants
####
##les 41 enfants ont été vaccinés

####
##la  vaccinationest mémorisée pour un vaccin et une date donnéexecute
####
##les 41 enfants ont été vaccinés

####
##les enfants peuvent recevoir plusieurs catégories de vaccin
# le mapping est effectuée dans la table vaccinations
####
##l'enfant dont l'id est 3 a reçu 3 vaccins

##il est evident qu'un médecin vaccine les enfants qui sont inscrits dans une école pour laquelle
#le médecin est affecté
 ####
##celà pose problème pour les medecins affecté à deux écoles (ici le médecin 10158)
## on aura un faux doublon si on enlève la clause where


select V.date_Vaccination,v.medecins_id,M.nom as medecin,v.enfant_id,E.nom as nom_enfant,v.id_vaccin,CV.code_vaccin,E.ecole_id as ecole_id_enfant,ME.ecole_id as ecole_id_medecin from medecins M join vaccinations V 
on M.medecins_id = V.medecins_id
left join enfants E
on V.enfant_id = E.enfant_id
left join categorie_vaccin CV
on V.id_vaccin = CV.id_vaccin
left join medecins_ecoles ME
on M.medecins_id = ME.medecins_id
where E.ecole_id = ME.ecole_id;


insert into categorie_vaccin ( code_vaccin) values ( 'Tresom'),
 ('Overhold'),
 ('Treeflex'),
 ( 'Fintone'),
 ('Viva'),
 ('Redhold'),
 ('Gembucket'),
 ('Alpha'),
 ('Alpha1'),
('Bitwolf');

insert into ecoles (nb_eleves, nom_ecole, adresse, code_postal, ville ) 
values (24, "nom_ecole", 'adresse', '3994', 'Ville1'),
(24, "nom_ecole1", 'adresse1', '3994', 'Ville1'),
(24, "nom_ecole2", 'adresse2', '3994', 'Ville2'),
(25, "nom_ecole3", 'adresse3', '3994', 'Ville3'),
(24, "nom_ecole4", 'adresse4', '3994', 'Ville4'),
(28, "nom_ecole5", 'adresse5', '3994', 'Ville5'),
(24, "nom_ecole6", 'adresse6', '3994', 'Ville6'),
(20, "nom_ecole7", 'adresse7', '3994', 'Ville7'),
(24, "nom_ecole8", 'adresse8', '3994', 'Ville8'),
(24, "nom_ecole9", 'adresse9', '3994', 'Ville9') ;



insert into centres_medicaux (nom ,adresse ,code_postal ,ville) values

("CM_Nom1","CM_Adresse1", "93400","CM_Ville1"),
("CM_Nom2","CM_Adresse2", "93400","CM_Ville2"),
("CM_Nom3","CM_Adresse3", "93400","CM_Ville3"),
("CM_Nom4","CM_Adresse4", "93400","CM_Ville4"),
("CM_Nom5","CM_Adresse5", "93400","CM_Ville5"),
("CM_Nom6","CM_Adresse6", "93400","CM_Ville6"),
("CM_Nom7","CM_Adresse7", "93400","CM_Ville7"),
("CM_Nom8","CM_Adresse8", "93400","CM_Ville8"),
("CM_Nom9","CM_Adresse9", "93400","CM_Ville9"),
("CM_Nom10","CM_Adresse10", "93400","CM_Ville10");

insert into medecins (medecins_id ,nom,prenom,centre_medicaux_id)
values 
("12345","M_nom1","M_prenom1",1),
("11345","M_nom2","M_prenom2",2),
("11347","M_nom3","M_prenom3",4),
("11115","M_nom4","M_prenom4",3),
("11111","M_nom5","M_prenom5",9),
("21345","M_nom6","M_prenom6",1),
("22345","M_nom7","M_prenom7",5),
("22234","M_nom8","M_prenom8",1),
("10158","M_nom9","M_prenom9",8),
("15678","M_nom10","M_prenom10",7);


insert into  specialites (Nom_Specialite) values 
("Nom_Specialite1"),
("Nom_Specialite2"),
("Nom_Specialite3"),
("Nom_Specialite4"),
("Nom_Specialite5"),
("Nom_Specialite6"),
("Nom_Specialite7"),
("Nom_Specialite8"),
("Nom_Specialite9"),
("Nom_Specialite10");

insert into enfants (nom,prenom,age,sexe ,poids,taille,Ecole_id)
values 
("E_Enfant1","E_prenom1",10,"F",55,150,1),
("E_Enfant2","E_prenom2",10,"F",55,150,1),
("E_Enfant3","E_prenom3",10,"F",55,150,1),
("E_Enfant4","E_prenom4",10,"F",55,150,1),
("E_Enfant5","E_prenom5",10,"F",55,150,1),
("E_Enfant6","E_prenom6",10,"F",55,150,1),
("E_Enfant7","E_prenom7",10,"F",55,150,1),
("E_Enfant8","E_prenom8",10,"F",55,150,1),
("E_Enfant9","E_prenom9",10,"F",55,150,1),
("E_Enfant10","E_prenom10",10,"F",55,150,1),
("E_Enfant11","E_prenom11",10,"F",55,150,2),
("E_Enfant12","E_prenom12",10,"F",55,150,2),
("E_Enfant13","E_prenom13",10,"F",55,150,2),
("E_Enfant14","E_prenom14",10,"F",55,150,2),
("E_Enfant15","E_prenom15",10,"F",55,150,2),
("E_Enfant16","E_prenom16",10,"F",55,150,2),
("E_Enfant17","E_prenom17",10,"F",55,150,2),
("E_Enfant18","E_prenom18",10,"F",55,150,2),
("E_Enfant19","E_prenom19",10,"F",55,150,2),
("E_Enfant20","E_prenom20",10,"F",55,150,2),
("E_Enfant21","E_prenom21",10,"F",55,150,3),
("E_Enfant22","E_prenom22",10,"F",55,150,3),
("E_Enfant23","E_prenom23",10,"F",55,150,3),
("E_Enfant24","E_prenom24",10,"F",55,150,3),
("E_Enfant25","E_prenom25",10,"F",55,150,3),
("E_Enfant26","E_prenom26",10,"F",55,150,4),
("E_Enfant27","E_prenom27",10,"F",55,150,4),
("E_Enfant28","E_prenom28",10,"F",55,150,4),
("E_Enfant29","E_prenom29",10,"F",55,150,4),
("E_Enfant30","E_prenom30",10,"F",55,150,4),
("E_Enfant31","E_prenom31",10,"F",55,150,5),
("E_Enfant32","E_prenom32",10,"F",55,150,5),
("E_Enfant33","E_prenom33",10,"F",55,150,6),
("E_Enfant34","E_prenom34",10,"F",55,150,6),
("E_Enfant35","E_prenom35",10,"F",55,150,7),
("E_Enfant36","E_prenom36",10,"F",55,150,7),
("E_Enfant37","E_prenom37",10,"F",55,150,8),
("E_Enfant38","E_prenom38",10,"F",55,150,8),
("E_Enfant39","E_prenom39",10,"F",55,150,9),
("E_Enfant40","E_prenom40",10,"F",55,150,9),
("E_Enfant41","E_prenom41",10,"F",55,150,9)
;
delete  from vaccinations;
insert into vaccinations (date_vaccination,medecins_id,enfant_id,id_vaccin )
values 
("2021-01-04","12345",1,2),
("2021-01-04","12345",2,3),
("2021-01-04","12345",3,4),
("2021-01-04","12345",3,5),
("2021-01-04","12345",3,1),
("2021-01-04","12345",4,5),
("2021-01-04","12345",5,7),
("2021-01-04","12345",6,8),
("2021-01-05","12345",7,9),
("2021-01-05","12345",8,2),
("2021-01-05","12345",9,1),
("2021-01-05","12345",10,7),
("2021-01-05","21345",11,2),
("2021-01-05","21345",12,3),
("2021-01-05","21345",13,4),
("2021-01-05","21345",14,5),
("2021-01-05","21345",15,7),


("2021-01-06","22234",16,8),
("2021-01-06","22234",17,9),
("2021-01-06","22234",18,2),
("2021-01-06","22234",19,1),
("2021-01-06","22234",20,7),
("2021-01-07","11345",21,8),
("2021-01-07","11345",22,9),
("2021-01-07","11345",23,2),
("2021-01-07","11345",24,1),
("2021-01-07","11345",25,7),
("2021-01-08","11115",26,8),
("2021-01-08","11115",27,9),
("2021-01-08","11115",28,2),
("2021-01-08","11115",29,1),
("2021-01-08","11115",30,7),
("2021-01-09","22345",31,1),
("2021-01-09","22345",32,7),
("2021-01-09","15678",33,1),
("2021-01-09","15678",34,7),
("2021-01-10","10158",35,1),
("2021-01-10","10158",36,7),
("2021-01-10","11111",37,1),
("2021-01-10","11111",38,7),
("2021-01-10","10158",39,1),
("2021-01-11","10158",40,7),
("2021-01-11","10158",41,7);

insert into medecins_Specialites (medecins_id,specialite_id)
values
("12345",1),
("12345",4),
("21345",2),
("21345",6),
("22234",3),
("11345",4),
("11115",5),
("11347",6),
("22345",7),
("15678",8);


insert into medecins_ecoles (Ecole_id,medecins_id)
values
(1,"12345"),
(2,"21345"),
(2,"22234"),
(3,"11345"),
(4,"11115"),
(5,"22345"),
(6,"15678"),
(7,"10158"),
(8,"11111"),
(9,"10158");





