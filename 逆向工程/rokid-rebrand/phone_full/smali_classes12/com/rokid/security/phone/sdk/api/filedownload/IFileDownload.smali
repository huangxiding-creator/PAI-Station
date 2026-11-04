.class public interface abstract Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;
.super Ljava/lang/Object;
.source "IFileDownload.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J \u0010\u0004\u001a\u00020\u00032\u0006\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00062\u0006\u0010\u0008\u001a\u00020\tH\u0016J\u0010\u0010\n\u001a\u00020\u000b2\u0006\u0010\u0005\u001a\u00020\u0006H&\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;",
        "",
        "cancelDownload",
        "",
        "fileDownload",
        "url",
        "",
        "filePath",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/base/DownloadListener;",
        "getDownloadFileApi",
        "Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# virtual methods
.method public abstract cancelDownload()V
.end method

.method public abstract fileDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
.end method

.method public abstract getDownloadFileApi(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/filedownload/AppDownloadInfo;
.end method
