.class public interface abstract Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;
.super Ljava/lang/Object;
.source "IMediaReceiver.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008f\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H&J \u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0007\u001a\u00020\u00052\u0006\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\tH&\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/camera/IMediaReceiver;",
        "",
        "onH264StreamData",
        "",
        "bytes",
        "",
        "onNv21Data",
        "data",
        "width",
        "",
        "height",
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
.method public abstract onH264StreamData([B)V
.end method

.method public abstract onNv21Data([BII)V
.end method
