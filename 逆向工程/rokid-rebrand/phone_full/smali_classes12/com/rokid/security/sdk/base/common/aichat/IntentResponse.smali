.class public final Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;
.super Ljava/lang/Object;
.source "Choice.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;",
        "",
        "()V",
        "confidence",
        "",
        "getConfidence",
        "()F",
        "setConfidence",
        "(F)V",
        "intent",
        "",
        "getIntent",
        "()Ljava/lang/String;",
        "setIntent",
        "(Ljava/lang/String;)V",
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
.field private confidence:F

.field private intent:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 180
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 183
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->intent:Ljava/lang/String;

    .line 180
    return-void
.end method


# virtual methods
.method public final getConfidence()F
    .locals 1

    .line 184
    iget v0, p0, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->confidence:F

    return v0
.end method

.method public final getIntent()Ljava/lang/String;
    .locals 1

    .line 183
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->intent:Ljava/lang/String;

    return-object v0
.end method

.method public final setConfidence(F)V
    .locals 0
    .param p1, "<set-?>"    # F

    .line 184
    iput p1, p0, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->confidence:F

    return-void
.end method

.method public final setIntent(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 183
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/aichat/IntentResponse;->intent:Ljava/lang/String;

    return-void
.end method
