.class public interface abstract Lcom/rokid/security/phone/sdk/api/msg/api/IMessage;
.super Ljava/lang/Object;
.source "IMessage.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/msg/api/IMessage$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000@\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0005\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0008\u0010\u0006\u001a\u00020\u0007H&J\u0008\u0010\u0008\u001a\u00020\tH&J\u0008\u0010\n\u001a\u00020\tH&J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J\u0010\u0010\u000c\u001a\u00020\u00032\u0006\u0010\r\u001a\u00020\u000eH&J\u0010\u0010\u000f\u001a\u00020\u00032\u0006\u0010\r\u001a\u00020\u000eH&J0\u0010\u0010\u001a\u00020\u00032\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u000e2\u0006\u0010\u0014\u001a\u00020\u00122\u000e\u0010\u0015\u001a\n\u0012\u0004\u0012\u00020\u0017\u0018\u00010\u0016H&J\u0010\u0010\u0018\u001a\u00020\u00032\u0006\u0010\u0019\u001a\u00020\u0012H&J\u001a\u0010\u001a\u001a\u00020\u00032\u0006\u0010\u0019\u001a\u00020\u00122\u0008\u0008\u0002\u0010\u0014\u001a\u00020\u0012H&J\u001a\u0010\u001b\u001a\u00020\u00032\u0006\u0010\u0019\u001a\u00020\u00122\u0008\u0008\u0002\u0010\u0014\u001a\u00020\u0012H&\u00a8\u0006\u001c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/msg/api/IMessage;",
        "",
        "addMessageListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;",
        "getApkFileOperator",
        "Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;",
        "getBtFileOperater",
        "Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;",
        "getFileOperater",
        "removeMessageListener",
        "sendAudioStreamDataByClassicBT",
        "streamData",
        "",
        "sendAudioStreamDataByP2P",
        "sendStreamData",
        "tag",
        "",
        "data",
        "clientId",
        "callback",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "",
        "sendTextMessageByBle",
        "message",
        "sendTextMessageByClassicBT",
        "sendTextMessageByP2P",
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
.method public abstract addMessageListener(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;)V
.end method

.method public abstract getApkFileOperator()Lcom/rokid/security/phone/sdk/api/filesystem/api/IApkFileOperate;
.end method

.method public abstract getBtFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;
.end method

.method public abstract getFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;
.end method

.method public abstract removeMessageListener(Lcom/rokid/security/phone/sdk/api/msg/listener/IMessageListener;)V
.end method

.method public abstract sendAudioStreamDataByClassicBT([B)V
.end method

.method public abstract sendAudioStreamDataByP2P([B)V
.end method

.method public abstract sendStreamData(Ljava/lang/String;[BLjava/lang/String;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "[B",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract sendTextMessageByBle(Ljava/lang/String;)V
.end method

.method public abstract sendTextMessageByClassicBT(Ljava/lang/String;Ljava/lang/String;)V
.end method

.method public abstract sendTextMessageByP2P(Ljava/lang/String;Ljava/lang/String;)V
.end method
