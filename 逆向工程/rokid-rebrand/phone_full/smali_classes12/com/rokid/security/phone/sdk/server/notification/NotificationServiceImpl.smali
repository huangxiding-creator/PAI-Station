.class public final Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;
.super Lcom/rokid/security/phone/sdk/api/notification/api/AbsNotificationService;
.source "NotificationServiceImpl.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0000\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J.\u0010\t\u001a\u00020\u00062\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\u000b2\u0006\u0010\r\u001a\u00020\u000e2\u000c\u0010\u000f\u001a\u0008\u0012\u0004\u0012\u00020\u00110\u0010H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;",
        "Lcom/rokid/security/phone/sdk/api/notification/api/AbsNotificationService;",
        "()V",
        "TAG",
        "",
        "sendNotification",
        "",
        "bean",
        "Lcom/rokid/security/sdk/base/common/notifacation/NotificationMessage;",
        "sendPersonnelAlertNotification",
        "face1",
        "Landroid/graphics/Bitmap;",
        "face2",
        "faceInfo",
        "Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
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


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;

.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;

    .line 23
    const-string v0, "NotificationService::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/api/notification/api/AbsNotificationService;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 20
    sget-object v0, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->TAG:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public sendNotification(Lcom/rokid/security/sdk/base/common/notifacation/NotificationMessage;)V
    .locals 10
    .param p1, "bean"    # Lcom/rokid/security/sdk/base/common/notifacation/NotificationMessage;

    const-string v0, "bean"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    new-instance v0, Lcom/rokid/security/sdk/base/common/NotificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/NotificationExtra;-><init>()V

    .line 29
    .local v0, "notificationExtra":Lcom/rokid/security/sdk/base/common/NotificationExtra;
    const-string/jumbo v1, "sendNotification"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/NotificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 30
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, p1}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "SenderHandler.mGson.toJson(bean)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/NotificationExtra;->setText(Ljava/lang/String;)V

    .line 31
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 32
    .local v1, "str":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "sendNotification str:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v2, v3}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 33
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string/jumbo v3, "str"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "NOTIFICATION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 34
    return-void
.end method

.method public sendPersonnelAlertNotification(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .locals 10
    .param p1, "face1"    # Landroid/graphics/Bitmap;
    .param p2, "face2"    # Landroid/graphics/Bitmap;
    .param p3, "faceInfo"    # Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;
    .param p4, "callback"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/graphics/Bitmap;",
            "Landroid/graphics/Bitmap;",
            "Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    const-string v0, "face1"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "face2"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "faceInfo"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "callback"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 46
    const/16 v0, 0x50

    invoke-static {p1, v0}, Lcom/rokid/security/phone/sdk/server/track/BitmapUtils;->getBitmapByteArray(Landroid/graphics/Bitmap;I)[B

    move-result-object v1

    .line 47
    .local v1, "ba1":[B
    new-instance v2, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v2}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    .local v2, "ba2":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-static {p2, v0}, Lcom/rokid/security/phone/sdk/server/track/BitmapUtils;->getBitmapByteArray(Landroid/graphics/Bitmap;I)[B

    move-result-object v0

    iput-object v0, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 48
    const-string/jumbo v0, "\u538b\u7f29\u5931\u8d25"

    const/4 v3, -0x1

    .line 49
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    .line 48
    if-eqz v1, :cond_6

    iget-object v4, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    if-nez v4, :cond_0

    goto/16 :goto_2

    .line 52
    :cond_0
    array-length v4, v1

    iget-object v5, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v5, [B

    array-length v5, v5

    add-int/2addr v4, v5

    const v5, 0x7d000

    if-le v4, v5, :cond_5

    .line 53
    const/16 v4, 0x32

    invoke-static {p1, v4}, Lcom/rokid/security/phone/sdk/server/track/BitmapUtils;->getBitmapByteArray(Landroid/graphics/Bitmap;I)[B

    move-result-object v1

    .line 54
    invoke-static {p2, v4}, Lcom/rokid/security/phone/sdk/server/track/BitmapUtils;->getBitmapByteArray(Landroid/graphics/Bitmap;I)[B

    move-result-object v4

    iput-object v4, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 55
    if-eqz v1, :cond_4

    iget-object v4, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    if-nez v4, :cond_1

    goto :goto_1

    .line 59
    :cond_1
    array-length v4, v1

    iget-object v6, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v6, [B

    array-length v6, v6

    add-int/2addr v4, v6

    if-le v4, v5, :cond_5

    .line 60
    const/16 v4, 0x1e

    invoke-static {p1, v4}, Lcom/rokid/security/phone/sdk/server/track/BitmapUtils;->getBitmapByteArray(Landroid/graphics/Bitmap;I)[B

    move-result-object v1

    .line 61
    invoke-static {p2, v4}, Lcom/rokid/security/phone/sdk/server/track/BitmapUtils;->getBitmapByteArray(Landroid/graphics/Bitmap;I)[B

    move-result-object v4

    iput-object v4, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 62
    if-eqz v1, :cond_3

    iget-object v4, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    if-nez v4, :cond_2

    goto :goto_0

    .line 66
    :cond_2
    array-length v0, v1

    iget-object v3, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v3, [B

    array-length v3, v3

    add-int/2addr v0, v3

    const v3, 0x4b000

    if-le v0, v3, :cond_5

    .line 67
    const/4 v0, -0x2

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string/jumbo v3, "\u56fe\u7247\u592a\u5927\uff0c\u8bf7\u8c03\u6574"

    invoke-interface {p4, v0, v3}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 68
    return-void

    .line 63
    :cond_3
    :goto_0
    invoke-interface {p4, v3, v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 64
    return-void

    .line 56
    :cond_4
    :goto_1
    invoke-interface {p4, v3, v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 57
    return-void

    .line 72
    :cond_5
    new-instance v0, Lcom/rokid/security/sdk/base/common/NotificationExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/NotificationExtra;-><init>()V

    .line 73
    .local v0, "notificationExtra":Lcom/rokid/security/sdk/base/common/NotificationExtra;
    const-string/jumbo v3, "sendFaceRecoNotice"

    invoke-virtual {v0, v3}, Lcom/rokid/security/sdk/base/common/NotificationExtra;->setMethodName(Ljava/lang/String;)V

    .line 74
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v3, p3}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "SenderHandler.mGson.toJson(faceInfo)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Lcom/rokid/security/sdk/base/common/NotificationExtra;->setText(Ljava/lang/String;)V

    .line 75
    sget-object v3, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v3

    invoke-virtual {v3, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 76
    .local v3, "extra":Ljava/lang/String;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u538b\u7f29\u540e\u5934\u50cf\u6587\u4ef6 "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    array-length v6, v1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    const/16 v6, 0x20

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v6, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v6, [B

    array-length v6, v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 77
    sget-object v4, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v5, "extra"

    invoke-static {v3, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v5, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;

    invoke-direct {v5, p3, v2, p4}, Lcom/rokid/security/phone/sdk/server/notification/NotificationServiceImpl$sendPersonnelAlertNotification$1;-><init>(Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    move-object v9, v5

    check-cast v9, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    const-string v5, "FACE_RECO_NOTICE_1"

    const-string v8, ""

    move-object v6, v3

    move-object v7, v1

    invoke-virtual/range {v4 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendStreamData(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V

    .line 104
    return-void

    .line 49
    .end local v0    # "notificationExtra":Lcom/rokid/security/sdk/base/common/NotificationExtra;
    .end local v3    # "extra":Ljava/lang/String;
    :cond_6
    :goto_2
    invoke-interface {p4, v3, v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;->onFailed(Ljava/lang/Integer;Ljava/lang/String;)V

    .line 50
    return-void
.end method
