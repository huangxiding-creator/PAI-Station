.class public final Lcom/rokid/security/sdk/ability/param/AiChatParam;
.super Ljava/lang/Object;
.source "AiChatParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0010\u000b\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\"\u0010\t\u001a\n\u0012\u0004\u0012\u00020\u000b\u0018\u00010\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000c\u0010\r\"\u0004\u0008\u000e\u0010\u000fR\u001a\u0010\u0010\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u0006\"\u0004\u0008\u0012\u0010\u0008R\u001a\u0010\u0013\u001a\u00020\u0014X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0015\u0010\u0016\"\u0004\u0008\u0017\u0010\u0018\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/AiChatParam;",
        "",
        "()V",
        "appId",
        "",
        "getAppId",
        "()Ljava/lang/String;",
        "setAppId",
        "(Ljava/lang/String;)V",
        "messages",
        "",
        "Lcom/rokid/security/sdk/ability/param/AiMessages;",
        "getMessages",
        "()Ljava/util/List;",
        "setMessages",
        "(Ljava/util/List;)V",
        "modelName",
        "getModelName",
        "setModelName",
        "update",
        "",
        "getUpdate",
        "()Z",
        "setUpdate",
        "(Z)V",
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
.field private appId:Ljava/lang/String;

.field private messages:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/ability/param/AiMessages;",
            ">;"
        }
    .end annotation
.end field

.field private modelName:Ljava/lang/String;

.field private update:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    const-string v0, "A"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->modelName:Ljava/lang/String;

    .line 12
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->appId:Ljava/lang/String;

    .line 8
    return-void
.end method


# virtual methods
.method public final getAppId()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->appId:Ljava/lang/String;

    return-object v0
.end method

.method public final getMessages()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/ability/param/AiMessages;",
            ">;"
        }
    .end annotation

    .line 13
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->messages:Ljava/util/List;

    return-object v0
.end method

.method public final getModelName()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->modelName:Ljava/lang/String;

    return-object v0
.end method

.method public final getUpdate()Z
    .locals 1

    .line 15
    iget-boolean v0, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->update:Z

    return v0
.end method

.method public final setAppId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->appId:Ljava/lang/String;

    return-void
.end method

.method public final setMessages(Ljava/util/List;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/security/sdk/ability/param/AiMessages;",
            ">;)V"
        }
    .end annotation

    .line 13
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->messages:Ljava/util/List;

    return-void
.end method

.method public final setModelName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->modelName:Ljava/lang/String;

    return-void
.end method

.method public final setUpdate(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 15
    iput-boolean p1, p0, Lcom/rokid/security/sdk/ability/param/AiChatParam;->update:Z

    return-void
.end method
