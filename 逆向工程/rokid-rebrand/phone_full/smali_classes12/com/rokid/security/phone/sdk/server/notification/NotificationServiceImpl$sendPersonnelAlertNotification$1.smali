.class public final Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;
.super Ljava/lang/Object;
.source "NotificationServiceImpl.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->sendPersonnelAlertNotification(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
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
        "com/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1",
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
.field final synthetic $ba2:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "[B>;"
        }
    .end annotation
.end field

.field final synthetic $callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $faceInfo:Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 0
    .param p1, "$faceInfo"    # Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;
    .param p2, "$ba2"    # Lkotlin/jvm/internal/Ref$ObjectRef;
    .param p3, "$callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "[B>;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$faceInfo:Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$ba2:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 5
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "errormsg"    # Ljava/lang/String;

    .line 100
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "sendFaceRecognizeNotification 1 failed "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x3a

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 101
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const/16 v1, -0x15

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u5934\u50cf\u6587\u4ef6\u53d1\u9001\u5931\u8d25"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v0, v1, v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 102
    return-void
.end method

.method public onSuccess(Ljava/lang/Boolean;)V
    .locals 8
    .param p1, "data"    # Ljava/lang/Boolean;

    .line 79
    const/4 v0, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 80
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->access$getTAG$p()Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "sendFaceRecognizeNotification 1 finished"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 81
    new-instance v0, Lcom/rokid/security/sdk/base/common/NotificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/NotificationExtra;-><init>()V

    .line 82
    .local v0, "notificationExtra":Lcom/rokid/security/sdk/base/common/NotificationExtra;
    const-string/jumbo v1, "sendFaceRecoNotice"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/NotificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 83
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$faceInfo:Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;

    invoke-virtual {v1, v2}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "SenderHandler.mGson.toJson(faceInfo)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/NotificationExtra;->setText(Ljava/lang/String;)V

    .line 84
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 85
    .local v1, "extra":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extra"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$ba2:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v3, v3, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    const-string v4, "ba2"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v5, v3

    check-cast v5, [B

    new-instance v3, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1$onSuccess$1;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    invoke-direct {v3, v4}, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1$onSuccess$1;-><init>(Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    move-object v7, v3

    check-cast v7, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const-string v3, "FACE_RECO_NOTICE_2"

    const-string v6, ""

    move-object v4, v1

    invoke-virtual/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendStreamData(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 97
    .end local v0    # "notificationExtra":Lcom/rokid/security/sdk/base/common/NotificationExtra;
    .end local v1    # "extra":Ljava/lang/String;
    :cond_0
    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/Object;

    .line 77
    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;->onSuccess(Ljava/lang/Boolean;)V

    return-void
.end method
