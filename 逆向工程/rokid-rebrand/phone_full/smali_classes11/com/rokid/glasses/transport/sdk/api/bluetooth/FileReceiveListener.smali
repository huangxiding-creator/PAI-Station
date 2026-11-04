.class public interface abstract Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
.super Ljava/lang/Object;
.source "FileReceiveListener.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0002\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "",
        "onCancel",
        "",
        "filePath",
        "",
        "onComplete",
        "onFail",
        "onProgressChanged",
        "progress",
        "",
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
.method public abstract onCancel(Ljava/lang/String;)V
.end method

.method public abstract onComplete(Ljava/lang/String;)V
.end method

.method public abstract onFail()V
.end method

.method public abstract onProgressChanged(Ljava/lang/String;F)V
.end method

.method public abstract onStart(Ljava/lang/String;)V
.end method
