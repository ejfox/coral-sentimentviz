var data,emotionScale,frame,vizData;data={},emotionScale=d3.scale.linear().domain([0,1]).range([0,520]),frame=d3.select("#coral"),$(window).on("load",function(){return $("#joy-button").on("click",function(){return console.log("joy-button!"),data=_.sortBy(data,function(t){return-t.joy}),vizData()}),$("#anger-button").on("click",function(){return console.log("anger-button!"),data=_.sortBy(data,function(t){return-t.anger}),vizData()}),$("#length-button").on("click",function(){return console.log("length-button!"),data=_.sortBy(data,function(t){return-t.body.length}),vizData()}),d3.json("data/weed-comments-emotioned.json",function(t,a){return data=a,data=data.map(function(t,a){return{body:t.body,anger:t.emotionData.anger,disgust:t.emotionData.disgust,fear:t.emotionData.fear,joy:t.emotionData.joy,sadness:t.emotionData.sadness,time:t.date_created}}),data=_.sortBy(data,function(t){return-t.joy}),console.log("mapdata",data),vizData()})}),vizData=function(){var t,a,n;return $("#coral").empty(),console.log(data[0],data[3]),console.log("vizzing data"),a=frame.selectAll(".fingerprint").data(data).enter().append("div").attr("class","fingerprint").attr("title",function(t,a){return t.body}),t=a.append("div").style("background-color","#ED4224").style("width",function(t,a){return emotionScale(t.anger)+"px"}).text("anger"),n=a.append("div").style("background-color","#46CC69").style("width",function(t,a){return emotionScale(t.joy)+"px"}).text("joy").style("float","right"),$(".fingerprint").tipsy({gravity:"e"})};