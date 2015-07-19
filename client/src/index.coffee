React = require 'react'
request = require 'superagent'
{div, p, a, button, input, label} = React.DOM

SideBar = require './sidebar.coffee'
MyMap = require './mymap.coffee'



configuration =

    first: (callback) ->
        request
            .get('/api/configuration')
            .set('Accept', 'application/json')
            .end (err, res) ->
                return callback err if err

                if res.body.length is 0
                    callback err, null
                else
                    callback err, res.body[0]

    create: (data, callback) ->
        request
            .post('/api/configuration')
            .send(data)
            .set('Accept', 'application/json')
            .end (err, res) ->
                callback err, res.body[0]

    update: (data, callback) ->
        request
            .put("/api/configuration/#{data.id}")
            .send(data)
            .set('Accept', 'application/json')
            .end (err, res) ->
                callback err, res.body

    delete: (callback) ->
        request
            .delete("/api/configuration/#{data.id}")
            .set('Accept', 'application/json')
            .end (err, res) ->
                callback err, res.body



placesdata =

    getPlacesData: (callback) ->
        request
            .get('/api/placedata')
            .set('Accept', 'application/json')
            .end (err, res) ->
                callback err, res.body



data = {
    homedata: configuration
    # getPlacesBookmarks: placesdata
    }



App = React.createClass

    render: ->
        div null,
            SideBar
                homedata: @props.homedata
                placesdata: @props.placesdata
            MyMap



# Start the App !
configuration.first (err, res) ->

    configuration.create data, (err, data) ->
        console.log err
        data =
            homedata: config,
            placesdata: placesdata,
        React.render(React.createElement(App, config),
            document.getElementById('app'))
