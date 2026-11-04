.class public interface abstract Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;
.super Ljava/lang/Object;
.source "IFileOperate.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000@\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\'J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0007H&J\u0008\u0010\u0008\u001a\u00020\tH&J\u0008\u0010\n\u001a\u00020\tH&J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\'J\u0010\u0010\u000c\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0007H&JP\u0010\r\u001a\u00020\u00032\n\u0008\u0002\u0010\u000e\u001a\u0004\u0018\u00010\u000f2\u0006\u0010\u0010\u001a\u00020\u00112\u0006\u0010\u0004\u001a\u00020\u00052\'\u0010\u0012\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\t0\u0014\u00a2\u0006\u000c\u0008\u0015\u0012\u0008\u0008\u0016\u0012\u0004\u0008\u0008(\u0017\u0012\u0004\u0012\u00020\u00030\u0013H&\u00f8\u0001\u0000J\u0008\u0010\u0018\u001a\u00020\u0003H&\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;",
        "",
        "addFileReceiveListener",
        "",
        "listener",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
        "addFileReceiveV2Listener",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;",
        "isReceivingFile",
        "",
        "isSendingFile",
        "removeFileReceiveListener",
        "removeFileReceiveV2Listener",
        "sendFile",
        "dir",
        "",
        "file",
        "Ljava/io/File;",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
        "stopSendFile",
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
.method public abstract addFileReceiveListener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .annotation runtime Lkotlin/Deprecated;
        level = .enum Lkotlin/DeprecationLevel;->WARNING:Lkotlin/DeprecationLevel;
        message = "V2.1.4\u7248\u672c\u5e9f\u5f03,addFileReceiveV2Listener\u65b9\u6cd5"
        replaceWith = .subannotation Lkotlin/ReplaceWith;
            expression = "addFileReceiveV2Listener(listener)"
            imports = {}
        .end subannotation
    .end annotation
.end method

.method public abstract addFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
.end method

.method public abstract isReceivingFile()Z
.end method

.method public abstract isSendingFile()Z
.end method

.method public abstract removeFileReceiveListener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V
    .annotation runtime Lkotlin/Deprecated;
        level = .enum Lkotlin/DeprecationLevel;->WARNING:Lkotlin/DeprecationLevel;
        message = "V2.1.4\u7248\u672c\u5e9f\u5f03,removeFileReceiveV2Listener\u65b9\u6cd5"
        replaceWith = .subannotation Lkotlin/ReplaceWith;
            expression = "removeFileReceiveV2Listener(listener)"
            imports = {}
        .end subannotation
    .end annotation
.end method

.method public abstract removeFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V
.end method

.method public abstract sendFile(Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract stopSendFile()V
.end method
