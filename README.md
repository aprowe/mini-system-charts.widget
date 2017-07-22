# Mini System Info Charts!
## An Übertsicht Widet

Mini System Info Charts are small [Übersicht](http://tracesof.net/uebersicht/) widgets using [Peity](https://github.com/benpickles/peity).
They are broken down into individual widgets and each have several options for cusomization.

![img.png](images/img1.png)

#### Widget Displays:
- **CPU Usage**
- **RAM Usage**  
- **Disk Usage**
- **Network Traffic**

#### A couple notes
- For the RAM usage, it currently adds up inactive + free memory and compares it to active memory.
There were many other types of ram, so I am not sure if this is the best representation of
performance.
- For Disk usage, it defaults to comparing free-space vs total-space. There is a variable that allows you
to set the total to a smaller value, to make the chart more interesting.

### Attribution
The widgets use scripts from the following repos:
- [tsushin](https://github.com/louixs/tsushin)
- [Disk Usage Bar Widget](https://github.com/onishy/Ubersicht-DiskUsage-bar)
- [zenbar](https://github.com/Amar1729/nerdbar.widget)

Much credit goes to these repositories, thanks!

## Installation
Make sure you have Übersicht installed, and then clone this repository.
IMPORTANT: Make sure you name the resulting folder mini-system-charts.widget, or change the paths in the network scripts (assets/network.sh and network.coffee), since they use the parent directory's name.

```bash
# or wherever your ubersicht looks for widgets (mine looks in ~/.config/ubersicht/widgets/)
git clone https://github.com/aprowe/mini-system-charts.widget $HOME/Library/Application\ Support/Übersicht/widgets/mini-system-charts.widget
```

### Customization
I put the most interesting changes at the top of each widget in global variables, such as color,
chart size, and chart type.

**Feel free to make pull requests with more mini-charts!**
