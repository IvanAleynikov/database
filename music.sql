CREATE table IF NOT EXISTS Musicians (
musicians_id SERIAL PRIMARY KEY,
MusicianName VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS Genres (
genres_id SERIAL PRIMARY KEY,
GenreName VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT exists Multigenre (
genres_id SERIAL REFERENCES Genres(genres_id),
musicians_id INTEGER REFERENCES Musicians(musicians_id),
PRIMARY KEY (genres_id, musicians_id)
);

CREATE table IF NOT EXISTS Albums (
albums_id SERIAL PRIMARY KEY,
AlbumName VARCHAR(150) NOT null,
Yearrelease DATE NOT NULL
);

CREATE TABLE IF NOT exists Multialbums (
albums_id SERIAL REFERENCES Albums(albums_id),
musicians_id INTEGER REFERENCES Musicians(musicians_id),
PRIMARY KEY (albums_id, musicians_id )
);

CREATE TABLE IF NOT exists Playlists (
playlist_id SERIAL PRIMARY KEY,
PlaylistName VARCHAR(150) NOT NULL,
ReleaseYear DATE NOT NULL
);

CREATE table IF NOT EXISTS Tracks (
track_id SERIAL PRIMARY KEY,
TrackName VARCHAR(150) NOT NULL,
len_tracks TIME not null,
albums_id INTEGER REFERENCES Albums(albums_id)
);

CREATE TABLE IF NOT exists TracksPlaylists (
track_id SERIAL REFERENCES Tracks(track_id),
playlist_id INTEGER REFERENCES Playlists(playlist_id),
PRIMARY KEY (track_id, playlist_id)
);
