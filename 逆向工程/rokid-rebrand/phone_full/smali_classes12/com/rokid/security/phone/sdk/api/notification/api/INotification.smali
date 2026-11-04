.class public interface abstract Lcom/rokid/security/phone/sdk/api/notification/api/INotification;
.super Ljava/lang/Object;
.source "INotification.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J.\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\u00082\u0006\u0010\n\u001a\u00020\u000b2\u000c\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u000e0\rH&\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/notification/api/INotification;",
        "",
        "sendNotification",
        "",
        "bean",
        "Lcom/rokid/security/sdk/base/common/notifacation/NotificationMessage;",
        "sendPersonnelAlertNotification",
        "face1",
        "Landroid/graphics/Bitmap;",
        "face2",
        "msg",
        "Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
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
.method public abstract sendNotification(Lcom/rokid/security/sdk/base/common/notifacation/NotificationMessage;)V
.end method

.method public abstract sendPersonnelAlertNotification(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;Lcom/rokid/security/sdk/base/common/notifacation/PersonnelAlertMessage;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
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
.end method
