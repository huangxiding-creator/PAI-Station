.class public interface abstract Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;
.super Ljava/lang/Object;
.source "OkHttpSSEClient.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "SSECallback"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0003\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\u0008f\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H&J\u0008\u0010\u0004\u001a\u00020\u0003H&J\u0008\u0010\u0005\u001a\u00020\u0003H&J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u0008H&J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\n\u001a\u00020\u000bH&\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/OkHttpSSEClient$SSECallback;",
        "",
        "onClosed",
        "",
        "onComplete",
        "onConnected",
        "onError",
        "t",
        "",
        "onMessage",
        "data",
        "",
        "sdk-common-ability_release"
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
.method public abstract onClosed()V
.end method

.method public abstract onComplete()V
.end method

.method public abstract onConnected()V
.end method

.method public abstract onError(Ljava/lang/Throwable;)V
.end method

.method public abstract onMessage(Ljava/lang/String;)V
.end method
