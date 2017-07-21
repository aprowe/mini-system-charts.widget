require('./assets/lib/piety')($, document)

# network Network widget
# Based on:
# Tsushin widget for ubersicht
# network network in kB
# Heavily inspired by Dion Munk's work network-network http://tracesof.net/uebersicht-widgets/#ubersicht-network-network

## Colors of chart
colors =
  in: 'rgb(170, 143, 190)'
  out: 'rgb(100,202,236)'

## Width of chart
chartWidth = 40

## Number of data points to on the chart
dataPointCount = 10

## Try 'line'!
chartType = 'bar'

chartIn = null
chartOut = null
valuesIn   = (0 for i in [0..dataPointCount])
valuesOut  = (0 for i in [0..dataPointCount])

command: """
if [ ! -e assets/network.sh ]; then
  "$PWD/mini-system-charts.widget/assets/network.sh"
else
  "$PWD/assets/network.sh"
fi
"""

# The refresh frequency in milliseconds
refreshFrequency: 2000

# Change container size to change the sizing of the chart
render: () -> """
<div class='network'>
  <div class='chart-in'></div>
  <div class='chart-out'></div>
  <div class='number'></div>
</div>
"""

update:(output,el) ->

  ## Initialize Charts
  if not chartIn or not chartOut
    chartIn = $(".chart-in", el).peity chartType,
      fill: [colors.in]
      stroke: [colors.in]
      width: chartWidth

    chartOut = $(".chart-out", el).peity chartType,
      fill: [colors.out]
      stroke: [colors.out]
      width: chartWidth


  @run '''
    if [ ! -e assets/network.sh ]; then
      "$PWD/mini-system-charts.widget/assets/network.sh"
    else
      "$PWD/assets/network.sh"
    fi
   ''', (err, output) ->
      data = output.split(" ");
      dataIn = parseFloat(data[0]);
      dataOut = parseFloat(data[1]);

      if isNaN(dataIn) or isNaN(dataOut)
        return

      ## Push the in value on the stack
      valuesIn.shift() if valuesIn.length >= dataPointCount
      valuesIn.push(dataIn)
      chartIn
        .text(valuesIn.join(","))
        .change()

      ## Push the out value on the stach
      valuesOut.shift() if valuesIn.length >= dataPointCount
      valuesOut.push(dataOut)
      chartOut
        .text(valuesOut.join(","))
        .change()

      ## Convert to kb instead of bytes
      dataIn = dataIn / 1000
      dataOut = dataOut / 1000
      units = 'kb'

      ## If value is large, convert to megabytes
      if dataIn > 1000 or dataOut > 1000
        dataIn /= 1000
        dataOut /= 1000
        units = 'mb'

      ## Round to one decimal place
      dataIn =  Math.round(dataIn * 10)/10
      dataOut = Math.round(dataOut * 10)/10

      $('.number', el).html "#{dataIn}<span style='color: #{colors.in}'>↓</span> #{dataOut}<span style='color: #{colors.out}'>↑</span> #{units}"

style: """
  left: 200px
  top: 7px

  color: white
  font: 12px Inconsolata, monospace, Helvetica Neue, sans-serif
  -webkit-font-smoothing: antialiased

  div
    display inline-block

  .number
    vertical-align top
    width 100px
"""
