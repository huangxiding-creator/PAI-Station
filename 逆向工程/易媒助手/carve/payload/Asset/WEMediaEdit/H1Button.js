UE.registerUI('h1button', function(editor, uiName) {
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
        title: 'h1标题',
        //添加额外样式，指定icon图标，这里默认使用一个重复的icon
        cssRules: 'background-position: -200px 0;',
        //点击时执行的命令
        onclick: function() {
            var state = editor.queryCommandValue('Paragraph');
            if (state == 'h1') 
                editor.execCommand('Paragraph','p');
            else
                editor.execCommand('Paragraph','h1');
            
        }
    });

    //当点到编辑内容上时，按钮要做的状态反射
    editor.addListener('selectionchange', function() {
        var state = editor.queryCommandValue('Paragraph');
        if (state == 'h1') {
            btn.setChecked(true);
        } else {
            btn.setChecked(false);
        }
    });
    
    //因为你是添加button,所以需要返回这个button
    return btn;
}, 0);