UE.registerUI('insertImg', function(editor, uiName) {
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
        title: '插入图片',
        //添加额外样式，指定icon图标
        cssRules: 'background-position: -380px 0;',
        //点击时执行的命令
        onclick: function() {
            window.JsInsertImg();
        }
    });

    //因为你是添加button,所以需要返回这个button
    return btn;
}, 6);