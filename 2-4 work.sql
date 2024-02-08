--Название и продолжительность самого длительного трека.
select trackname, len_tracks  
from tracks 
order by len_tracks desc 
limit 1

--Название треков, продолжительность которых не менее 3,5 минут.
select trackname, len_tracks  
from tracks 
where len_tracks >= '03:30'

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select playlistname, releaseyear  
from playlists 
where releaseyear between '2018.01.01' and '2021.01.01'

--Исполнители, чьё имя состоит из одного слова.
select musicianname 
from musicians
where musicianname  not like '% %'

--Название треков, которые содержат слово «мой» или «my».
select trackname  
from tracks 
where trackname like '%my%' or trackname like '%мой%'

--Количество исполнителей в каждом жанре.
select genres_id, count(musicians_id) 
from multigenre 
group by genres_id 

--Количество треков, вошедших в альбомы 2019–2020 годов.
insert into albums 
values(5, 'Kamikaze', '2019.05.10');

insert into tracks  
values(7, 'Normal', '3:42', 5);

select count(track_id) 
from tracks 
where albums_id  in ( 
	select albums_id 
	from albums 
	where yearrelease between '2019.01.01' and '2021.01.01'
);

--Средняя продолжительность треков по каждому альбому.
select albums.albums_id, albumname, AVG(len_tracks)  
from albums 
join tracks on albums.albums_id = tracks.albums_id
group by albums.albums_id, albumname;

--Все исполнители, которые не выпустили альбомы в 2020 году.
select distinct musicianname
from Musicians
left join  Multialbums on Musicians.musicians_id = Multialbums.musicians_id
left join Albums on Multialbums.albums_id = Albums.albums_id and Yearrelease not between '2020.01.01' and '2021.01.01'
where Albums.albums_id is null;

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
select playlistname 
from playlists 
join tracksplaylists on playlists.playlist_id = tracksplaylists.playlist_id 
join tracks  on tracksplaylists.track_id = tracks.track_id 
join albums on tracks.albums_id = albums.albums_id
join multialbums on albums.albums_id = multialbums.albums_id
join musicians on multialbums.musicians_id = musicians.musicians_id 
where musicianname = 'Lady Gaga';

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
insert into multigenre  
values(7, 4, 3);

insert into multigenre 
values (8, 4, 1);

insert into multialbums 
values (5, 4, 1);

select albumname 
from albums 
join multialbums on albums.albums_id = multialbums.albums_id
join musicians on multialbums.musicians_id = musicians.musicians_id 
join multigenre on multialbums.musicians_id = multigenre.musicians_id 
group by albumname
having COUNT (distinct multigenre.genres_id) > 1;

--Наименования треков, которые не входят в сборники.
select  trackname 
from tracks 
left join tracksplaylists on tracks.track_id = tracksplaylists.track_id
where tracksplaylists.track_id is null;

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
select musicianname, tracks.trackname, tracks.len_tracks  
from musicians
join multialbums on multialbums.musicians_id = musicians.musicians_id 
join albums on albums.albums_id = multialbums.albums_id
join tracks on tracks.albums_id = albums.albums_id
where len_tracks = (
	select MIN(len_tracks)
    from tracks
    ); 
   
--Названия альбомов, содержащих наименьшее количество треков
select albumname, count(tracks.track_id)
from albums 
join tracks on albums.albums_id = tracks.albums_id
group by albums.albums_id, albumname
having count(tracks.track_id) = (
	select count(track_id)
	from tracks
    group by tracks.albums_id
    order by count(track_id)
    limit 1
    );

 