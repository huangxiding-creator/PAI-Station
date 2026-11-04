.class public abstract Lcom/rokid/security/phone/sdk/api/filedownload/AbsFileDownloadService;
.super Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;
.source "AbsFileDownloadService.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008&\u0018\u00002\u00020\u00012\u00020\u0002B\u0005\u00a2\u0006\u0002\u0010\u0003\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/filedownload/AbsFileDownloadService;",
        "Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;",
        "Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;",
        "()V",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/base/MicroCaseService;-><init>()V

    return-void
.end method


# virtual methods
.method public cancelDownload()V
    .locals 0

    .line 5
    invoke-static {p0}, Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload$DefaultImpls;->cancelDownload(Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;)V

    return-void
.end method

.method public fileDownload(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
    .locals 0
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .line 5
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload$DefaultImpls;->fileDownload(Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V

    return-void
.end method
