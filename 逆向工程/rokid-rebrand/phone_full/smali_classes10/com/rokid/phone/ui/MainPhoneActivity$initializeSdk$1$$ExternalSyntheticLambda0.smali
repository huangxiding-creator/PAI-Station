.class public final synthetic Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

.field public final synthetic f$1:Lcom/rokid/phone/ui/MainPhoneActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/security/phone/sdk/base/data/callback/IResult;Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    iput-object p2, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;->f$1:Lcom/rokid/phone/ui/MainPhoneActivity;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    iget-object v1, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;->f$1:Lcom/rokid/phone/ui/MainPhoneActivity;

    invoke-static {v0, v1}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->$r8$lambda$1KHBGrYyTZeI1MnS7A37jsgooE0(Lcom/rokid/security/phone/sdk/base/data/callback/IResult;Lcom/rokid/phone/ui/MainPhoneActivity;)V

    return-void
.end method
