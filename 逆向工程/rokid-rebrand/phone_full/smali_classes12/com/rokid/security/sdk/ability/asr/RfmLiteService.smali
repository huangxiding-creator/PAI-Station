.class public final Lcom/rokid/security/sdk/ability/asr/RfmLiteService;
.super Landroid/app/Service;
.source "RfmLiteService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/asr/RfmLiteService$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000-\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0003*\u0001\u0004\u0018\u0000 \u000f2\u00020\u0001:\u0001\u000fB\u0005\u00a2\u0006\u0002\u0010\u0002J\u0012\u0010\u0008\u001a\u00020\t2\u0008\u0010\n\u001a\u0004\u0018\u00010\u000bH\u0016J\u0008\u0010\u000c\u001a\u00020\rH\u0016J\u0008\u0010\u000e\u001a\u00020\rH\u0016R\u0010\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0005R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/asr/RfmLiteService;",
        "Landroid/app/Service;",
        "()V",
        "binder",
        "com/rokid/security/sdk/ability/asr/RfmLiteService$binder$1",
        "Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;",
        "gson",
        "Lcom/google/gson/Gson;",
        "onBind",
        "Landroid/os/IBinder;",
        "intent",
        "Landroid/content/Intent;",
        "onCreate",
        "",
        "onDestroy",
        "Companion",
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


# static fields
.field private static final Companion:Lcom/rokid/security/sdk/ability/asr/RfmLiteService$Companion;

.field public static final TAG:Ljava/lang/String; = "RfmLiteService"
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field


# instance fields
.field private final binder:Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;

.field private final gson:Lcom/google/gson/Gson;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->Companion:Lcom/rokid/security/sdk/ability/asr/RfmLiteService$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 11
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 12
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->gson:Lcom/google/gson/Gson;

    .line 14
    new-instance v0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;

    invoke-direct {v0, p0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;-><init>(Lcom/rokid/security/sdk/ability/asr/RfmLiteService;)V

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->binder:Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;

    .line 11
    return-void
.end method

.method public static final synthetic access$getGson$p(Lcom/rokid/security/sdk/ability/asr/RfmLiteService;)Lcom/google/gson/Gson;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/security/sdk/ability/asr/RfmLiteService;

    .line 11
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->gson:Lcom/google/gson/Gson;

    return-object v0
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    .param p1, "intent"    # Landroid/content/Intent;

    .line 49
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->binder:Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;

    check-cast v0, Landroid/os/IBinder;

    return-object v0
.end method

.method public onCreate()V
    .locals 2

    .line 45
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 46
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "onCreate pid="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "RfmLiteService"

    invoke-static {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 47
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteService;->binder:Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteService$binder$1;->release()V

    .line 53
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 54
    return-void
.end method
