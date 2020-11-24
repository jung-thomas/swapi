global.__base = __dirname + "/"
const cds = require('@sap/cds')
const path = require('path')
const fs = require("fs")
let routesDir = path.join(global.__base, '../oldPython/resources/fixtures/')
const uuid = require('uuid')

async function clearDB(db) {
    await Promise.all([
        db.run(DELETE.from(db.entities.Planet)),
        db.run(DELETE.from(db.entities.People)),
        db.run(DELETE.from(db.entities.Planet2People)),
        db.run(DELETE.from(db.entities.Film)),
        db.run(DELETE.from(db.entities.Film2People)),
        db.run(DELETE.from(db.entities.Film2Planets)),
        db.run(DELETE.from(db.entities.Film2Starships)),
        db.run(DELETE.from(db.entities.Film2Vehicles)),
        db.run(DELETE.from(db.entities.Film2Species)),
        db.run(DELETE.from(db.entities.Species)),
        db.run(DELETE.from(db.entities.Species2People)),
        db.run(DELETE.from(db.entities.Starship)),
        db.run(DELETE.from(db.entities.Starship2Pilot)),
        db.run(DELETE.from(db.entities.Vehicles)),
        db.run(DELETE.from(db.entities.Vehicle2Pilot)),
    ])
}

async function readFile(fileName) {
    const fullPath = path.join(routesDir + fileName)
    console.log(`Reading ${fileName}`)
    let importData = fs.readFileSync(fullPath)
    let data = JSON.parse(importData)
    let output = []
    for (let item of data) {
        item.ID = uuid.v4()
        output.push(item)
    }
    return output
}

async function init() {
    try {
        const db = await cds.connect.to('db', { model: global.__base + "/gen/srv/srv/csn.json", })
        const {
            People,
            Planet, Planet2People,
            Film, Film2People, Film2Planets, Film2Starships, Film2Vehicles, Film2Species,
            Species, Species2People,
            Starship, Starship2Pilot,
            Vehicles, Vehicle2Pilot } = db.entities

        await clearDB(db)

        let [people, planets, films, species, starships, vehicles, transports]
            = await Promise.all([
                readFile('people.json'),
                readFile('planets.json'),
                readFile('films.json'),
                readFile('species.json'),
                readFile('starships.json'),
                readFile('vehicles.json'),
                readFile('transport.json')
            ])

            let personsNew = []
            let Planet2PeopleNew = []
            for (let person of people) {
                let planet = planets.find(x => x.pk == person.fields.homeworld)
                person.fields.homeworld = planet.ID
                let insert = {}
                let p2p = {}
                p2p.people_ID = person.ID
                insert.ID = person.ID

                insert.homeworld_ID = person.fields.homeworld
                p2p.planet_ID = person.fields.homeworld

                insert.name = person.fields.name
                insert.height = person.fields.height
                insert.mass = person.fields.mass
                insert.hair_color = person.fields.hair_color
                insert.skin_color = person.fields.skin_color
                insert.eye_color = person.fields.eye_color
                insert.birth_year = person.fields.birth_year
                insert.gender = person.fields.gender
                personsNew.push(insert)
                Planet2PeopleNew.push(p2p)
            }
            db.run(INSERT.into(People).entries(personsNew))

            let planetsNew = []
            for (let planet of planets) {
                let insert = {}
                insert.ID = planet.ID
                insert.name = planet.fields.name
                insert.diameter = planet.fields.diameter
                insert.rotation_period = planet.fields.rotation_period
                insert.orbital_period = planet.fields.orbital_period
                insert.gravity = planet.fields.gravity
                insert.population = planet.fields.population
                insert.climate = planet.fields.climate
                insert.terrain = planet.fields.terrain
                insert.surface_water = planet.fields.surface_water
                planetsNew.push(insert)
            }
            db.run(INSERT.into(Planet).entries(planetsNew))
            db.run(INSERT.into(Planet2People).entries(Planet2PeopleNew))


            let starshipsNew = []
            let s2p = []
            for (let ship of starships) {
                let insert = {}
                let transport = transports.find(x => x.pk == ship.pk)
                insert.ID = ship.ID
                insert.name = transport.fields.name
                insert.model = transport.fields.model
                insert.starship_class = ship.fields.starship_class
                insert.manufacturer = transport.fields.manufacturer
                insert.cost_in_credits = transport.fields.cost_in_credits
                insert.length = transport.fields.length
                insert.crew = transport.fields.crew
                insert.passengers = transport.fields.passengers
                insert.max_atmosphering_speed = transport.fields.max_atmosphering_speed
                insert.hyperdrive_rating = ship.fields.hyperdrive_rating
                insert.MGLT = ship.fields.MGLT
                insert.cargo_capacity = transport.fields.cargo_capacity
                insert.consumables = transport.fields.consumables
                starshipsNew.push(insert)
                for (let pilot of ship.fields.pilots) {
                    let pilotDetails = people.find(x => x.pk == pilot)
                    let insert = {}
                    insert.starship_ID = ship.ID
                    insert.pilot_ID = pilotDetails.ID
                    s2p.push(insert)
                }
            }
            db.run(INSERT.into(Starship).entries(starshipsNew))
            db.run(INSERT.into(Starship2Pilot).entries(s2p))

            let vehiclesNew = []
            let v2p = []
            for (let vehicle of vehicles) {
                let insert = {}
                let transport = transports.find(x => x.pk == vehicle.pk)
                insert.ID = vehicle.ID
                insert.name = transport.fields.name
                insert.model = transport.fields.model
                insert.vehicle_class = vehicle.fields.vehicle_class
                insert.manufacturer = transport.fields.manufacturer
                insert.cost_in_credits = transport.fields.cost_in_credits
                insert.length = transport.fields.length
                insert.crew = transport.fields.crew
                insert.passengers = transport.fields.passengers
                insert.max_atmosphering_speed = transport.fields.max_atmosphering_speed
                insert.cargo_capacity = transport.fields.cargo_capacity
                insert.consumables = transport.fields.consumables
                vehiclesNew.push(insert)
                for (let pilot of vehicle.fields.pilots) {
                    let pilotDetails = people.find(x => x.pk == pilot)
                    let insert = {}
                    insert.vehicle_ID = vehicle.ID
                    insert.pilot_ID = pilotDetails.ID
                    v2p.push(insert)
                }
            }
            db.run(INSERT.into(Vehicles).entries(vehiclesNew))
            db.run(INSERT.into(Vehicle2Pilot).entries(v2p))

            let speciesNew = []
            let Species2PeopleNew = []
            for (let specie of species) {
                let insert = {}
                insert.ID = specie.ID

                insert.name = specie.fields.name
                insert.classification = specie.fields.classification
                insert.designation = specie.fields.designation
                insert.eye_colors = specie.fields.eye_colors
                insert.skin_colors = specie.fields.skin_colors
                insert.language = specie.fields.language
                insert.hair_colors = specie.fields.hair_colors
                insert.average_lifespan = specie.fields.average_lifespan
                insert.average_height = specie.fields.average_height
                if (specie.fields.homeworld) {
                    let planet = planets.find(x => x.pk == specie.fields.homeworld)
                    if (planet) {
                        insert.homeworld_ID = planet.ID
                    }
                }

                speciesNew.push(insert)
                for (let person of specie.fields.people) {
                    let personDetails = people.find(x => x.pk == person)
                    let insert = {}
                    insert.species_ID = specie.ID
                    insert.people_ID = personDetails.ID
                    Species2PeopleNew.push(insert)
                }
            }
            db.run(INSERT.into(Species).entries(speciesNew))
            db.run(INSERT.into(Species2People).entries(Species2PeopleNew))

            console.log(`Done`)
    } catch (error) {
        console.error(error)
        process.exit()
    }
}

init()
