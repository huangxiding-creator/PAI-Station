.class final Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;
.super Ljava/lang/Object;
.source "AsrManager.kt"

# interfaces
.implements Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/asr/AsrManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "MyAsrListener"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0006\u0008\u0002\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u001a\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016J\u0012\u0010\t\u001a\u00020\u00042\u0008\u0010\n\u001a\u0004\u0018\u00010\u0008H\u0016J\u0008\u0010\u000b\u001a\u00020\u0004H\u0016J\u0012\u0010\u000c\u001a\u00020\u00042\u0008\u0010\n\u001a\u0004\u0018\u00010\u0008H\u0016J\u0008\u0010\r\u001a\u00020\u0004H\u0016\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/AsrManager$MyAsrListener;",
        "Lcom/rokid/security/sdk/ability/asr/AsrConnectClient$AsrListener;",
        "()V",
        "onError",
        "",
        "code",
        "",
        "message",
        "",
        "onFinalResult",
        "text",
        "onFinish",
        "onPartialResult",
        "onStart",
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


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 428
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(ILjava/lang/String;)V
    .locals 2
    .param p1, "code"    # I
    .param p2, "message"    # Ljava/lang/String;

    .line 451
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MyAsrListener onError-->"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 452
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$setCurStart$p(Z)V

    .line 453
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$onError(Lcom/rokid/security/sdk/ability/asr/AsrManager;I)V

    .line 454
    return-void
.end method

.method public onFinalResult(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    .line 444
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MyAsrListener onFinalResult chars="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " active="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$isCurStart$p()Z

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "AsrManager::"

    invoke-static {v2, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 445
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$isCurStart$p()Z

    move-result v0

    if-eqz v0, :cond_3

    if-eqz p1, :cond_2

    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    const/4 v2, 0x1

    if-lez v0, :cond_1

    move v0, v2

    goto :goto_1

    :cond_1
    move v0, v1

    :goto_1
    if-ne v0, v2, :cond_2

    move v1, v2

    :cond_2
    if-eqz v1, :cond_3

    .line 446
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$onAsrComplete(Lcom/rokid/security/sdk/ability/asr/AsrManager;Ljava/lang/String;)V

    .line 448
    :cond_3
    return-void
.end method

.method public onFinish()V
    .locals 2

    .line 459
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    const/4 v0, 0x0

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$setCurStart$p(Z)V

    .line 460
    const-string v0, "MyAsrListener onFinish-->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 461
    return-void
.end method

.method public onPartialResult(Ljava/lang/String;)V
    .locals 3
    .param p1, "text"    # Ljava/lang/String;

    .line 436
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "MyAsrListener onPartialResult chars="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    goto :goto_0

    :cond_0
    move v2, v1

    :goto_0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, " active="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$isCurStart$p()Z

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "AsrManager::"

    invoke-static {v2, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 437
    if-eqz p1, :cond_2

    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-lez v0, :cond_1

    const/4 v1, 0x1

    :cond_1
    if-eqz v1, :cond_2

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$isCurStart$p()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 438
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-static {v0, p1}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$onIntermediateVad(Lcom/rokid/security/sdk/ability/asr/AsrManager;Ljava/lang/String;)V

    .line 441
    :cond_2
    return-void
.end method

.method public onStart()V
    .locals 2

    .line 430
    const-string v0, "MyAsrListener onStart-->"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "AsrManager::"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 431
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$setCurStart$p(Z)V

    .line 432
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/AsrManager;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/AsrManager;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/AsrManager;->access$onStart(Lcom/rokid/security/sdk/ability/asr/AsrManager;)V

    .line 433
    return-void
.end method
