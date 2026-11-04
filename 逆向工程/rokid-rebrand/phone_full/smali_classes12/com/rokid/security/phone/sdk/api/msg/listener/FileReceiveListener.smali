.class public interface abstract Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
.super Ljava/lang/Object;
.source "FileReceiveListener.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0007\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0003\u0008f\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0010\u0010\u0004\u001a\u00020\u00032\u0006\u0010\u0005\u001a\u00020\u0006H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0010\u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\nH\u0016J \u0010\u0008\u001a\u00020\u00032\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000cH\u0016J\u0008\u0010\u000e\u001a\u00020\u0003H\u0016\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
        "",
        "onCancel",
        "",
        "onComplete",
        "filePath",
        "",
        "onFail",
        "onProgressChanged",
        "progress",
        "",
        "transferredBytes",
        "",
        "totalBytes",
        "onStart",
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
.method public abstract onCancel()V
.end method

.method public abstract onComplete(Ljava/lang/String;)V
.end method

.method public abstract onFail()V
.end method

.method public abstract onProgressChanged(F)V
.end method

.method public abstract onProgressChanged(FJJ)V
.end method

.method public abstract onStart()V
.end method
