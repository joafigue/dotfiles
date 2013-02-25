// Open buffers from previous session
require("session.js");
session_auto_save_auto_load = true;

// Middle button to follow link in new tab
require("clicks-in-new-buffer.js");
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;
clicks_in_new_buffer_button = 1; //  midclick links in new buffers with

// give me new tabs; open buffers (tabs) in the background
require("new-tabs.js");

// funky icons in the modeline
require("mode-line.js");

// FAVICONS
 require("favicon.js");
add_hook("mode_line_hook", mode_line_adder(buffer_icon_widget), true);
read_buffer_show_icons = true;

// but really we'd also like to know how many buffers are present and which is the current
add_hook("mode_line_hook", mode_line_adder(buffer_count_widget), true);

