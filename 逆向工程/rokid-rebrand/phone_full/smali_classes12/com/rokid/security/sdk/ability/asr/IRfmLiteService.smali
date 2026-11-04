.class public interface abstract Lcom/rokid/security/sdk/ability/asr/IRfmLiteService;
.super Ljava/lang/Object;
.source "IRfmLiteService.java"

# interfaces
.implements Landroid/os/IInterface;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/asr/IRfmLiteService$Stub;,
        Lcom/rokid/security/sdk/ability/asr/IRfmLiteService$Default;
    }
.end annotation


# virtual methods
.method public abstract create(Ljava/lang/String;)Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method

.method public abstract predict(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method

.method public abstract release()V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation
.end method
