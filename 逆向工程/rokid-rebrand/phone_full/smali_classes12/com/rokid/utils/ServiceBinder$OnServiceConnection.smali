.class public interface abstract Lcom/rokid/utils/ServiceBinder$OnServiceConnection;
.super Ljava/lang/Object;
.source "ServiceBinder.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/utils/ServiceBinder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "OnServiceConnection"
.end annotation


# virtual methods
.method public abstract onConnected(Landroid/os/IBinder;)V
.end method

.method public abstract onDisconnected()V
.end method
