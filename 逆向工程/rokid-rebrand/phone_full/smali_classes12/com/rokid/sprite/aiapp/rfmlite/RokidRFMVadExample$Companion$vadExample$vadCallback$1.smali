.class public final Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1;
.super Ljava/lang/Object;
.source "RokidRFMVadExample.kt"

# interfaces
.implements Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion;->vadExample(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1$WhenMappings;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0017\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u0006"
    }
    d2 = {
        "com/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1",
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadCallback;",
        "onVadResult",
        "",
        "result",
        "Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;",
        "lib-rfmlite_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onVadResult(Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;)Z
    .locals 4
    .param p1, "result"    # Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;

    const-string v0, "result"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "VAD\u4e34\u65f6\u7ed3\u679c: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    const-string v3, "RokidRFMVadExample"

    invoke-static {v3, v0, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 36
    invoke-virtual {p1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadTmpResult;->getVadStatus()Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;

    move-result-object v0

    sget-object v2, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVadExample$Companion$vadExample$vadCallback$1$WhenMappings;->$EnumSwitchMapping$0:[I

    invoke-virtual {v0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMVad$VadStatus;->ordinal()I

    move-result v0

    aget v0, v2, v0

    const/4 v2, 0x1

    packed-switch v0, :pswitch_data_0

    .line 51
    new-instance v0, Lkotlin/NoWhenBranchMatchedException;

    invoke-direct {v0}, Lkotlin/NoWhenBranchMatchedException;-><init>()V

    throw v0

    .line 50
    :pswitch_0
    const-string v0, "VAD\u72b6\u6001: ERROR - \u914d\u7f6e\u6587\u4ef6\u4e0d\u5b58\u5728"

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v3, v0, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 51
    return v1

    .line 46
    :pswitch_1
    const-string v0, "VAD\u72b6\u6001: WAIT_TIMEOUT - \u7b49\u5f85\u8d85\u65f6\uff0c\u7ed3\u675f\u4f1a\u8bdd"

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {v3, v0, v2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 47
    return v1

    .line 42
    :pswitch_2
    const-string v0, "VAD\u72b6\u6001: WAIT - \u7b49\u5f85\u7528\u6237\u7ee7\u7eed\u8bf4\u8bdd"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 43
    return v2

    .line 38
    :pswitch_3
    const-string v0, "VAD\u72b6\u6001: NONE - \u65e0\u6cd5\u5224\u65ad\uff0c\u4ee5\u4e91\u7aefVAD\u4e3a\u51c6"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v3, v0, v1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 39
    return v2

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
