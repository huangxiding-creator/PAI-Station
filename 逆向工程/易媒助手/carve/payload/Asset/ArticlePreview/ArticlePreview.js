function getBaijiaPreviewTimeStr() {
    var date = new Date();
    var currentdate = date.getHours() + ":" + date.getMinutes();
    return currentdate;
}

function getFullPreviewTimeStr() {
    var date = new Date();
    var currentdate = (date.getMonth() + 1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes();
    return currentdate;
}

function getWeixinPreviewTimeStr() {
    var date = new Date();
    var currentdate = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
    console.log(currentdate)
    return currentdate;
}

var ArticlePreview = {
    setContent: function(title, content, account, author, headimg, media) {
        document.getElementById("title").innerHTML = title;
        document.getElementById("account_name").innerHTML = account;
        document.getElementById("content").innerHTML = content;
        var authorEle = document.getElementById("author_name");
        if (authorEle)
            authorEle.innerHTML = author;
        document.getElementById("preview_time").innerHTML = this.getPreviewTimeStr(media);
        var imgEle = document.getElementById("account_img");
        //console.log(imgEle.imgEle.getElementsByTagName("img")[0])
        imgEle.getElementsByTagName("img")[0].setAttribute("src", headimg);
    },

    getPreviewTimeStr: function(media) {
        if (media == "toutiao")
            return "一分钟前";
        if (media == "baijia")
            return getBaijiaPreviewTimeStr();
        if (media == "yidian")
            return "一分钟前";
        if (media == "dayu")
            return getFullPreviewTimeStr();
        if (media == "weixin")
            return getWeixinPreviewTimeStr();
        if (media == "qie")
            return getFullPreviewTimeStr();
        if (media == "sohu")
            return "一分钟前";
        return "一分钟前";
    }   
}