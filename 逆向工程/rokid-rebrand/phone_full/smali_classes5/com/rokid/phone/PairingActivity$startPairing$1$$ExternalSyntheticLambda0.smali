.class public final synthetic Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# instance fields
.field public final synthetic f$0:Lcom/rokid/phone/PairingActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/rokid/phone/PairingActivity;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/phone/PairingActivity;

    return-void
.end method


# virtual methods
.method public final invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    .line 0
    iget-object v0, p0, Lcom/rokid/phone/PairingActivity$startPairing$1$$ExternalSyntheticLambda0;->f$0:Lcom/rokid/phone/PairingActivity;

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    invoke-static {v0, p1}, Lcom/rokid/phone/PairingActivity$startPairing$1;->$r8$lambda$3PNWhwm7JzJfydfsmTEUA1eqyRU(Lcom/rokid/phone/PairingActivity;Z)Lkotlin/Unit;

    move-result-object p1

    return-object p1
.end method
