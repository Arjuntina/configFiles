# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile import *
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.command.client import InteractiveCommandClient

mod = "mod4"           # Windows key, used for basically everything
mod2 = "mod1"          # Alt key, not really used but good to define in case 
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "i", lazy.window.bring_to_front()),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating behavior of a window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen behavior of a window"), 
    # Move windows up or down in current stack
    Key([mod, 'mod1'], 'Tab', lazy.layout.shuffle_down()),
    Key([mod, 'mod1', 'shift'], 'Tab', lazy.layout.shuffle_up()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    #Key(
    #    [mod, "shift"],
    #    "Return",
    #    lazy.layout.toggle_split(),
    #    desc="Toggle between split and unsplit sides of stack",
    #),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Toggle between layouts in the other direction"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"), 
]

groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
	    Key(
		[mod],
		i.name,
		lazy.group[i.name].toscreen(),
		desc="Switch to group {}".format(i.name),
	    ),
	    # mod1 + ctrl + letter of group = switch to & move focused window to group
	    Key(
		[mod, "shift"],
		i.name,
		lazy.window.togroup(i.name, switch_group=True),
		desc="Switch to & move focused window to group {}".format(i.name),
	    ),
	    # Or, use below if you prefer not to switch to that group.
	    # # mod1 + ctrl + letter of group = move focused window to group
	    # Key([mod, "ctrl"], i.name, lazy.window.togroup(i.name),
	    #     desc="move focused window to group {}".format(i.name)),
	]
    )

layouts = [
    layout.Columns(border_focus="#fb7113c0", border_focus_stack="#fb7113c0", border_width=2, border_on_single=True, margin=6),
    layout.Columns(border_width=0, margin=0),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    #layout.Bsp(),
    #layout.Matrix(),
    #layout.MonadTall(),
    #layout.MonadWide(),
    #layout.RatioTile(),
    #layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
]

# WIDGETS
widget_defaults = dict(
    font="FiraCode Nerd Font Mono",
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

importantColorDict={
    "clockBgColor" : "b74485ff",
    "batteryBgColor" :  "7c9854ff",
    "wifiBgColor" :  "3a7b75ff",
    "volBgColor" :  "ce8f00ff",
    "groupBgColor" : "00000000",
    "weatherBgColor" : "8c6c6bd9",
    "windowBgColor" : "2a3137ff"
}

# right arrow widget
def right_arrow(bg_color, fg_color):
    return widget.TextBox(text='\ue602', padding=0, fontsize=24, background=bg_color, foreground=fg_color)

# left arrow widget
def left_arrow(bg_color, fg_color):
    return widget.TextBox(text="\U000f0731", fontsize=45, padding=0, background=bg_color, foreground=fg_color, width=13)

# Battery widget
def generateBattery():
    return widget.Battery(
        format=' {char} {percent:2.0%} ',
	low_percentage=0.25,
	low_foreground="b30000c5",
	background="7c9854ff",
	padding=0,
	charge_char="\U000f0084",
	discharge_char="\U000f0079",
	mouse_callbacks={"Button1":lazy.widget['battery'].function(changeBatteryFmt)},
    )

def changeBatteryFmt(widget):
    if widget.format == ' {char} {percent:2.0%} ':
        widget.format = ' {char} {percent:2.0%}, {hour:d}:{min:02d}, {watt:.2f} W '
    else:
	    widget.format = ' {char} {percent:2.0%} '
    widget.update(widget.poll())
    widget.bar.draw()

def expandedBatteryFmt(widget):
    widget.format = ''
    # change battery format whether charging or not? seems complex to integrate but maybe one day :)

batteryToDisplay = generateBattery()

# Weather Widget -- fix and get icons working!! (emoji font didn't work :( )
def weatherWidget():
    return widget.Wttr(
        location={'Boston':'Boston'}, 
	units='u', 
	format='%l: %t',
	background=importantColorDict["weatherBgColor"],
	#font='RobotoMono Nerd Font Mono',
    )

weatherToDisplay = weatherWidget()

# TaskList widget
def my_func(text):
    #locOfDash = text.find("—")
    #if (locOfDash > 0):
    #    return text[locOfDash+2:]
    #return text
    return ""



screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(filename="~/.config/qtile/config1/archLogo.png", margin=1.75, margin_x=3, background=importantColorDict["windowBgColor"], mouse_callbacks={"Button1": lazy.spawn("alacritty --hold -e neofetch")}),
                right_arrow(importantColorDict["groupBgColor"], importantColorDict["windowBgColor"]),
		widget.Spacer(length=5, background=importantColorDict["groupBgColor"]),
		widget.CurrentLayoutIcon(scale=0.8, background=importantColorDict["groupBgColor"]),
		widget.GroupBox(highlight_method='line', disable_drag=True, background=importantColorDict["groupBgColor"]),
		right_arrow(importantColorDict["windowBgColor"],importantColorDict["groupBgColor"]),
		widget.Prompt(),
		widget.Spacer(length=5, background=importantColorDict["windowBgColor"]),
		widget.TaskList(background=importantColorDict["windowBgColor"], txt_floating="", txt_maximized="", txtminimized="", parse_text=my_func),
		left_arrow(importantColorDict["windowBgColor"], importantColorDict["weatherBgColor"]),
		weatherToDisplay,
		left_arrow(importantColorDict["weatherBgColor"], importantColorDict["volBgColor"]),
		widget.Spacer(length=2, background=importantColorDict["volBgColor"]),
		widget.TextBox(text='\U000f057e', padding=0, fontsize=18, background=importantColorDict["volBgColor"], mouse_callbacks={"Button1": lazy.spawn("alacritty -e pulsemixer")}),
		widget.PulseVolume(fmt='{}', fontsize=13, padding=9, mouse_callbacks={"Button1": lazy.spawn("alacritty -e pulsemixer")}, background=importantColorDict["volBgColor"]),
		widget.TextBox(text='\U000f00de', padding=0, fontsize=18, background=importantColorDict["volBgColor"]),
		widget.Backlight(backlight_name='intel_backlight', format='{percent:2.0%}', background=importantColorDict["volBgColor"], padding=9, mouse_callbacks={"Button1": lazy.spawn("alacritty --hold -e backlight_control")}),
		left_arrow(importantColorDict["volBgColor"],importantColorDict["wifiBgColor"]),
		widget.WidgetBox(widgets=[
                    widget.Wlan(background=importantColorDict["wifiBgColor"], mouse_callbacks={"Button1": lazy.spawn("alacritty -e nmtui")}),
		    widget.Net(background=importantColorDict["wifiBgColor"], format='{down} ↓↑ {up}'),
		    widget.NetGraph(background=importantColorDict["wifiBgColor"]),
		    widget.Spacer(length=1, background=importantColorDict["wifiBgColor"]),
		],
                                 background=importantColorDict["wifiBgColor"], text_closed=" Wi-fi ", text_open=" \U000f05a9 "
		),
		left_arrow(importantColorDict["wifiBgColor"],importantColorDict["batteryBgColor"]),
		batteryToDisplay,
		left_arrow(importantColorDict["batteryBgColor"],importantColorDict["clockBgColor"]),
		widget.Clock(format="%H:%M %m/%d/%y", background=importantColorDict["clockBgColor"], font='FiraCode Nerd Font Mono', fontsize=13, padding=5),
            ],
	    24,
	    # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
	    # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
	),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod, "shift"], "Button1", lazy.window.set_size_floating(), start=lazy.window.get_size()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
	*layout.Floating.default_float_rules,
	Match(wm_class="confirmreset"),  # gitk
	Match(wm_class="makebranch"),  # gitk
	Match(wm_class="maketag"),  # gitk
	Match(wm_class="ssh-askpass"),  # ssh-askpass
	Match(title="branchdialog"),  # gitk
	Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# @hook.subscribe.startup_once
#def autostart():
#    home = os.path.expanduser('~/.config/qtile/autostart.sh')
#    subprocess.Popen([home])
