var img = document.querySelector('.little_menu_button_mp');
var btn = document.querySelector('.little_menu_button');
var target = img || btn;
if (!target) return JSON.stringify({found: false});
var r = target.getBoundingClientRect();
target.click();
return JSON.stringify({found: true, tag: target.tagName, x: Math.round(r.x), y: Math.round(r.y), clicked: true});
