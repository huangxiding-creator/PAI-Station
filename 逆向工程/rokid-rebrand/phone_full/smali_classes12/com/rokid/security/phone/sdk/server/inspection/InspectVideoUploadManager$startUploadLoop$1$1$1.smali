.class public final Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;
.super Ljava/lang/Object;
.source "InspectVideoUploadManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
        "Ljava/lang/Boolean;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000#\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005*\u0001\u0000\u0008\n\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001J!\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016\u00a2\u0006\u0002\u0010\tJ\u0017\u0010\n\u001a\u00020\u00042\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0002H\u0016\u00a2\u0006\u0002\u0010\u000c\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
        "onFailed",
        "",
        "code",
        "",
        "errormsg",
        "",
        "(Ljava/lang/Integer;Ljava/lang/String;)V",
        "onSuccess",
        "data",
        "(Ljava/lang/Boolean;)V",
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
.field final synthetic $nextVideo:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;)V
    .locals 0
    .param p1, "$nextVideo"    # Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;->$nextVideo:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 2
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "errormsg"    # Ljava/lang/String;

    .line 74
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;->$nextVideo:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->setUploading(Z)V

    .line 75
    return-void
.end method

.method public onSuccess(Ljava/lang/Boolean;)V
    .locals 2
    .param p1, "data"    # Ljava/lang/Boolean;

    .line 70
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;->$nextVideo:Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/VideoQueueItem;->setUploading(Z)V

    .line 71
    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/Object;

    .line 68
    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/inspection/InspectVideoUploadManager$startUploadLoop$1$1$1;->onSuccess(Ljava/lang/Boolean;)V

    return-void
.end method
