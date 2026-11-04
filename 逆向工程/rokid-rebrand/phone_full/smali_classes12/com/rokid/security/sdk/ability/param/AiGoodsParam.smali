.class public final Lcom/rokid/security/sdk/ability/param/AiGoodsParam;
.super Ljava/lang/Object;
.source "AiChatParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0011\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008R\u001c\u0010\u000f\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/AiGoodsParam;",
        "",
        "()V",
        "file64",
        "",
        "getFile64",
        "()Ljava/lang/String;",
        "setFile64",
        "(Ljava/lang/String;)V",
        "imageUrl",
        "getImageUrl",
        "setImageUrl",
        "promptType",
        "getPromptType",
        "setPromptType",
        "sessionId",
        "getSessionId",
        "setSessionId",
        "text",
        "getText",
        "setText",
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
.field private file64:Ljava/lang/String;

.field private imageUrl:Ljava/lang/String;

.field private promptType:Ljava/lang/String;

.field private sessionId:Ljava/lang/String;

.field private text:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const-string v0, "customsGoods"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->promptType:Ljava/lang/String;

    .line 20
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->text:Ljava/lang/String;

    .line 21
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->imageUrl:Ljava/lang/String;

    .line 22
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->file64:Ljava/lang/String;

    .line 18
    return-void
.end method


# virtual methods
.method public final getFile64()Ljava/lang/String;
    .locals 1

    .line 22
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->file64:Ljava/lang/String;

    return-object v0
.end method

.method public final getImageUrl()Ljava/lang/String;
    .locals 1

    .line 21
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->imageUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getPromptType()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->promptType:Ljava/lang/String;

    return-object v0
.end method

.method public final getSessionId()Ljava/lang/String;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->sessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    .line 20
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final setFile64(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->file64:Ljava/lang/String;

    return-void
.end method

.method public final setImageUrl(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->imageUrl:Ljava/lang/String;

    return-void
.end method

.method public final setPromptType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->promptType:Ljava/lang/String;

    return-void
.end method

.method public final setSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 23
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->sessionId:Ljava/lang/String;

    return-void
.end method

.method public final setText(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 20
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiGoodsParam;->text:Ljava/lang/String;

    return-void
.end method
