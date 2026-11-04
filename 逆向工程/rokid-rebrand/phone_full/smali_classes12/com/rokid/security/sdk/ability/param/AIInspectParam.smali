.class public final Lcom/rokid/security/sdk/ability/param/AIInspectParam;
.super Ljava/lang/Object;
.source "AiChatParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u000b\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001c\u0010\t\u001a\u0004\u0018\u00010\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u0006\"\u0004\u0008\u000e\u0010\u0008\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/AIInspectParam;",
        "",
        "()V",
        "promptType",
        "",
        "getPromptType",
        "()Ljava/lang/String;",
        "setPromptType",
        "(Ljava/lang/String;)V",
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
.field private promptType:Ljava/lang/String;

.field private sessionId:Ljava/lang/String;

.field private text:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->text:Ljava/lang/String;

    .line 30
    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->promptType:Ljava/lang/String;

    .line 27
    return-void
.end method


# virtual methods
.method public final getPromptType()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->promptType:Ljava/lang/String;

    return-object v0
.end method

.method public final getSessionId()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->sessionId:Ljava/lang/String;

    return-object v0
.end method

.method public final getText()Ljava/lang/String;
    .locals 1

    .line 28
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->text:Ljava/lang/String;

    return-object v0
.end method

.method public final setPromptType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 30
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->promptType:Ljava/lang/String;

    return-void
.end method

.method public final setSessionId(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 29
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->sessionId:Ljava/lang/String;

    return-void
.end method

.method public final setText(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 28
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AIInspectParam;->text:Ljava/lang/String;

    return-void
.end method
