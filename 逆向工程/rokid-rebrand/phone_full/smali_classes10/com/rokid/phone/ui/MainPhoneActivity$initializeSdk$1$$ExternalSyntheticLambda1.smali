.class public final synthetic Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# instance fields
.field public final synthetic f$0:Lcom/rokid/phone/ui/MainPhoneActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda1;->f$0:Lcom/rokid/phone/ui/MainPhoneActivity;

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda1;->f$0:Lcom/rokid/phone/ui/MainPhoneActivity;

    check-cast p1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    invoke-static {v0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->$r8$lambda$agUOCDuQHK8cjShWCGDLC7ag0zQ(Lcom/rokid/phone/ui/MainPhoneActivity;Lcom/rokid/security/phone/sdk/base/data/callback/IResult;)Lkotlin/Unit;

    move-result-object p1

    return-object p1
.end method
