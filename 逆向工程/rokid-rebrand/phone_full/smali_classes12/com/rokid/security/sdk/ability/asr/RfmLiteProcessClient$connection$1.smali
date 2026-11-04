.class public final Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1;
.super Ljava/lang/Object;
.source "RfmLiteProcessClient.kt"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0012\u0010\u0002\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J\u0012\u0010\u0006\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016J\u001c\u0010\u0007\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u00052\u0008\u0010\u0008\u001a\u0004\u0018\u00010\tH\u0016J\u0012\u0010\n\u001a\u00020\u00032\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005H\u0016\u00a8\u0006\u000b"
    }
    d2 = {
        "com/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1",
        "Landroid/content/ServiceConnection;",
        "onBindingDied",
        "",
        "name",
        "Landroid/content/ComponentName;",
        "onNullBinding",
        "onServiceConnected",
        "service",
        "Landroid/os/IBinder;",
        "onServiceDisconnected",
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
.method public static synthetic $r8$lambda$GHStQxQJ_2vjjIE-B6lvUmhaYd0(Landroid/os/IBinder;)V
    .locals 0

    invoke-static {p0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1;->onServiceConnected$lambda$0(Landroid/os/IBinder;)V

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static final onServiceConnected$lambda$0(Landroid/os/IBinder;)V
    .locals 3
    .param p0, "$service"    # Landroid/os/IBinder;

    .line 53
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-static {v0, p0, v1, v2, v1}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->invalidateRemote$default(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;Landroid/os/IBinder;Ljava/lang/Integer;ILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 54
    const-string v0, "remote RFM Lite binder died"

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "RfmLiteProcessClient"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 56
    :cond_0
    return-void
.end method


# virtual methods
.method public onBindingDied(Landroid/content/ComponentName;)V
    .locals 3
    .param p1, "name"    # Landroid/content/ComponentName;

    .line 119
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    const/4 v1, 0x0

    const/4 v2, 0x3

    invoke-static {v0, v1, v1, v2, v1}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->invalidateRemote$default(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;Landroid/os/IBinder;Ljava/lang/Integer;ILjava/lang/Object;)Z

    .line 120
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$unbindInvalidConnection(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;)V

    .line 121
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$bindIfNeeded(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;)V

    .line 122
    return-void
.end method

.method public onNullBinding(Landroid/content/ComponentName;)V
    .locals 3
    .param p1, "name"    # Landroid/content/ComponentName;

    .line 125
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    const/4 v1, 0x0

    const/4 v2, 0x3

    invoke-static {v0, v1, v1, v2, v1}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->invalidateRemote$default(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;Landroid/os/IBinder;Ljava/lang/Integer;ILjava/lang/Object;)Z

    .line 126
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$unbindInvalidConnection(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;)V

    .line 127
    return-void
.end method

.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 18
    .param p1, "name"    # Landroid/content/ComponentName;
    .param p2, "service"    # Landroid/os/IBinder;

    .line 50
    move-object/from16 v7, p2

    if-nez v7, :cond_0

    return-void

    .line 51
    :cond_0
    invoke-static/range {p2 .. p2}, Lcom/rokid/security/sdk/ability/asr/IRfmLiteService$Stub;->asInterface(Landroid/os/IBinder;)Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;

    move-result-object v8

    .line 52
    .local v8, "target":Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$$ExternalSyntheticLambda0;

    invoke-direct {v0, v7}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$$ExternalSyntheticLambda0;-><init>(Landroid/os/IBinder;)V

    move-object v9, v0

    .line 57
    .local v9, "deathRecipient":Landroid/os/IBinder$DeathRecipient;
    nop

    .line 58
    const/4 v0, 0x0

    :try_start_0
    invoke-interface {v7, v9, v0}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 62
    new-instance v1, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    move-object v10, v1

    .line 63
    .local v10, "generation":Lkotlin/jvm/internal/Ref$IntRef;
    new-instance v1, Lkotlin/jvm/internal/Ref$ObjectRef;

    invoke-direct {v1}, Lkotlin/jvm/internal/Ref$ObjectRef;-><init>()V

    move-object v11, v1

    .line 64
    .local v11, "deviceId":Lkotlin/jvm/internal/Ref$ObjectRef;
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getLock$p()Ljava/lang/Object;

    move-result-object v1

    monitor-enter v1

    const/4 v2, 0x0

    .line 65
    .local v2, "$i$a$-synchronized-RfmLiteProcessClient$connection$1$onServiceConnected$1":I
    :try_start_1
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v3}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$unlinkDeathRecipientLocked(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;)V

    .line 66
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getConnectionGeneration$p()I

    move-result v3

    const/4 v4, 0x1

    add-int/2addr v3, v4

    invoke-static {v3}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setConnectionGeneration$p(I)V

    .line 67
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getConnectionGeneration$p()I

    move-result v3

    iput v3, v10, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .line 68
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static/range {p2 .. p2}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setConnectedBinder$p(Landroid/os/IBinder;)V

    .line 69
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v9}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setConnectedDeathRecipient$p(Landroid/os/IBinder$DeathRecipient;)V

    .line 70
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    const/4 v3, 0x0

    invoke-static {v3}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setRemote$p(Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;)V

    .line 71
    sget-object v3, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setBinding$p(Z)V

    .line 72
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    invoke-static {v4}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$setBindRegistered$p(Z)V

    .line 73
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getPendingDeviceId$p()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 74
    nop

    .end local v2    # "$i$a$-synchronized-RfmLiteProcessClient$connection$1$onServiceConnected$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 64
    monitor-exit v1

    .line 75
    iget-object v0, v11, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    if-nez v0, :cond_1

    .line 76
    const-string v0, "RfmLiteProcessClient"

    const-string v1, "remote RFM Lite connected without pending initialization"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 77
    return-void

    .line 81
    :cond_1
    invoke-static {}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->access$getRemoteScope$p()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v12

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;

    const/4 v6, 0x0

    move-object v1, v0

    move-object v2, v8

    move-object v3, v11

    move-object/from16 v4, p2

    move-object v5, v10

    invoke-direct/range {v1 .. v6}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$onServiceConnected$2;-><init>(Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;Lkotlin/jvm/internal/Ref$ObjectRef;Landroid/os/IBinder;Lkotlin/jvm/internal/Ref$IntRef;Lkotlin/coroutines/Continuation;)V

    move-object v15, v0

    check-cast v15, Lkotlin/jvm/functions/Function2;

    const/16 v16, 0x3

    const/16 v17, 0x0

    const/4 v13, 0x0

    const/4 v14, 0x0

    invoke-static/range {v12 .. v17}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 111
    const-string v0, "RfmLiteProcessClient"

    const-string v1, "remote RFM Lite binder connected"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    return-void

    .line 64
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0

    .line 59
    .end local v10    # "generation":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v11    # "deviceId":Lkotlin/jvm/internal/Ref$ObjectRef;
    :catch_0
    move-exception v0

    move-object v1, v0

    move-object v0, v1

    .line 60
    .local v0, "_":Landroid/os/RemoteException;
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 3
    .param p1, "name"    # Landroid/content/ComponentName;

    .line 115
    sget-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->INSTANCE:Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;

    const/4 v1, 0x0

    const/4 v2, 0x3

    invoke-static {v0, v1, v1, v2, v1}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;->invalidateRemote$default(Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient;Landroid/os/IBinder;Ljava/lang/Integer;ILjava/lang/Object;)Z

    .line 116
    return-void
.end method
