var row = document.querySelector('.menu_box_other_item_wrapper.account_info');
if (!row) return JSON.stringify({row: false});
var r = row.getBoundingClientRect();
if (r.width === 0) return JSON.stringify({row: true, visible: false});
row.click();
return JSON.stringify({row: true, visible: true, clicked: true});
