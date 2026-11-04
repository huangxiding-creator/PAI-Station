.class public final synthetic Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/os/IBinder$DeathRecipient;


# instance fields
.field public final synthetic f$0:Landroid/os/IBinder;


# direct methods
.method public synthetic constructor <init>(Landroid/os/IBinder;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$$ExternalSyntheticLambda0;->f$0:Landroid/os/IBinder;

    return-void
.end method


# virtual methods
.method public final binderDied()V
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1$$ExternalSyntheticLambda0;->f$0:Landroid/os/IBinder;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/asr/RfmLiteProcessClient$connection$1;->$r8$lambda$GHStQxQJ_2vjjIE-B6lvUmhaYd0(Landroid/os/IBinder;)V

    return-void
.end method
