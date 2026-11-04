.class public Lcom/rokid/utils/ServiceBinder;
.super Ljava/lang/Object;
.source "ServiceBinder.java"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/utils/ServiceBinder$OnServiceConnection;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z


# instance fields
.field private conn:Landroid/content/ServiceConnection;

.field private intent:Landroid/content/Intent;

.field private listener:Lcom/rokid/utils/ServiceBinder$OnServiceConnection;

.field private mContextRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/content/Context;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    .line 18
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 45
    new-instance v0, Lcom/rokid/utils/ServiceBinder$1;

    invoke-direct {v0, p0}, Lcom/rokid/utils/ServiceBinder$1;-><init>(Lcom/rokid/utils/ServiceBinder;)V

    iput-object v0, p0, Lcom/rokid/utils/ServiceBinder;->conn:Landroid/content/ServiceConnection;

    return-void
.end method

.method static synthetic access$000(Lcom/rokid/utils/ServiceBinder;)Lcom/rokid/utils/ServiceBinder$OnServiceConnection;
    .locals 1
    .param p0, "x0"    # Lcom/rokid/utils/ServiceBinder;

    .line 19
    iget-object v0, p0, Lcom/rokid/utils/ServiceBinder;->listener:Lcom/rokid/utils/ServiceBinder$OnServiceConnection;

    return-object v0
.end method

.method private rebind()V
    .locals 4

    .line 39
    iget-object v0, p0, Lcom/rokid/utils/ServiceBinder;->mContextRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 41
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/ServiceBinder;->mContextRef:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    iget-object v1, p0, Lcom/rokid/utils/ServiceBinder;->intent:Landroid/content/Intent;

    iget-object v2, p0, Lcom/rokid/utils/ServiceBinder;->conn:Landroid/content/ServiceConnection;

    const/4 v3, 0x1

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    .line 43
    return-void
.end method


# virtual methods
.method public bind(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/utils/ServiceBinder$OnServiceConnection;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "packageName"    # Ljava/lang/String;
    .param p3, "className"    # Ljava/lang/String;
    .param p4, "onServiceConnection"    # Lcom/rokid/utils/ServiceBinder$OnServiceConnection;

    .line 26
    if-eqz p1, :cond_1

    .line 27
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/rokid/utils/ServiceBinder;->mContextRef:Ljava/lang/ref/WeakReference;

    .line 28
    iput-object p4, p0, Lcom/rokid/utils/ServiceBinder;->listener:Lcom/rokid/utils/ServiceBinder$OnServiceConnection;

    .line 30
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 31
    .local v0, "intent":Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;

    invoke-direct {v1, p2, p3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 32
    iput-object v0, p0, Lcom/rokid/utils/ServiceBinder;->intent:Landroid/content/Intent;

    .line 33
    iget-object v1, p0, Lcom/rokid/utils/ServiceBinder;->conn:Landroid/content/ServiceConnection;

    const/4 v2, 0x1

    invoke-virtual {p1, v0, v1, v2}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 36
    return-void

    .line 34
    :cond_0
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "the service is not exist"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 26
    .end local v0    # "intent":Landroid/content/Intent;
    :cond_1
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method

.method public binderDied()V
    .locals 0

    .line 66
    invoke-direct {p0}, Lcom/rokid/utils/ServiceBinder;->rebind()V

    .line 67
    return-void
.end method
