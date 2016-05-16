###
runQuery = ->
  xenia()
    .collection('comments')
    #.match( { body: 'ugly'} )
    .match( { qty: { $gt: 20 } } )
    .sample(10)
    .join('assets', '_id', 'asset_id', 'article')
  .exec()

runQuery().then (res) ->
  data = res.results[0].Docs

  console.log 'Data', data
  $('#coral').text JSON.stringify data
###

data = {}

emotionScale = d3.scale.linear()
  .domain [0,1]
  .range [0, 520]

frame = d3.select('#coral')

$(window).on 'load', ->



  $('#joy-button').on 'click', ->
    console.log 'joy-button!'
    data = _.sortBy(data, (d) ->
      -d.joy
    )
    vizData()

  $('#anger-button').on 'click', ->
    console.log 'anger-button!'
    data = _.sortBy(data, (d) ->
      -d.anger
    )
    vizData()

  $('#length-button').on 'click', ->
    console.log 'length-button!'
    data = _.sortBy(data, (d) ->
      #_.random(0,100)
      -d.body.length
    )
    vizData()



  d3.json "data/weed-comments-emotioned.json", (err, jsondata) ->

    data = jsondata
    #console.log "jsondata", data    

    data = data.map (obj, i) ->
      #console.log 'obj', obj
      return {
        body: obj.body
        anger: obj.emotionData.anger
        disgust: obj.emotionData.disgust
        fear: obj.emotionData.fear
        joy: obj.emotionData.joy
        sadness: obj.emotionData.sadness
        time: obj.date_created
      }

    
    data = _.sortBy(data, (d) ->
      -d.joy
    )
    

    console.log 'mapdata', data

    vizData()



vizData = ->
  $('#coral').empty()

  console.log data[0], data[3]
  console.log 'vizzing data'

  comments = frame.selectAll('.fingerprint')
  .data data
  .enter().append('div')
    .attr 'class', 'fingerprint'
    .attr 'title', (d,i) -> d.body
    #.text (d,i) -> JSON.stringify d.emotionData    

  anger = comments.append('div')
    .style 'background-color', '#ED4224'    
    .style 'width', (d,i) -> 
      emotionScale(d.anger) + 'px'
    .text 'anger'

  joy = comments.append('div')
    .style 'background-color', '#46CC69'    
    .style 'width', (d,i) -> 
      emotionScale(d.joy) + 'px'    
    .text 'joy'
    .style 'float', 'right'

  ###
  sadness = comments.append('div')
    .style 'background-color', '#33CCCC'    
    .style 'width', (d,i) -> 
      emotionScale(d.sadness) + 'px'
    .text 'sadness'

  disgust = comments.append('div')
    .style 'background-color', 'orange'    
    .style 'width', (d,i) -> 
      emotionScale(d.disgust) + 'px'
    .text 'disgust'

  fear = comments.append('div')
    .style 'background-color', 'yellow'    
    .style 'width', (d,i) -> 
      emotionScale(d.fear) + 'px'
    .text 'fear'

  joy = comments.append('div')
    .style 'background-color', 'green'    
    .style 'width', (d,i) -> 
      emotionScale(d.joy) + 'px'
    .text 'joy'
  ###



  $('.fingerprint').tipsy({gravity: 'e'})