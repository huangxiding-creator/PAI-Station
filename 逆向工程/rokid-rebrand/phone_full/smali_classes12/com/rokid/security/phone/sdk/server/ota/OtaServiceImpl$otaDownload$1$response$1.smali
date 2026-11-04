.class public final Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1;
.super Ljava/lang/Object;
.source "OtaServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0019\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0005H\u0016\u00a8\u0006\u0008"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1",
        "Lcom/rokid/security/phone/sdk/base/utils/net/DownloadListener;",
        "onProgress",
        "",
        "progress",
        "",
        "onResult",
        "status",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/api/base/DownloadListener;)V
    .locals 0
    .param p1, "$listener"    # Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    .line 598
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgress(I)V
    .locals 3
    .param p1, "progress"    # I

    .line 605
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onProgress: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 606
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onProgress(I)V

    .line 607
    return-void
.end method

.method public onResult(I)V
    .locals 3
    .param p1, "status"    # I

    .line 600
    sget-object v0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl;->getTAG()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onResult: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 601
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/ota/OtaServiceImpl$otaDownload$1$response$1;->$listener:Lcom/rokid/security/phone/sdk/api/base/DownloadListener;

    invoke-interface {v0, p1}, Lcom/rokid/security/phone/sdk/api/base/DownloadListener;->onResult(I)V

    .line 602
    return-void
.end method
