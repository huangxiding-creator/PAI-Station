.class public final Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload$DefaultImpls;
.super Ljava/lang/Object;
.source "IFileDownload.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static cancelDownload(Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;

    .line 22
    return-void
.end method

.method public static fileDownload(Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/api/filedownload/IFileDownload;
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    const-string/jumbo v0, "url"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "filePath"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "listener"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 16
    return-void
.end method
