.class public final Lcom/rokid/security/sdk/ability/bean/WekWsResponse;
.super Ljava/lang/Object;
.source "VekWsResponse.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001c\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/bean/WekWsResponse;",
        "",
        "()V",
        "header",
        "Lcom/rokid/security/sdk/ability/bean/Header;",
        "getHeader",
        "()Lcom/rokid/security/sdk/ability/bean/Header;",
        "setHeader",
        "(Lcom/rokid/security/sdk/ability/bean/Header;)V",
        "payload",
        "Lcom/rokid/security/sdk/ability/bean/Payload;",
        "getPayload",
        "()Lcom/rokid/security/sdk/ability/bean/Payload;",
        "setPayload",
        "(Lcom/rokid/security/sdk/ability/bean/Payload;)V",
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


# instance fields
.field private header:Lcom/rokid/security/sdk/ability/bean/Header;

.field private payload:Lcom/rokid/security/sdk/ability/bean/Payload;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getHeader()Lcom/rokid/security/sdk/ability/bean/Header;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->header:Lcom/rokid/security/sdk/ability/bean/Header;

    return-object v0
.end method

.method public final getPayload()Lcom/rokid/security/sdk/ability/bean/Payload;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->payload:Lcom/rokid/security/sdk/ability/bean/Payload;

    return-object v0
.end method

.method public final setHeader(Lcom/rokid/security/sdk/ability/bean/Header;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/bean/Header;

    .line 11
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->header:Lcom/rokid/security/sdk/ability/bean/Header;

    return-void
.end method

.method public final setPayload(Lcom/rokid/security/sdk/ability/bean/Payload;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/ability/bean/Payload;

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/WekWsResponse;->payload:Lcom/rokid/security/sdk/ability/bean/Payload;

    return-void
.end method
