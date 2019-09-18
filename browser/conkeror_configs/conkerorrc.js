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

// Delete google webjump
delete webjumps.google
// alias g to duckduckgo (for ease of typing)
webjumps.g = webjumps.duckduckgo

// XKCD FIX
xkcd_add_title = true;


// reload conkerorrc with C-c r
interactive("reload-config", "reload conkerorrc",
       function(I) {
          load_rc();
          I.window.minibuffer.message("config reloaded");
       }
);
define_key(default_global_keymap, "C-c r", "reload-config");

////////////////////////////////////////////////////////////
// SendtoKodi -- FUnctionality -try
////////////////////////////////////////////////////////////
interactive("Send-youtube-Kodi", "Send current page to Kodi",
            function(I) {
                var buffer_url =  I.buffer.display_uri_string
                var youtube_id = parseYoutubeUrlPlay(buffer_url)
                var plugin_id = sendYouTube(youtube_id);
                I.window.minibuffer.message(plugin_id);
            });
define_key(default_global_keymap, "C-c k", "Send-youtube-Kodi");

// Got from main.js function parseUrlPlay in firefox-send-to-xbmc/lib github tag  2.3.2
// - Modified to only parse and return the youtube video ID
function parseYoutubeUrlPlay(url) {
  var regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/;
  var match = url.match(regExp);
  if (match && match[2].length == 11) {
    return match[2];
  }
  var regExp2 = /^.*(youtube.com\/watch.*[\?\&]v=)([^#\&\?]*).*/;
  var match2 = url.match(regExp2);
  if (match2 && match2[2].length == 11) {
    return match2[2];
  }
}

function sendYouTube(ytid) {
    var url = 'plugin://plugin.video.youtube/?action=play_video&videoid=' + ytid;
    return prepareSend(url);

}

function prepareSend(fileurl) {
    return sendToXBMC(fileurl);
}


// //Send request to Kodi
function sendToXBMC(fileurl) {
    // Kodi-Global Variables
    var kodi_server = "192.168.1.103:8080"
    var kodi_user = "kodi_ctrl"
    var kodi_passwd = "jfkodi"
    var rurl = 'http://' + encodeURIComponent(kodi_user) + ':' + encodeURIComponent(kodi_passwd) + '@' + kodi_server + '/jsonrpc';
    //console.log(rurl);
    var senddata = {
        "jsonrpc":"2.0",
        "method":"Player.Open",
        "params": {
            "item":{
                "file":fileurl
            }
        },
        "id": 1
    };

    var xhr = new XMLHttpRequest();
    xhr.open('POST', rurl ,true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onload = function() {
        handleComplete(xhr.status)
    };

    xhr.send(JSON.stringify(senddata));

    return rurl

}

function message_handleComplete(resp) {
    var ret_message = handleComplete(resp);
}

//Handle return from XBMC
function handleComplete(resp) {
    //console.log(resp.status);
    var return_message = ''
    if (resp.status == 200) {
        if (resp.json && resp.json.result) {
            if (resp.json.result == 'OK') {
                return_message = 'Success -- Sent to kodi';
                return return_message;
            }
        }
        if (typeof resp.json.error !== 'undefined') {
            if (typeof resp.json.error.data !== 'undefined' && resp.json.error.data.stack.message) {
                return_message = 'Kodi Error ' + resp.json.error.code + 'Kodi reported: ' + resp.json.error.data.stack.message + ' -- error';
                return return_message;
            }
            if (typeof resp.json.error.message !== 'undefined') {
                return_message = 'Kodi Error ' + resp.json.error.code + 'Kodi reported: ' + resp.json.error.message + ' -- error';
                return return_message;
            }
            return_message = 'Kodi Error ' + 'Kodi reported error code ' + resp.json.error.code + ' -- error';
            return return_message;
        }
    }
    if (resp.status === 0) {
        return_message = 'Network error  -- Could not contact Kodi. Check your configuration. --error';
        return return_message;
    }
}



