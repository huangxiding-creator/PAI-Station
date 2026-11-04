.class public final Lcom/rokid/security/sdk/base/common/aichat/Metadata;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0008\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000eR\u001a\u0010\u000f\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0010\u0010\u0006\"\u0004\u0008\u0011\u0010\u0008\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/Metadata;",
        "",
        "()V",
        "inputTokens",
        "",
        "getInputTokens",
        "()I",
        "setInputTokens",
        "(I)V",
        "modelName",
        "",
        "getModelName",
        "()Ljava/lang/String;",
        "setModelName",
        "(Ljava/lang/String;)V",
        "outputTokens",
        "getOutputTokens",
        "setOutputTokens",
        "sdk-base-common_release"
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
.field private inputTokens:I

.field private modelName:Ljava/lang/String;

.field private outputTokens:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 137
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 140
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->modelName:Ljava/lang/String;

    .line 137
    return-void
.end method


# virtual methods
.method public final getInputTokens()I
    .locals 1

    .line 141
    iget v0, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->inputTokens:I

    return v0
.end method

.method public final getModelName()Ljava/lang/String;
    .locals 1

    .line 140
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->modelName:Ljava/lang/String;

    return-object v0
.end method

.method public final getOutputTokens()I
    .locals 1

    .line 142
    iget v0, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->outputTokens:I

    return v0
.end method

.method public final setInputTokens(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 141
    iput p1, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->inputTokens:I

    return-void
.end method

.method public final setModelName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 140
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->modelName:Ljava/lang/String;

    return-void
.end method

.method public final setOutputTokens(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 142
    iput p1, p0, Lcom/rokid/security/sdk/base/common/aichat/Metadata;->outputTokens:I

    return-void
.end method
