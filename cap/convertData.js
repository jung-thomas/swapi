global.__base = __dirname + "/"

const cds = require('@sap/cds')
const path = require('path')
const fs = require("fs")
const fileExists = require('fs').existsSync
const glob = require('glob')
const uuid = require('uuid')

async function init() {
    const db = await cds.connect.to('db', { model: global.__base + "/gen/srv/srv/csn.json", })
    const { People, Planet } = db.entities

    let routesDir = path.join(global.__base, '../oldPython/resources/fixtures/*.json')
    let files = glob.sync(routesDir)
    this.routerFiles = files
    let people = []
    let planets = []

    if (files.length !== 0) {
        for (let file of files) {
            const fileName = path.basename(file)
            console.log(`Reading ${fileName}`)
            let importData = fs.readFileSync(file)
            let data = JSON.parse(importData)

            switch (fileName) {
                case 'people.json':
                    for (let item of data) {
                        item.ID = uuid.v4()
                        people.push(item)
                    }
                    break
                case 'planets.json':
                    for (let item of data) {
                        item.ID = uuid.v4()
                        planets.push(item)
                    }
                    break
                default:
                    break
            }
        }

        let personsNew = []
        for (let person of people) {
            let planet = planets.find(x => x.pk == person.fields.homeworld)
            person.fields.homeworld = planet.ID
            let insert = {}
            insert.ID = person.ID
            insert.homeworld_ID = person.fields.homeworld
            insert.name = person.fields.name
            insert.height = person.fields.height
            insert.mass = person.fields.mass
            insert.hair_color = person.fields.hair_color
            insert.skin_color = person.fields.skin_color
            insert.eye_color = person.fields.eye_color
            insert.birth_year = person.fields.birth_year
            insert.gender = person.fields.gender
            personsNew.push(insert)
        }
        db.run(INSERT.into(People).entries(personsNew))

        let planetsNew = []
        for (let planet of planets){
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

        console.log(`Done`)
    }
}

init()
