using {star.wars as StarWars} from '../db/schema';

service StarWarsService @(path : '/StarWars'){
    entity Film as projection on StarWars.Film;
    entity People as projection on StarWars.People;
    entity Planet as projection on StarWars.Planet;
    entity Species as projection on StarWars.Species;
    entity Starship as projection on StarWars.Starship;
    entity Vehicles as projection on StarWars.Vehicles;

    entity Film2People as projection on StarWars.Film2People;
    entity Film2Planets as projection on StarWars.Film2Planets;
    entity Film2Starships as projection on StarWars.Film2Starships;
    entity Film2Vehicles as projection on StarWars.Film2Vehicles;
    entity Film2Species as projection on StarWars.Film2Species;

    entity People2Film as projection on StarWars.People2Film;
    entity People2Starships as projection on StarWars.People2Starships;
    entity People2Vehicles as projection on StarWars.People2Vehicles;
    entity People2Species as projection on StarWars.People2Species;

    entity Planet2Films as projection on StarWars.Planet2Films;
    entity Planet2People as projection on StarWars.Planet2People;

    entity Species2People as projection on StarWars.Species2People;
    entity Species2Films as projection on StarWars.Species2Films;

    entity Starship2Film as projection on StarWars.Starship2Film;
    entity Starship2Pilot as projection on StarWars.Starship2Pilot;

    entity Vehicle2Film as projection on StarWars.Vehicle2Film;
    entity Vehicle2Pilot as projection on StarWars.Vehicle2Pilot;
}
