local application = require "mjolnir.application"
local window = require "mjolnir.window"
local hotkey = require "mjolnir.hotkey"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"
local grid = require "mjolnir.sd.grid"
grid.GRIDWIDTH = 6
grid.MARGINX = 0
grid.MARGINY = 0

local mash = {"cmd", "alt", "ctrl"}
local shiftMash = {"cmd", "shift", "ctrl"}

hotkey.bind(mash, 'V', grid.maximize_window)
hotkey.bind(mash, 'E', grid.pushwindow_nextscreen)

hotkey.bind(shiftMash, 'LEFT', grid.pushwindow_left)
hotkey.bind(shiftMash, 'RIGHT', grid.pushwindow_right)
hotkey.bind(mash, 'DOWN', grid.pushwindow_down)
hotkey.bind(mash, 'UP', grid.pushwindow_up)


hotkey.bind(mash, 'RIGHT', grid.resizewindow_wider)
hotkey.bind(mash, 'LEFT', grid.resizewindow_thinner)

hotkey.bind(shiftMash, 'DOWN', grid.resizewindow_taller)
hotkey.bind(shiftMash, 'UP', grid.resizewindow_taller)

alert.show("Mjolnir, at your service.")
