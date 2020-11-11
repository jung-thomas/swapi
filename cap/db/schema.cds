using {
    managed,
    sap,
    cuid
} from '@sap/cds/common';

namespace star.wars;

entity Film : cuid, managed {
    title         : String;
    episode_id    : Integer;
    opening_crawl : String;
    director      : String;
    producer      : String;
    release_date  : Date;
    characters    : Association to many Film2People on characters.film = $self;
    planets       : Association to many Film2Planets on planets.film = $self;
    starships     : Association to many Film2Starships on starships.film = $self;
    vehicles      : Association to many Film2Vehicles on vehicles.film = $self;
    species       : Association to many Film2Species on species.film = $self;
    url           : String;
}

annotate Film with @(title : '{i18n>Film}') {
    title         @title : '{i18n>title}';
    episode_id    @title : '{i18n>episode_id}';
    opening_crawl @title : '{i18n>opening_crawl}';
    director      @title : '{i18n>director}';
    producer      @title : '{i18n>producer}';
    release_date  @title : '{i18n>release_date}';
    characters    @title : '{i18n>characters}';
    planets       @title : '{i18n>planets}';
    starships     @title : '{i18n>starships}';
    vehicles      @title : '{i18n>vehicles}';
    species       @title : '{i18n>species}';
    url           @title : '{i18n>url}';
}

entity Film2People {
    film : Association to Film;
    people: Association to People;
}

entity Film2Planets {
    film : Association to Film;
    planet: Association to Planet;
}

entity Film2Starships {
    film : Association to Film;
    starship: Association to Starship;
}

entity Film2Vehicles {
    film : Association to Film;
    vehicle: Association to Vehicles;
}

entity Film2Species {
    film : Association to Film;
    specie: Association to Species;
}
entity People : cuid, managed {
    name       : String;
    height     : String;
    mass       : String;
    hair_color : String;
    skin_color : String;
    eye_color  : String;
    birth_year : String;
    gender     : String;
    homeworld  : Association to Planet;
    films      : Association to many People2Film on films.people = $self;
    species    : Association to many People2Species on species.people = $self;
    vehicles   : Association to many People2Vehicles on vehicles.people = $self;
    starships  : Association to many People2Starships on starships.people = $self;
    url        : String;
}

annotate People with @(title : '{i18n>People}') {
    name       @title : '{i18n>name}';
    height     @title : '{i18n>height}';
    mass       @title : '{i18n>mass}';
    hair_color @title : '{i18n>hair_color}';
    skin_color @title : '{i18n>skin_color}';
    eye_color  @title : '{i18n>eye_color}';
    birth_year @title : '{i18n>birth_year}';
    gender     @title : '{i18n>gender}';
    homeworld  @title : '{i18n>homeworld}';
    films      @title : '{i18n>films}';
    species    @title : '{i18n>species}';
    vehicles   @title : '{i18n>vehicles}';
    starships  @title : '{i18n>starships}';
    url        @title : '{i18n>url}';
}


entity People2Film {
    people: Association to People;    
    film : Association to Film;
}

entity People2Starships {
    people : Association to People;
    starship: Association to Starship;
}

entity People2Vehicles {
    people : Association to People;
    vehicle: Association to Vehicles;
}

entity People2Species {
    people : Association to People;
    specie: Association to Species;
}

entity Planet : cuid, managed {
    name            : String;
    diameter        : String;
    rotation_period : String;
    orbital_period  : String;
    gravity         : String;
    population      : String;
    climate         : String;
    terrain         : String;
    surface_water   : String;
    films           : Association to many Planet2Films on films.planet = $self;
    residents       : Association to many Planet2People on residents.planet = $self;
    url             : String;
}

annotate Planet with @(title : '{i18n>Planet}') {
    name            @title : '{i18n>name}';
    diameter        @title : '{i18n>diameter}';
    rotation_period @title : '{i18n>rotation_period}';
    orbital_period  @title : '{i18n>orbital_period}';
    gravity         @title : '{i18n>gravity}';
    population      @title : '{i18n>population}';
    climate         @title : '{i18n>climate}';
    terrain         @title : '{i18n>terrain}';
    surface_water   @title : '{i18n>surface_water}';
    films           @title : '{i18n>films}';
    residents       @title : '{i18n>residents}';
    url             @title : '{i18n>url}';
}

entity Planet2Films {
    planet : Association to Planet;
    film: Association to Film;
}

entity Planet2People {
    planet : Association to Planet;
    people: Association to People;
}
entity Species : cuid, managed {
    name             : String;
    classification   : String;
    designation      : String;
    average_height   : String;
    average_lifespan : String;
    hair_colors      : String;
    skin_colors      : String;
    eye_colors       : String;
    homeworld        : String;
    language         : String;
    people           : Association to many Species2People on people.species = $self;
    films            : Association to many Species2Films on films.species = $self;
    url              : String;
}

annotate Species with @(title : '{i18n>Species}') {
    name             @title : '{i18n>name}';
    classification   @title : '{i18n>classification}';
    designation      @title : '{i18n>designation}';
    average_height   @title : '{i18n>average_height}';
    average_lifespan @title : '{i18n>average_lifespan}';
    hair_colors      @title : '{i18n>hair_colors}';
    skin_colors      @title : '{i18n>skin_colors}';
    eye_colors       @title : '{i18n>eye_colors}';
    homeworld        @title : '{i18n>homeworld}';
    language         @title : '{i18n>language}';
    people           @title : '{i18n>people}';
    films            @title : '{i18n>films}';
    url              @title : '{i18n>url}';
}
entity Species2People {
    species : Association to Species;
    people: Association to People;
}

entity Species2Films {
    species : Association to Species;
    film: Association to Film;
}
entity Starship : cuid, managed {
    name                   : String;
    model                  : String;
    starship_class         : String;
    manufacturer           : String;
    cost_in_credits        : String;
    length                 : String;
    crew                   : String;
    passengers             : String;
    max_atmosphering_speed : String;
    hyperdrive_rating      : String;
    MGLT                   : String;
    cargo_capacity         : String;
    consumables            : String;
    films                  : Association to many Starship2Film on films.starship = $self;
    pilots                 : Association to many Starship2Pilot on pilots.starship = $self;
    url                    : String;
}

annotate Starship with @(title : '{i18n>Starship}') {
    name                   @title : '{i18n>name}';
    model                  @title : '{i18n>model}';
    starship_class         @title : '{i18n>starship_class}';
    manufacturer           @title : '{i18n>manufacturer}';
    cost_in_credits        @title : '{i18n>cost_in_credits}';
    length                 @title : '{i18n>length}';
    crew                   @title : '{i18n>crew}';
    passengers             @title : '{i18n>passengers}';
    max_atmosphering_speed @title : '{i18n>max_atmosphering_speed}';
    hyperdrive_rating      @title : '{i18n>hyperdrive_rating}';
    MGLT                   @title : '{i18n>MGLT}';
    cargo_capacity         @title : '{i18n>cargo_capacity}';
    consumables            @title : '{i18n>consumables}';
    films                  @title : '{i18n>films}';
    pilots                 @title : '{i18n>pilots}';
    url                    @title : '{i18n>url}';
}

entity Starship2Film {
    starship : Association to Starship;
    film: Association to Film;
}

entity Starship2Pilot {
    starship : Association to Starship;    
    pilot : Association to People;
}

entity Vehicles : cuid, managed {
    name                   : String;
    model                  : String;
    vehicle_class          : String;
    manufacturer           : String;
    cost_in_credits        : String;
    length                 : String;
    crew                   : String;
    passengers             : String;
    max_atmosphering_speed : String;
    cargo_capacity         : String;
    consumables            : String;
    films                  : Association to many Vehicle2Film on films.vehicle = $self;
    pilots                 : Association to many Vehicle2Pilot on pilots.vehicle = $self;
    url                    : String;
}

annotate Vehicles with @(title : '{i18n>Vehicles}') {
    name                   @title : '{i18n>name}';
    model                  @title : '{i18n>model}';
    vehicle_class          @title : '{i18n>vehicle_class}';
    manufacturer           @title : '{i18n>manufacturer}';
    cost_in_credits        @title : '{i18n>cost_in_credits}';
    length                 @title : '{i18n>length}';
    crew                   @title : '{i18n>crew}';
    passengers             @title : '{i18n>passengers}';
    max_atmosphering_speed @title : '{i18n>max_atmosphering_speed}';
    cargo_capacity         @title : '{i18n>cargo_capacity}';
    consumables            @title : '{i18n>consumables}';
    films                  @title : '{i18n>films}';
    pilots                 @title : '{i18n>pilots}';
    url                    @title : '{i18n>url}';
}

entity Vehicle2Film {
    vehicle : Association to Vehicles;
    film: Association to Film;
}

entity Vehicle2Pilot {
    vehicle : Association to Vehicles;    
    pilot : Association to People;
}