.class public final Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;
.super Lcom/rokid/security/sdk/ability/asr/IRfmLiteService$Stub;
.source "RfmLiteService.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/asr/RfmLiteService;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRfmLiteService.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RfmLiteService.kt\ncom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,60:1\n1#2:61\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\'\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0000*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J0\u0010\u0006\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u00052\u0006\u0010\u0008\u001a\u00020\t2\u0008\u0010\n\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0005H\u0016J\u0008\u0010\u000c\u001a\u00020\rH\u0016\u00a8\u0006\u000e"
    }
    d2 = {
        "com/rokid/security/sdk/ability/asr/RfmLiteService$binder$1",
        "Lcom/rokid/security/sdk/ability/asr/IRfmLiteService$Stub;",
        "create",
        "",
        "deviceId",
        "",
        "predict",
        "input",
        "scene",
        "",
        "sessionId",
        "traceId",
        "release",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/security/sdk/ability/asr/RfmLiteService;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/asr/RfmLiteService;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/sdk/ability/asr/RfmLiteService;

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;->this$0:Lcom/rokid/security/sdk/ability/asr/RfmLiteService;

    .line 14
    invoke-direct {p0}, Lcom/rokid/security/sdk/ability/asr/IRfmLiteService$Stub;-><init>()V

    return-void
.end method


# virtual methods
.method public create(Ljava/lang/String;)Z
    .locals 4
    .param p1, "deviceId"    # Ljava/lang/String;

    .line 16
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v1

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    if-eqz v0, :cond_2

    return v1

    .line 17
    :cond_2
    nop

    .line 18
    :try_start_0
    invoke-static {}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->getInstance()Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    move-result-object v0

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;->this$0:Lcom/rokid/security/sdk/ability/asr/RfmLiteService;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v0, v2, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->create(Landroid/content/Context;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    .line 19
    :catchall_0
    move-exception v0

    .line 20
    .local v0, "t":Ljava/lang/Throwable;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "create failed type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "RfmLiteService"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 21
    nop

    .line 17
    .end local v0    # "t":Ljava/lang/Throwable;
    :goto_2
    return v1
.end method

.method public predict(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "input"    # Ljava/lang/String;
    .param p2, "scene"    # I
    .param p3, "sessionId"    # Ljava/lang/String;
    .param p4, "traceId"    # Ljava/lang/String;

    .line 26
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    if-eqz v0, :cond_1

    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    const/4 v1, 0x0

    if-nez v0, :cond_4

    if-eqz p3, :cond_4

    if-nez p4, :cond_2

    goto :goto_3

    .line 27
    :cond_2
    nop

    .line 28
    :try_start_0
    invoke-static {}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->getInstance()Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->predict(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite$NluResult;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;->this$0:Lcom/rokid/security/sdk/ability/asr/RfmLiteService;

    invoke-static {v2}, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->access$getGson$p(Lcom/rokid/security/sdk/ability/asr/RfmLiteService;)Lcom/google/gson/Gson;

    move-result-object v2

    .line 61
    .local v0, "p0":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 28
    .local v3, "$i$a$-let-RfmLiteService$binder$1$predict$1":I
    invoke-virtual {v2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .end local v0    # "p0":Ljava/lang/Object;
    .end local v3    # "$i$a$-let-RfmLiteService$binder$1$predict$1":I
    goto :goto_2

    .line 29
    :catchall_0
    move-exception v0

    .line 30
    .local v0, "t":Ljava/lang/Throwable;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "predict failed type="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    const-string v3, "RfmLiteService"

    invoke-static {v3, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 31
    nop

    .line 27
    .end local v0    # "t":Ljava/lang/Throwable;
    :cond_3
    :goto_2
    return-object v1

    .line 26
    :cond_4
    :goto_3
    return-object v1
.end method

.method public release()V
    .locals 3

    .line 36
    nop

    .line 37
    :try_start_0
    invoke-static {}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->getInstance()Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/sprite/aiapp/rfmlite/RokidRFMLite;->release()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 38
    :catchall_0
    move-exception v0

    .line 39
    .local v0, "t":Ljava/lang/Throwable;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "release failed type="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "RfmLiteService"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 41
    .end local v0    # "t":Ljava/lang/Throwable;
    :goto_0
    return-void
.end method
