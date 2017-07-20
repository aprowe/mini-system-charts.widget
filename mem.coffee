require('./assets/lib/piety')($, document)

## Memory Usage Widget
## By default displays the free Memory, inactive memory and active memory
## Based

## Colors Used by the chart
colors =
  free: 'rgb(133, 188, 86)'
  inactive: 'orange'
  active: 'rgba(0,0,0,0.3)'

##  Width of the chart
chartWidth = 15

## Try 'pie'
chartType = 'donut'

refreshFrequency: 2000 # ms

command: """vm_stat | perl -ne '/page size of (\\d+)/ and $size=$1; /Pages\\s+([^:]+)[^\\d]+(\\d+)/ and printf("%s:%i,", "$1", $2 * $size / 1048576);'"""

render: (output) ->
  """
  <div class="mem">
    <span class="chart"></span>
    <span class='number'></span>
  </div>
  """

update: (output, el) ->
  ## Memory object
  mem = {}

  # Output looks similar to this:
  # free:1234,inactive:2345,active:3456
  output.split(',').forEach (item)->
    [key, value] = item.split(':')
    mem[key] = Number(value)

  ## Set text to free + inactive
  $(".mem .number", el).text("  #{mem.free + mem.inactive}mb")

  ## Display active, free, and inactive on the chart
  $(".mem .chart", el).text("#{mem.active},#{mem.free},#{mem.inactive}").peity chartType,
    fill: [colors.active, colors.free, colors.inactive]
    width: chartWidth


style: """
  left: 75px
  top: 7px

  color: white
  font: 12px Inconsolata, monospace, Helvetica Neue, sans-serif
  -webkit-font-smoothing: antialiased

  .number
    vertical-align top

  .chart
    vertical-align top
"""
