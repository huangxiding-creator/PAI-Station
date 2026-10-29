UE.registerUI('orderList', function(editor, uiName) {
    //注册按钮执行时的command命令，使用命令默认就会带有回退操作
    editor.registerCommand(uiName, {
        execCommand: function() {
       
        }
    });

    //创建一个button
    var btn = new UE.ui.Button({
        //按钮的名字
        name: uiName,
        //提示
        title: '有序列表',
        //添加额外样式，指定icon图标
        cssRules: 'background-position: -80px 0;',
        //点击时执行的命令
        onclick: function() {
            editor.execCommand('insertorderedlist', null);
        }
    });

    //当点到编辑内容上时，按钮要做的状态反射
    editor.addListener('selectionchange', function() {
        var state = editor.queryCommandState('insertorderedlist');
        if (state == -1) {
            btn.setDisabled(true);
            btn.setChecked(false);
        }
        else {
            btn.setDisabled(false);
            btn.setChecked(state);
        }
    });
    
    //因为你是添加button,所以需要返回这个button
    return btn;
}, 3);