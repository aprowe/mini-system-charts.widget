require('./assets/lib/piety')($, document)

## Colors Used by the chart
colors =
  free: 'rgb(133, 188, 86)'
  taken: 'rgba(0,0,0,0.3)'

# Try 'donut'
chartType   = 'pie'

## Width of the chart
chartWidth  = 15

# Which disk to show a chart for
diskIndex    = 0

# Use base 10 numbers, i.e. 1GB = 1000MB. Leave this true to show disk sizes as
# OS X would (since Snow Leopard)
base10       = true

# Max size in (GB) you want to compare your free space to be
# if set to null, compares to your total size
# (I found I never have more than 50GB, so I set it to that)
maxFreeSpace      = null

command: "df -#{if base10 then 'H' else 'h'} | grep '/dev/' | while read -r line; do fs=$(echo $line | awk '{print $1}'); name=$(diskutil info $fs | grep 'Volume Name' | awk '{print substr($0, index($0,$3))}'); echo $(echo $line | awk '{print $2, $3, $4, $5}') $(echo $name | awk '{print substr($0, index($0,$1))}'); done"

refreshFrequency: 20000

render: ()-> """
  <div class="disk-info">
    <span class='chart'></span>
    <span class='number'></span>
  </div>
"""

update: (output, el) ->
  disks = output.split('\n')

  # ## Get one disk to show stats for
  disk = disks[diskIndex]

  ## ex. disk = "379G 346G 33G 92% Macintosh HD"
  args = disk.split(' ')

  ## Get variables from args
  [total, used, free, pctg] = args;

  ## Take out Units
  freeNum  = free.replace(/G|Gi/, '');
  totalNum = total.replace(/G|Gi/, '');

  maxFreeSpace = totalNum if not maxFreeSpace?

  ## Set text to free + inactive
  $(".number", el).text(free)

  ## Set chart up
  $('.chart', el).html("#{freeNum}/#{maxFreeSpace}").peity chartType,
    fill: [colors.free, colors.taken]
    width: chartWidth

style: """
  left: 150px
  top: 7px

  color: white
  font: 12px Inconsolata, monospace, Helvetica Neue, sans-serif
  -webkit-font-smoothing: antialiased

  .number
    vertical-align top

  .chart
    vertical-align top
  """
