var btn = document.querySelector('.little_menu_button');
if (!btn) return JSON.stringify({found: false});
btn.click();
return JSON.stringify({found: true, clicked: true});
