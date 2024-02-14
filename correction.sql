--Название и продолжительность самого длительного трека.
select trackname, len_tracks 
from tracks 
where len_tracks = (select MAX(len_tracks) from tracks);

--Количество треков, вошедших в альбомы 2019–2020 годов.
select distinct musicianname
from Musicians
left join  Multialbums on Musicians.musicians_id = Multialbums.musicians_id
left join Albums on Multialbums.albums_id = Albums.albums_id and Yearrelease not between '2020.01.01' and '2021.01.01'
where Albums.albums_id is null;

--Все исполнители, которые не выпустили альбомы в 2020 году.
select musicianname
from Musicians
where musicians_id not in (
	select distinct musicians_id
	from Multialbums
	join Albums on Multialbums.albums_id = Albums.albums_id
	where Yearrelease between '2019.01.01' and '2021.01.01');







