.class Lcom/rokid/utils/ServiceBinder$1;
.super Ljava/lang/Object;
.source "ServiceBinder.java"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/utils/ServiceBinder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/utils/ServiceBinder;


# direct methods
.method constructor <init>(Lcom/rokid/utils/ServiceBinder;)V
    .locals 0
    .param p1, "this$0"    # Lcom/rokid/utils/ServiceBinder;

    .line 45
    iput-object p1, p0, Lcom/rokid/utils/ServiceBinder$1;->this$0:Lcom/rokid/utils/ServiceBinder;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 2
    .param p1, "name"    # Landroid/content/ComponentName;
    .param p2, "service"    # Landroid/os/IBinder;

    .line 48
    if-nez p2, :cond_0

    return-void

    .line 51
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/ServiceBinder$1;->this$0:Lcom/rokid/utils/ServiceBinder;

    const/4 v1, 0x0

    invoke-interface {p2, v0, v1}, Landroid/os/IBinder;->linkToDeath(Landroid/os/IBinder$DeathRecipient;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    .line 54
    goto :goto_0

    .line 52
    :catch_0
    move-exception v0

    .line 53
    .local v0, "e":Landroid/os/RemoteException;
    invoke-virtual {v0}, Landroid/os/RemoteException;->printStackTrace()V

    .line 55
    .end local v0    # "e":Landroid/os/RemoteException;
    :goto_0
    iget-object v0, p0, Lcom/rokid/utils/ServiceBinder$1;->this$0:Lcom/rokid/utils/ServiceBinder;

    invoke-static {v0}, Lcom/rokid/utils/ServiceBinder;->access$000(Lcom/rokid/utils/ServiceBinder;)Lcom/rokid/utils/ServiceBinder$OnServiceConnection;

    move-result-object v0

    invoke-interface {v0, p2}, Lcom/rokid/utils/ServiceBinder$OnServiceConnection;->onConnected(Landroid/os/IBinder;)V

    .line 56
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1
    .param p1, "name"    # Landroid/content/ComponentName;

    .line 60
    iget-object v0, p0, Lcom/rokid/utils/ServiceBinder$1;->this$0:Lcom/rokid/utils/ServiceBinder;

    invoke-static {v0}, Lcom/rokid/utils/ServiceBinder;->access$000(Lcom/rokid/utils/ServiceBinder;)Lcom/rokid/utils/ServiceBinder$OnServiceConnection;

    move-result-object v0

    invoke-interface {v0}, Lcom/rokid/utils/ServiceBinder$OnServiceConnection;->onDisconnected()V

    .line 61
    return-void
.end method
